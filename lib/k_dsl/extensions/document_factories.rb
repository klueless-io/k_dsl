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

      # Create a new MicroApp in a variety of languages
      def microapp(key, **options, &block)
        build_document(key, :microapp, **options, &block)
      end

      # # Create a Structure for holding general blueprints, often used when initializing an application
      # def structure(key, **options, &block)
      #   # REFACT: Rename to StuctureDocument
      #   build_document(key, :structure, document_class: KDsl::Model::BlueprintDocument, **options, &block)
      # end

      def blueprint(key, **options, &block)
        build_document(key, :blueprint, document_class: KDsl::Model::BlueprintDocument, **options, &block)
      end

      alias structure blueprint

      # def artifact(key, type: :entity, **options, &block)
      #   valid_types = [:entity, :value_object, :app_settings, :command]
      #   build_document(key, type, valid_types, **options, &block)
      # end

      # def blueprint(key, **options, &block)
      #   valid_types = nil
      #   build_document(key, :blueprint, valid_types, **options, &block)
      # end

      # def domain(key, **options, &block)
      #   valid_types = nil
      #   build_document(key, :domain, valid_types, **options, &block)
      # end

      # def cmd(key, **options, &block)
      #   valid_types = nil
      #   build_document(key, :cmd, valid_types, **options, &block)
      # end


      # def data(key, **options, &block)
      #   valid_types = nil
      #   build_document(key, :data, nil, **options, &block)
      # end
    end
  end
end