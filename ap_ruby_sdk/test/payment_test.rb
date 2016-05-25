require 'test_helper'

class PaymentTest < Minitest::Test

  def test_sepa_payment_is_created
    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'SEPA',
        'holder' => 'John Doe',
        'iban' => 'DE71XXXXX3330'
    )

    assert_equal('SEPA', payment.paymentOption)
    assert_equal('John Doe', payment.holder)
    assert_equal('DE71XXXXX3330', payment.iban)
  end

  def test_credit_card_payment_is_created
    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'CreditCard',
        'holder' => 'John Doe',
        'creditCardNumber' => '4111111111111111',
        'CVV2' => '222',
        'creditCardType' => 'visa',
        'expirationYear' => '2019',
        'expirationMonth' => '12',
    )

    assert_equal('CreditCard', payment.paymentOption)
    assert_equal('John Doe', payment.holder)
    assert_equal('4111111111111111', payment.creditCardNumber)
    assert_equal('222', payment.CVV2)
    assert_equal('visa', payment.creditCardType)
    assert_equal('2019', payment.expirationYear)
    assert_equal('12', payment.expirationMonth)
  end

end