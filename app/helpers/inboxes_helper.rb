require 'net/http'
module InboxesHelper
  def inboxes_faye_broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => defined?(FAYE_TOKEN) ? FAYE_TOKEN : ""}}
    uri = URI.parse("http://#{Inboxes::config.faye_host}:#{Inboxes::config.faye_port}/faye")
    resource = Net::HTTP.post_form(uri, :message => message.to_json)
  end
end