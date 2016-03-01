require 'spec_helper'

describe 'graphite' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "graphite class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('graphite::params') }
          it { is_expected.to contain_class('graphite::install').that_comes_before('graphite::config') }
          it { is_expected.to contain_class('graphite::config') }
          it { is_expected.to contain_class('graphite::service').that_subscribes_to('graphite::config') }

          it { is_expected.to contain_service('graphite') }
          it { is_expected.to contain_package('graphite').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'graphite class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('graphite') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
