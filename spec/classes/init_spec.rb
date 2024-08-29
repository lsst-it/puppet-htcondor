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

    it { is_expected.to contain_package('condor').that_requires('Yumrepo[condor]') }

    it { is_expected.to contain_file('/etc/condor/condor_config.local').that_requires('Package[condor]') }

    it { is_expected.to contain_file('/etc/condor/config.d/docker').that_requires('Package[condor]') }

    it { is_expected.to contain_file('/etc/condor/config.d/schedd') }

    it { is_expected.to contain_file('/etc/condor/config.d/dagman') }

    it do
      is_expected.to contain_service('condor').with(
        ensure: 'running',
        enable: true
      )
    end
  end
end
