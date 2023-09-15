require 'spec/genesis_ruby/stubs/api/constants/module_constants_stub'

RSpec.describe GenesisRuby::Api::Mixins::Constants::Common do
  let(:module_constants) { GenesisSpec::Stubs::Api::Constants::ModuleConstantsStub }

  it 'retrieves all constants' do
    expect(module_constants.all).to eq(%w(constant_1 constant_2))
  end

  it 'validates when invalid constant value' do
    expect(module_constants.valid?('invalid')).to eq(false)
  end

  it 'validates when valid constant value' do
    expect(module_constants.valid?('constant_1')).to eq(true)
  end

end
