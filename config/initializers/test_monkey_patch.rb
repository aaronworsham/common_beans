#This patch allows me to use form_for to build forms that have flat names for
#attributes.  This is needed to update backbone.js effeciently.

module ActionView
  module Helpers
    class InstanceTag
      def add_default_name_and_id(options)
        if options.has_key?("index")
          options["name"] ||= tag_name_with_index(options["index"])
          options["id"] = options.fetch("id"){ tag_id_with_index(options["index"]) }
          options.delete("index")
        elsif options.has_key?('simple_tag_name')
          options["name"] ||= simple_tag_name
          options.delete("simple_tag_name")
        elsif defined?(@auto_index)
          options["name"] ||= tag_name_with_index(@auto_index)
          options["id"] = options.fetch("id"){ tag_id_with_index(@auto_index) }
        else
          options["name"] ||= tag_name + (options['multiple'] ? '[]' : '')
          options["id"] = options.fetch("id"){ tag_id }
        end
      end

      def simple_tag_name
       "#{sanitized_method_name}"
      end
    end
  end
end