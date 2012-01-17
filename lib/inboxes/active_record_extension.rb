module Inboxes
  module ActiveRecordExtension
    def has_inboxes(options = {})
      # field  = options[:as]     || name
      # prefix = options[:prefix] || "with"

      has_many :speakers, :dependent => :destroy
      has_many :discussions, :through => :speakers
    end

    def acts_as_discussable
      has_many :discussions, :as => :discussable
    end
  end
end
