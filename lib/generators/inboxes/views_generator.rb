require 'rails/generators'

module Inboxes
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      source_root File.expand_path('../../../../app/views', __FILE__)
      class_option :template_engine, :type => :string, :aliases => '-e', :desc => 'Template engine for the views. Available options are "erb" and "haml".'
      
      def copy_or_fetch
        # filename_pattern = File.join self.class.source_root, "discussions", "*.html.#{template_engine}"
        # puts Dir.glob(filename_pattern).map {|f| File.basename f}.inspect
        # Dir.glob(filename_pattern).map {|f| File.basename f}.each do |f|
        #   # copy_file f, "app/views/#{f}"
        # end
      end

      private

      def template_engine
        options[:template_engine].try(:to_s).try(:downcase) || 'erb'
      end
    end
  end
end