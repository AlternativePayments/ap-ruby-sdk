module ApRubySdk
  class InvalidParameterError < ApError
    attr_reader :parameter

    def initialize(message=nil, http_status=nil, error_code=nil, parameter=nil)
      super(message, http_status, error_code)
      @parameter = parameter
    end

    def to_s
      message = super
      parameter = @parameter.nil? ? '' : "Wrong parameter #{@parameter}"
      "#{message}\n#{parameter}"
    end
  end
end