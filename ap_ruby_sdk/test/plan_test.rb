require 'test_helper'

class PlanTest < Minitest::Test

  def test_create_plan
    stub_request(:post, 'https://api.alternativepayments.com/api/plans').
        with(
            body: hash_including(
                {
                    name: 'Test'
                }
            ),
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 200, :body => MultiJson.dump(
                                      {
                                          'id' => 'pln_a27286a',
                                          'mode' => 'Test',
                                          'name' => 'Test',
                                          'description' => 'Test plan',
                                          'amount' => 1000,
                                          'currency' => 'EUR',
                                          'period' => ApRubySdk::Period::DAY,
                                          'interval' => 5,
                                          'created' => '2016-03-24T15:19:10.7800694Z'
                                      },
                                      :headers => {}))

    plan = ApRubySdk::Plan.create(
        'interval' => 5,
        'period' => ApRubySdk::Period::DAY,
        'amount' => 1000,
        'currency' => 'EUR',
        'name' => 'Test',
        'description' => 'Test plan'
    )

    assert_equal('pln_a27286a', plan.id)
    assert_equal('Test', plan.mode)
    assert_equal('Test', plan.name)
    assert_equal('Test plan', plan.description)
    assert_equal(1000, plan.amount)
    assert_equal('EUR', plan.currency)
    assert_equal(5, plan.interval)
    assert_equal(ApRubySdk::Period::DAY, plan.period)
    assert_equal('2016-03-24T15:19:10.7800694Z', plan.created)
  end

  def test_retrieve_all_plans
    stub_request(:get, 'https://api.alternativepayments.com/api/plans/').
        with(

            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 200, :body => MultiJson.dump(
                                      {

                                          'plans' => [
                                              {
                                                  'id' => 'pln_6507985',
                                                  'mode' => 'Test',
                                                  'name' => 'Test',
                                                  'description' => 'Test plan',
                                                  'amount' => 1000,
                                                  'currency' => 'EUR',
                                                  'period' => ApRubySdk::Period::DAY,
                                                  'interval' => 5,
                                                  'created' => '2016-03-24T15:19:10.7800694Z'
                                              },
                                              {
                                                  'id' => 'pln_6507986',
                                                  'mode' => 'Test',
                                                  'name' => 'Test2',
                                                  'description' => 'Test2 plan',
                                                  'amount' => 2000,
                                                  'currency' => 'EUR',
                                                  'period' => ApRubySdk::Period::DAY,
                                                  'interval' => 6,
                                                  'created' => '2016-03-24T15:19:10.7800694Z'
                                              }
                                          ]
                                      },
                                      :headers => {}))

    plans = ApRubySdk::Plan.all

    assert_equal(2, plans.items.length)

    first_plan = plans.items[0]

    assert_equal('pln_6507985', first_plan.id)
    assert_equal('Test', first_plan.mode)
    assert_equal('Test', first_plan.name)
    assert_equal('Test plan', first_plan.description)
    assert_equal(1000, first_plan.amount)
    assert_equal('EUR', first_plan.currency)
    assert_equal(5, first_plan.interval)
    assert_equal(ApRubySdk::Period::DAY, first_plan.period)
    assert_equal('2016-03-24T15:19:10.7800694Z', first_plan.created)

    second_plan = plans.items[1]

    assert_equal('pln_6507986', second_plan.id)
    assert_equal('Test', second_plan.mode)
    assert_equal('Test2', second_plan.name)
    assert_equal('Test2 plan', second_plan.description)
    assert_equal(2000, second_plan.amount)
    assert_equal('EUR', second_plan.currency)
    assert_equal(6, second_plan.interval)
    assert_equal(ApRubySdk::Period::DAY, second_plan.period)
    assert_equal('2016-03-24T15:19:10.7800694Z', second_plan.created)
  end

  def test_retrieve_plan
    stub_request(:get, 'https://api.alternativepayments.com/api/plans/pln_6507986').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 200, :body => MultiJson.dump(
                                      {
                                          'id' => 'pln_6507986',
                                          'mode' => 'Test',
                                          'name' => 'Test',
                                          'description' => 'Test plan',
                                          'amount' => 1000,
                                          'currency' => 'EUR',
                                          'period' => ApRubySdk::Period::DAY,
                                          'interval' => 5,
                                          'created' => '2016-03-24T15:19:10.7800694Z'
                                      },
                                      :headers => {}))

    plan = ApRubySdk::Plan.retrieve('pln_6507986')

    assert_equal('pln_6507986', plan.id)
    assert_equal('Test', plan.mode)
    assert_equal('Test', plan.name)
    assert_equal('Test plan', plan.description)
    assert_equal(1000, plan.amount)
    assert_equal('EUR', plan.currency)
    assert_equal(5, plan.interval)
    assert_equal(ApRubySdk::Period::DAY, plan.period)
    assert_equal('2016-03-24T15:19:10.7800694Z', plan.created)
  end

  def test_retrieve_plans_with_pagination
    stub_request(:get, 'https://api.alternativepayments.com/api/plans/?limit=3&offset=10').
        with(
            headers: {
                :authorization => "Basic #{Base64.encode64('test').gsub("\n", '')}",
                :content_type => 'application/json',
                :accept => '*/*; q=0.5, application/xml',
                :accept_encoding => 'gzip, deflate',
                :user_agent => "AlternativePayments Ruby SDK v#{ApRubySdk::VERSION}"
            }
        ).to_return(:status => 200, :body => MultiJson.dump(
                                      {
                                          'plans' => [
                                              {
                                                  'id' => 'pln_6507985',
                                                  'mode' => 'Test',
                                                  'name' => 'Test',
                                                  'description' => 'Test plan',
                                                  'amount' => 1000,
                                                  'currency' => 'EUR',
                                                  'period' => ApRubySdk::Period::DAY,
                                                  'interval' => 5,
                                                  'created' => '2016-03-24T15:19:10.7800694Z'
                                              },
                                              {
                                                  'id' => 'pln_6507986',
                                                  'mode' => 'Test',
                                                  'name' => 'Test2',
                                                  'description' => 'Test2 plan',
                                                  'amount' => 2000,
                                                  'currency' => 'EUR',
                                                  'period' => ApRubySdk::Period::DAY,
                                                  'interval' => 6,
                                                  'created' => '2016-03-24T15:19:10.7800694Z'
                                              },
                                              {
                                                  'id' => 'pln_6507987',
                                                  'mode' => 'Test',
                                                  'name' => 'Test3',
                                                  'description' => 'Test3 plan',
                                                  'amount' => 3000,
                                                  'currency' => 'EUR',
                                                  'period' => ApRubySdk::Period::DAY,
                                                  'interval' => 7,
                                                  'created' => '2016-03-24T15:19:10.7800694Z'
                                              }
                                          ]
                                      },
                                      :headers => {}))

    plans = ApRubySdk::Plan.all(limit: 3, offset: 10)

    assert_equal(3, plans.items.length)

    first_plan = plans.items[0]

    assert_equal('pln_6507985', first_plan.id)
    assert_equal('Test', first_plan.mode)
    assert_equal('Test', first_plan.name)
    assert_equal('Test plan', first_plan.description)
    assert_equal(1000, first_plan.amount)
    assert_equal('EUR', first_plan.currency)
    assert_equal(5, first_plan.interval)
    assert_equal(ApRubySdk::Period::DAY, first_plan.period)
    assert_equal('2016-03-24T15:19:10.7800694Z', first_plan.created)

    second_plan = plans.items[1]

    assert_equal('pln_6507986', second_plan.id)
    assert_equal('Test', second_plan.mode)
    assert_equal('Test2', second_plan.name)
    assert_equal('Test2 plan', second_plan.description)
    assert_equal(2000, second_plan.amount)
    assert_equal('EUR', second_plan.currency)
    assert_equal(6, second_plan.interval)
    assert_equal(ApRubySdk::Period::DAY, second_plan.period)
    assert_equal('2016-03-24T15:19:10.7800694Z', second_plan.created)

    third_plan = plans.items[2]

    assert_equal('pln_6507987', third_plan.id)
    assert_equal('Test', third_plan.mode)
    assert_equal('Test3', third_plan.name)
    assert_equal('Test3 plan', third_plan.description)
    assert_equal(3000, third_plan.amount)
    assert_equal('EUR', third_plan.currency)
    assert_equal(7, third_plan.interval)
    assert_equal(ApRubySdk::Period::DAY, third_plan.period)
    assert_equal('2016-03-24T15:19:10.7800694Z', third_plan.created)
  end
end