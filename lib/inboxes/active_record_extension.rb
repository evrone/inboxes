module Inboxes
  module ActiveRecordExtension
    def inboxes(options = {})
      # field  = options[:as]     || name
      # prefix = options[:prefix] || "with"
      
      has_many :speakers, :dependent => :destroy
      has_many :discussions, :through => :speakers
    end
  end
end