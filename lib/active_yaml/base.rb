require 'yaml'

module ActiveYaml

  class Base < ActiveFile::Base
    extend ActiveFile::HashAndArrayFiles
    class << self
      def load_file
        if (data = raw_data).is_a?(Array)
          data
        elsif data.respond_to?(:values)
          data.values
        end
      end

      def extension
        "yml"
      end

      private
      def load_path(path)
        yaml_config = ERB.new(File.read(path)).result
        YAML.respond_to?(:unsafe_load) ? YAML.unsafe_load(yaml_config) : YAML.load(yaml_config)
      end
    end
  end
end
