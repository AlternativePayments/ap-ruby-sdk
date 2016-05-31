class TransactionController < ApplicationController

  def new
    case params[:transaction_type].to_sym
      when :sepa
        create_sepa_transaction
      when :brazil_pay_boleto
        create_brazil_pay_boleto_transaction
      when :brazil_pay_bank_transfer
        create_brazil_pay_bank_transfer_transaction
      when :mistercash
        create_mistercash_transaction
      when :teleingreso
        create_teleingreso_transaction
      when :safetypay
        create_safetypay_transaction
      when :poli
        create_poli_transaction
      when :ideal
        create_ideal_transaction
      when :trustpay
        create_trustpay_transaction
      when :przelewy24
        create_przelewy24_transaction
      when :giropay
        create_giropay_transaction
      when :credit_card
        create_credit_card_transaction
      when :directpay
        create_directpay_transaction
      when :directpaymax
        create_directpaymax_transaction
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

  def create_directpaymax_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'directpaymax',
        'bankCode' => 'POSTBANK',
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
        'iPAddress' => '127.0.0.1',
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
        'paymentOption' => 'directpay',
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
        'iPAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_credit_card_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'DE'
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
        'iPAddress' => '127.0.0.1',
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
        'paymentOption' => 'Giropay',
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
        'iPAddress' => '127.0.0.1',
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
        'paymentOption' => 'Przelewy24',
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
        'iPAddress' => '127.0.0.1',
        'redirectUrls' => redirectUrls
    )
  end

  def create_trustpay_transaction
    customer = ApRubySdk::Customer.new(
        'id' => 'cus_bd838e3611d34d598',
        'firstName' => 'John',
        'lastName' => 'Doe',
        'email' => 'john@doe.com',
        'country' => 'GB'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'TrustPay',
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
        'iPAddress' => '127.0.0.1',
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
        'iPAddress' => '127.0.0.1',
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
        'paymentOption' => 'POLi',
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
        'iPAddress' => '127.0.0.1',
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
        'iPAddress' => '127.0.0.1',
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
        'paymentOption' => 'Teleingreso',
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
        'iPAddress' => '127.0.0.1',
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
        'iPAddress' => '127.0.0.1',
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
        'state' => 'CE',
        'birthDate' => '12/04/1979',
        'phone' => '+5572222312'
    )

    payment = ApRubySdk::Payment.new(
        'paymentOption' => 'BrazilPayBankTransfer',
        'holder' => 'José Silva',
        'documentId' => '853.513.468-93',
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
        'iPAddress' => '127.0.0.1',
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

    @transaction = ApRubySdk::Transaction.create(
        'customer' => customer,
        'payment' => payment,
        'amount' => 4500,
        'currency' => 'EUR',
        'iPAddress' => '127.0.0.1',
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
        'iPAddress' => '127.0.0.1'
    )
  end
end