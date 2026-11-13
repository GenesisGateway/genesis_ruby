# frozen_string_literal: true

RSpec.shared_examples 'force threeds excluded examples' do
  describe 'when force threeds is excluded' do
    let(:force_threeds_checked_attributes) do
      lambda do |object|
        %i[transaction_id amount currency usage].to_h { |name| [name, object.public_send(name)] }
      end
    end
    let(:force_threeds_failed_assignment) do
      lambda do
        request.force_threeds = true
      rescue NoMethodError
        nil
      end
    end

    it 'does not respond to force_threeds reader' do
      expect(request.respond_to?(:force_threeds)).to be false
    end

    it 'does not respond to force_threeds setter' do
      expect(request.respond_to?(:force_threeds=)).to be false
    end

    it 'raises NoMethodError when force_threeds is assigned' do
      expect { request.force_threeds = true }.to raise_error NoMethodError
    end

    it 'keeps the already set attributes unchanged after the failed assignment' do
      expect { force_threeds_failed_assignment.call }.to_not(change { force_threeds_checked_attributes.call(request) })
    end

    it 'generates document without force_threeds element' do
      expect(request.build_document).to_not include 'force_threeds'
    end
  end
end
