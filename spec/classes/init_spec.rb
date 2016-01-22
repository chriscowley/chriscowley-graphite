require 'spec_helper'
describe 'graphite' do

  context 'with defaults for all parameters' do
    it { should contain_class('graphite') }
  end
end
