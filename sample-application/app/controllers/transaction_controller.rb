class TransactionController < ApplicationController

  def new
    case params[:transaction_type].to_sym
      when :alipay
        create_alipay_transaction
      when :mistercash
        create_mistercash_transaction
      when :brazil_pay_bank_transfer
        create_brazil_pay_bank_transfer_transaction
      when :brazil_pay_boleto
        create_brazil_pay_boleto_transaction
      when :brazil_pay_charge_card
        create_brazil_pay_charge_card_transaction
      when :cashu
        create_cashu_transaction
      when :credit_card
        create_credit_card_transaction
      when :directpay
        create_directpay_transaction
      when :directpaymax
        create_directpaymax_transaction
      when :eps
        create_eps_transaction
      when :giropay
        create_giropay_transaction
      when :ideal
        create_ideal_transaction
      when :mcoinz
        create_mcoinz_transaction
      when :paysafe
        create_paysafe_transaction
      when :poli
        create_poli_transaction
      when :przelewy24
        create_przelewy24_transaction
      when :qiwi
        create_qiwi_transaction
      when :safetypay
        create_safetypay_transaction
      when :sepa
        create_sepa_transaction
      when :sepa_phone_verification
        create_sepa_phone_verification_transaction
      when :sofort_uberweisung
        create_sofort_uberweisung_transaction
      when :trustpay
        create_trustpay_transaction
      when :teleingreso
        create_teleingreso_transaction
      when :tenpay
        create_tenpay_transaction
      when :unionpay
        create_unionpay_transaction
      when :verkkopankki
        create_verkkopankki_transaction
      when :hosted_transaction
        create_hosted_transaction
      else
        raise 'Need to supply valid transaction type'
    end
  end

  def index
    if params[:transaction_id]
      @transaction = ApRubySdk::Transaction.retrieve(params[:transaction_id])
    end
  end

  def transactions
    @transactions = ApRubySdk::Transaction.all
  end

  private

  def create_alipay_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'CN'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'alipay',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 100,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_mistercash_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'BE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'mistercash',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_brazil_pay_bank_transfer_transaction
    customer = ApRubySdk::Customer.new(
        'firstName' => 'José',
        'lastName' => 'Silva',
        'email' => 'josé@silva.com',
        'address' => 'Rua E',
        'address2' => '1040',
        'city' => 'Maracanaú',
        'zip' => '61919-230',
        'country' => 'BR',
        'state' => 'AM',
        'birthDate' => '12/04/1979',
        'phone' => '+5572222312'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'brazilpaybanktransfer',
        'holder' => 'José Silva',
        'documentId' => '924.521.873-24',
        'bankCode' => 'hsbc'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 4500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end


  def create_brazil_pay_boleto_transaction
    customer = ApRubySdk::Customer.new(
        'firstName' => 'José',
        'lastName' => 'Silva',
        'email' => 'josé@silva.com',
        'address' => 'Rua E',
        'address2' => '1040',
        'city' => 'Maracanaú',
        'zip' => '61919-230',
        'country' => 'BR',
        'state' => 'AM',
        'birthDate' => '12/04/1979',
        'phone' => '+5572222312'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'brazilpayboleto',
        'holder' => 'JoséSilva',
        'documentId' => '924.521.873-24'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 4500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_brazil_pay_charge_card_transaction
    customer = ApRubySdk::Customer.new(
        'firstName' => 'José',
        'lastName' => 'Silva',
        'email' => 'josé@silva.com',
        'address' => 'Rua E',
        'address2' => '1040',
        'city' => 'Maracanaú',
        'zip' => '61919-230',
        'country' => 'BR',
        'state' => 'AM',
        'birthDate' => '12/04/1979',
        'phone' => '+5572222312'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'brazilpaychargecard',
        'holder' => 'JoséSilva',
        'documentId' => '851.453.477-03',
        'creditCardType' => 'visa',
        'creditCardNumber' => '4111111111111111',
        'CVV2' => '222',
        'expirationYear' => '2019',
        'expirationMonth' => '12'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 4500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_cashu_transaction
    customer = ApRubySdk::Customer.new(
        'firstName' => 'José',
        'lastName' => 'Silva',
        'email' => 'josé@silva.com',
        'country' => 'EG'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'cashu',
        'holder' => 'JoséSilva'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 4500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_credit_card_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'US'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'CreditCard',
        'holder' => 'John Doe',
        'creditCardNumber' => '4111111111111111',
        'CVV2' => '222',
        'creditCardType' => 'visa',
        'expirationYear' => '2019',
        'expirationMonth' => '12'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_directpay_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'directpayeu',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 100,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_directpaymax_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'directpaymaxeu',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 100,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_eps_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'AT'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'eps',
        'bic' => 'TESTDETT421',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 100,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_giropay_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'giropay',
        'holder' => 'John Doe',
        'bic' => 'TESTDETT421'

    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_ideal_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'NL'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'ideal',
        'holder' => 'John Doe',
        'bankCode' => 'ABN_AMRO'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_mcoinz_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'SA'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'mcoinz',
        'holder' => 'John Doe',
        'pinCode' => 'CEEXXXXXXXXXC7'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_paysafe_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'paysafe',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_poli_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'AU'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'poli',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_przelewy24_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'PL'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'przelewy24',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_qiwi_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'RU',
        'phone' => '+7855555555555'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'qiwi',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 15000,
        'currency' => 'RUB',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_safetypay_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'SafetyPay',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_sepa_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'SEPA',
        'holder' => 'John Doe',
        'iban' => 'BE88271080782541'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'description' => 'test sepa php sdk',
        'merchantPassThruData' => 'test_sepa_123',
        'ipAddress' => '127.0.0.1'
    )
  end

  def create_sepa_phone_verification_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'SEPA',
        'holder' => 'John Doe',
        'iban' => 'BE88271080782541'
    )

    phone_verification = ApRubySdk::PhoneVerification.create(
        'phone' => '+15555555555',
        'key' => ApRubySdk::api_public_key
    )

    phone_verification.pin = 1234

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'description' => 'test sepa php sdk',
        'merchantPassThruData' => 'test_sepa_123',
        'ipAddress' => '127.0.0.1',
        'phoneverification' => phone_verification
    )
  end

  def create_sofort_uberweisung_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'sofortuberweisung',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_trustpay_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'EE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'trustpay',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_teleingreso_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'ES'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'teleingreso',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_tenpay_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'CN'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'tenpay',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'CNY',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_unionpay_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'CN'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'unionpay',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'CNY',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_verkkopankki_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'FI'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'verkkopankki',
        'holder' => 'John Doe'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_hosted_transaction
    customer = ApRubySdk::Customer.new(
        'firstName' => 'José',
        'lastName' => 'Silva',
        'email' => 'josé@silva.com',
        'address' => 'Rua E',
        'address2' => '1040',
        'city' => 'Maracanaú',
        'zip' => '61919-230',
        'country' => 'BR',
        'state' => 'CE',
        'birthDate' => '12/04/1979',
        'phone' => '+5572222312'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'BrazilPayBankTransfer',
        'holder' => 'JoséSilva',
        'documentId' => '853.513.468-93'
    )

    redirectUrls = ApRubySdk::RedirectUrls.new(
        'returnUrl' => 'http://plugins.alternativepayments.com/message/success.html',
        'cancelUrl' => 'http://plugins.alternativepayments.com/message/failure.html'
    )

    @transaction = ApRubySdk::HostedTransaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 4500,
        'currency' => 'EUR',
        'ipAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end
end