# frozen_string_literal: true

require 'spec_helper'

describe 'htcondor' do
  context 'with params' do
    let(:params) do
      {
        htcondor_version: '23.0',
        htcondor_host: 'htcondor.example.com',
        htcondor_pswfile: '/tmp/pswfile',
        htcondor_password: 'password'
      }
    end

    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_yumrepo('condor') }

    it do
      is_expected.to contain_package('condor').that_requires('Yumrepo[condor]')
    end

    it { is_expected.to contain_file('/etc/condor/condor_config.local') }

    it { is_expected.to contain_file('/etc/condor/config.d/docker') }

    it { is_expected.to contain_file('/etc/condor/config.d/schedd').with_content(%r{^DAEMON_LIST = MASTER, SCHEDD}) }

    it do
      is_expected.to contain_service('condor').with(
        ensure: 'running',
        enable: true
      )
    end
  end
end
