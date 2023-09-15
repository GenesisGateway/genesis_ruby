RSpec.shared_examples 'address info attributes examples' do
  describe 'when billing address attributes' do
    let(:billing) do
      request.billing_first_name = Faker::Name.first_name
      request.billing_last_name  = Faker::Name.last_name
      request.billing_address1   = Faker::Address.street_address
      request.billing_address2   = Faker::Address.street_address
      request.billing_zip_code   = Faker::Address.zip_code
      request.billing_city       = Faker::Address.city
      request.billing_state      = Faker::Address.state_abbr
      request.billing_country    = Faker::Address.country_code

      request
    end

    it 'with billing address node' do
      expect(billing.build_document).to include '<billing_address>'
    end

    it 'with billing first name' do
      billing.billing_first_name = name = Faker::Name.first_name

      expect(billing.build_document).to include "<first_name>#{name}</first_name>"
    end

    it 'with billing last name' do
      billing.billing_last_name = name = Faker::Name.last_name

      expect(billing.build_document).to include "<last_name>#{name}</last_name>"
    end

    it 'with billing address1' do
      billing.billing_address1 = address = Faker::Address.street_address

      expect(billing.build_document).to include "<address1>#{address}</address1>"
    end

    it 'with billing address2' do
      billing.billing_address2 = address = Faker::Address.street_address

      expect(billing.build_document).to include "<address2>#{address}</address2>"
    end

    it 'with billing zip code' do
      billing.billing_zip_code = zip_code = Faker::Address.zip_code

      expect(billing.build_document).to include "<zip_code>#{zip_code}</zip_code>"
    end

    it 'with billing city' do
      billing.billing_city = city = Faker::Address.city

      expect(billing.build_document).to include "<city>#{city}</city>"
    end

    it 'with billing state' do
      billing.billing_state = state = Faker::Address.state

      expect(billing.build_document).to include "<state>#{state}</state>"
    end

    it 'with billing country' do
      billing.billing_country = country = Faker::Address.country_code

      expect(billing.build_document).to include "<country>#{country}</country>"
    end
  end

  describe 'when shipping address attributes' do
    let(:shipping) do
      request.shipping_first_name = Faker::Name.first_name
      request.shipping_last_name  = Faker::Name.last_name
      request.shipping_address1   = Faker::Address.street_address
      request.shipping_address2   = Faker::Address.street_address
      request.shipping_zip_code   = Faker::Address.zip_code
      request.shipping_city       = Faker::Address.city
      request.shipping_state      = Faker::Address.state_abbr
      request.shipping_country    = Faker::Address.country_code

      request
    end

    it 'with shipping address node' do
      expect(shipping.build_document).to include '<shipping_address>'
    end

    it 'with shipping first name' do
      shipping.shipping_first_name = name = Faker::Name.first_name

      expect(shipping.build_document).to include "<first_name>#{name}</first_name>"
    end

    it 'with shipping last name' do
      shipping.shipping_last_name = name = Faker::Name.last_name

      expect(shipping.build_document).to include "<last_name>#{name}</last_name>"
    end

    it 'with shipping address1' do
      shipping.shipping_address1 = address = Faker::Address.street_address

      expect(shipping.build_document).to include "<address1>#{address}</address1>"
    end

    it 'with shipping address2' do
      shipping.shipping_address2 = address = Faker::Address.street_address

      expect(shipping.build_document).to include "<address2>#{address}</address2>"
    end

    it 'with shipping zip code' do
      shipping.shipping_zip_code = zip_code = Faker::Address.zip_code

      expect(shipping.build_document).to include "<zip_code>#{zip_code}</zip_code>"
    end

    it 'with shipping city' do
      shipping.shipping_city = city = Faker::Address.city

      expect(shipping.build_document).to include "<city>#{city}</city>"
    end

    it 'with shipping state' do
      shipping.shipping_state = state = Faker::Address.state

      expect(shipping.build_document).to include "<state>#{state}</state>"
    end

    it 'with shipping country' do
      shipping.shipping_country = country = Faker::Address.country_code

      expect(shipping.build_document).to include "<country>#{country}</country>"
    end
  end

  describe 'when customer attributes' do
    it 'with customer email' do
      request.customer_email = email = Faker::Internet.email

      expect(request.build_document).to include "<customer_email>#{email}</customer_email>"
    end

    it 'with customer phone' do
      request.customer_phone = phone = Faker::PhoneNumber.cell_phone_in_e164

      expect(request.build_document).to include "<customer_phone>#{phone}</customer_phone>"
    end
  end
end
