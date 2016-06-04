module ApRubySdk
  class Pagination < BaseModel

    attr_accessor :offset,
                  :limit,
                  :count

  end
end