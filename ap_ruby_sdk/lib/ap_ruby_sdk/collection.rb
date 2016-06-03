module ApRubySdk
  class Collection
    attr_accessor :pagination,
                  :items

    def pagination=(pagination)
      @pagination = Pagination.new(pagination)
    end

    def initialize(attributes={})
      self.attributes = attributes
    end

    def attributes=(attributes)
      if attributes.respond_to?(:each)
        attributes.each do |key, value|
          writer = (key == 'type' ? 'kind=' : "#{key}=")
          if respond_to?(writer)
            send(writer, value)
          end
        end
      else
        attributes
      end
    end

    def to_json
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
      hash.to_json
    end
  end
end