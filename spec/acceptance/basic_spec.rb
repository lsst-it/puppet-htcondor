# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'htcondor class' do
  let(:manifest) do
    <<-PP
    class { 'htcondor':
      htcondor_version  => '23.0',
      htcondor_host     => 'htcondor.example.com',
      htcondor_pswfile  => '/tmp/test',
      htcondor_password => 'corge'
    }
    PP
  end

  it_behaves_like 'an idempotent resource'
end
