module KDsl
  module Extensions
    module DocumentFactories
      # Provides a list of factory methods for creating documents
      #
      # These factories help you to create documents for specific needs.
      # A simple factory may just set the apropriate name for a factory
      # Or set the name and provide some extra options.
      # A more advanced factory may instantiate an extended Document class
      # with extra functionality or predefine the fields for a table
      #
      # Currently used as a class extension to KDsl
      def microapp(key, **options, &block)
        valid_types = nil
        build_document(key, :microapp, valid_types, **options, &block)
      end

      # def self.artifact(k_key, type: :entity, **options, &block)
      #   valid_types = [:entity, :value_object, :app_settings, :command]
      #   build_document(k_key, type, valid_types, options, &block)
      # end

      # def self.blueprint(k_key, **options, &block)
      #   build_document(k_key, :blueprint, nil, options, &block)
      # end

      # def self.domain(k_key, **options, &block)
      #   build_document(k_key, :domain, nil, options, &block)
      # end

      # def self.cmd(k_key, **options, &block)
      #   build_document(k_key, :cmd, nil, options, &block)
      # end


      # def self.structure(k_key, **options, &block)
      #   build_document(k_key, :structure, nil, options, &block)
      # end

      # def self.data(k_key, **options, &block)
      #   build_document(k_key, :data, nil, options, &block)
      # end

    end
  end
end