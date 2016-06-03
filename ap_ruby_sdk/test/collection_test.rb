require 'test_helper'

class CollectionTest < Minitest::Test

  def test_collection_is_created
    collection = ApRubySdk::Collection.new(
        'items' => [],
        'pagination' => {
            'offset' => 10,
            'limit' => 2,
            'count' => 2504
        }
    )

    assert_equal(10, collection.pagination.offset)
    assert_equal(2, collection.pagination.limit)
    assert_equal(2504, collection.pagination.count)
  end

end