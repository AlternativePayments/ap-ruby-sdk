module ApRubySdk
  class BaseModel
    attr_accessor :id,
                  :created,
                  :updated,
                  :version

    def initialize(attributes={})
      @version = ApRubySdk::VERSION
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