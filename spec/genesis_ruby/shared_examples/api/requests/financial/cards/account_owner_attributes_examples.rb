RSpec.shared_examples 'account owner attributes examples' do
  describe 'when account owner attributes' do
    describe 'without initialization' do
      it 'without account_owner node' do
        expect(request.build_document).to_not include '<account_owner>'
      end
    end

    describe 'with initialization' do
      let(:account_owner) do
        request.account_first_name  = Faker::Name.first_name
        request.account_middle_name = Faker::Name.middle_name
        request.account_last_name   = Faker::Name.last_name

        request
      end

      it 'with account_owner node' do
        expect(account_owner.build_document).to include '<account_owner>'
      end

      it 'with first name' do
        expect(account_owner.build_document)
          .to include "<first_name>#{account_owner.account_first_name}</first_name>"
      end

      it 'with middle name' do
        expect(account_owner.build_document)
          .to include "<middle_name>#{account_owner.account_middle_name}</middle_name>"
      end

      it 'with last name' do
        expect(account_owner.build_document).to include "<last_name>#{account_owner.account_last_name}</last_name>"
      end

    end
  end
end
