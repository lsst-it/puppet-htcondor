# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'htcondor class' do
  let(:manifest) do
    <<-PP
    class { 'htcondor':
      htcondor_version  => 'foo',
      htcondor_host     => 'bar',
      htcondor_pswfile  => 'baz',
      htcondor_password => 'corge'
    }
    PP
  end

  it_behaves_like 'an idempotent resource'
end
