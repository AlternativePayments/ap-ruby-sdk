module ApRubySdk
  class BaseModel
    attr_accessor :id,
                  :mode,
                  :created,
                  :updated

    def initialize(attributes={})
      self.attributes = attributes
    end

    def attributes=(attributes)
      attributes.each do |key, value|
        writer = (key == 'type' ? 'kind=' : "#{key}=")
        if respond_to?(writer)
          send(writer, value)
        end
      end
    end
  end
end