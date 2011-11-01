
class Discussion < ActiveRecord::Base
  attr_accessor :recipient_tokens, :recipient_ids
  attr_reader :recipient_ids

  # paginates_per 10

  # создатель
  has_many :messages, :dependent => :destroy

  # участники
  has_many :speakers, :dependent => :destroy
  has_many :users, :through => :speakers

  # отметки о прочтении юзеров
  has_many :views, :dependent => :destroy, :class_name => "DiscussionView"
  
  scope :unread_for, (lambda do |user_or_user_id|
    user = user_or_user_id.is_a?(User) ? user_or_user_id.id : user_or_user_id
    joins(:views, :speakers).where("discussions.updated_at >= discussion_views.updated_at AND speakers.user_id = ? AND discussion_views.user_id = ?", user, user)
  end)

  accepts_nested_attributes_for :messages

  validate :check_that_has_at_least_two_users # не даем создать дискуссию, у которой нет получателей

  # добавляем записи об указанных собеседников
  after_save(:on => :create) do
    Rails.logger.info("Repicients ids: #{recipient_ids.inspect}")

    if recipient_ids.kind_of?(Array)
      recipient_ids.uniq!
      recipient_ids.each do |id|
        recipient = User.find(id)
        add_speaker(recipient) if recipient
      end
    end
  end

  def recipient_tokens=(ids)
    self.recipient_ids = ids
  end

  def add_recipient_token id
    self.recipient_ids << id if self.recipient_ids
  end

  def add_speaker(user)
    raise ArgumentError, "You can add speaker only to existing Discussion. Save your the Discussion object firstly" if new_record?
    Speaker.create(:discussion => self, :user => user)
  end

  def remove_speaker(user)
    speaker = find_speaker_by_user(user)
    speaker.destroy if speaker
  end

  def user_invited_at(user)
    speaker = find_speaker_by_user(user)
    speaker.created_at
  end

  def can_participate?(user)
    speaker = find_speaker_by_user(user)
    speaker ? true : false
  end

  # проверяет, есть ли уже беседа между пользователями
  # TODO вынести в отдельный метод а в этом возращать true/false, а то неправославно как-то
  def self.find_between_users(user, user2)
    dialog = nil
    discussions = self.joins(:speakers).includes(:users).where("speakers.user_id = ?", user.id)
    Rails.logger.info "Searching for ids: #{user.id}, #{user2.id}"
    discussions.each do |discussion|
      dialog = discussion if discussion.private? && ((discussion.users.first == user && discussion.users.last == user2) || (discussion.users.first == user2 && discussion.users.last == user))
    end
    dialog
  end

  # приватная/групповая
  def private?
    self.users.size <= 2
  end

  # дата последнего сообщения в дискуссии
  # def last_message_at
  #   self.messages.last ? self.messages.last.created_at : nil
  # end

  # проверка, является ли дискуссия непрочитанной для пользователя
  def unread_for?(user)
    flag = self.views.find_by_user_id(user.id)
    if flag
      self.updated_at >= flag.updated_at
    else
      true
    end
  end

  # пометить как прочитанная
  def mark_as_read_for(user)
    true
  #   flag = DiscussionView.find_or_create_by_user_id_and_discussion_id(user.id, self.id)
  #   flag.touch
  end

  private

  def find_speaker_by_user user
    Speaker.find_by_discussion_id_and_user_id(self.id, user.id)
  end

  def check_that_has_at_least_two_users
    Rails.logger.info self.recipient_ids
    errors.add :recipient_tokens, "Укажите хотя бы одного получателя" if !self.recipient_ids || self.recipient_ids.size < 2
  end

end