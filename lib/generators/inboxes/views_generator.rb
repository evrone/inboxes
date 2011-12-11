require 'rails/generators'

module Inboxes
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../app/views', __FILE__)
      #class_option :template_engine, :type => :string, :aliases => '-e', :desc => 'Template engine for the views. Available options are "erb" and "haml".'

      # TODO support of both haml and erb
      def copy_or_fetch
        filename_pattern = File.join self.class.source_root, "*" #/*.html.#{template_engine}"
        Dir.glob(filename_pattern).map {|f| File.basename f}.each do |f|
          directory f.to_s, "app/views/#{f}"
        end
      end

      # private

      # def template_engine
      #   # options[:template_engine].try(:to_s).try(:downcase) || 'erb'
      # end
    end
  end
end