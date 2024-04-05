# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'htcondor class' do
  context 'without any parameters' do
    include_examples 'the example', 'basic.pp'

    it_behaves_like 'an idempotent resource'

    describe package('condor') do
      it { is_expected.to be_installed }
    end

    describe file('/etc/condor/condor_config.local') do
      it { is_expected.to be_file }

      its(:content) do
        is_expected.to match <<~CONTENT
          ALLOW_WRITE = 10.*, 139.229.*
          ALLOW_NEGOTIATOR = 10.*, 139.229.*
          ALLOW_DAEMON = 10.*, 139.229.*

          use SECURITY: Strong
          SEC_DEFAULT_AUTHENTICATION_METHODS = FS, PASSWORD
          SEC_READ_AUTHENTICATION_METHODS = $(SEC_DEFAULT_AUTHENTICATION_METHODS),ANONYMOUS
          SEC_CLIENT_AUTHENTICATION_METHODS = $(SEC_DEFAULT_AUTHENTICATION_METHODS),ANONYMOUS

          DAEMON_LIST = $(DAEMON_LIST), SHARED_PORT
          SHARED_PORT_ARGS = -p 9618
          USE_SHARED_PORT = TRUE

          UPDATE_COLLECTOR_WITH_TCP = TRUE

          UID_DOMAIN = lsst.org
          FILESYSTEM_DOMAIN  = lsst.org
          SOFT_UID_DOMAIN = TRUE
        CONTENT
      end
    end

    describe file('/etc/condor/config.d/schedd') do
      it { is_expected.to be_file }
      its(:content) { is_expected.to match %r{^DAEMON_LIST = MASTER, SCHEDD} }
    end

    describe file('/etc/condor/config.d/docker') do
      it { is_expected.to be_file }
    end

    describe service('condor') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
