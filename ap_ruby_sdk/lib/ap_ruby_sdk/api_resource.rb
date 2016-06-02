module ApRubySdk
  class ApiResource < BaseModel

    attr_accessor :mode

    def self.url
      raise NotImplementedError.new('APIResource is an abstract class.  You should use it\'s subclasses (Customer, Payment, etc.)')
    end

    def self.list_members
      raise NotImplementedError.new('APIResource is an abstract class.  You should use it\'s subclasses (Customer, Payment, etc.)')
    end

    def self.url_with_prefix(url_prefix)
      if url_prefix.nil?
        self.url
      else
        "#{url_prefix}#{self.url}"
      end
    end

    def self.construct_object(response)
      self.new(response)
    end
  end
end