require 'test_helper'

class PaginationTest < Minitest::Test

  def test_pagination_is_created
    pagination = ApRubySdk::Pagination.new(
        'offset' => 10,
        'limit' => 2,
        'count' => 2504
    )

    assert_equal(10, pagination.offset)
    assert_equal(2, pagination.limit)
    assert_equal(2504, pagination.count)
  end

end