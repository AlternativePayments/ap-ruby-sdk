module ApRubySdk
  class ApError < StandardError
    attr_reader :message
    attr_reader :http_status
    attr_reader :error_code

    def initialize(message=nil, http_status=nil, error_code=nil)
      @message = message
      @http_status = http_status
      @error_code = error_code
    end

    def to_s
      status_string = @http_status.nil? ? '' : "(Status #{@http_status})"
      error_code = @error_code.nil? ? '' : "Error code #{@error_code}"
      "#{status_string}\n#{@message}\n#{error_code}"
    end
  end
end