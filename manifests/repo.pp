# @api private
class htcondor::repo {
  assert_private()

  $htcondor_version = $htcondor::htcondor_version

  yumrepo { 'condor':
    descr               => 'htcondor repo',
    baseurl             => "https://research.cs.wisc.edu/htcondor/repo/${htcondor_version}/el9/\$basearch/release/",
    skip_if_unavailable => 'true',
    gpgcheck            => '1',
    gpgkey              => "https://research.cs.wisc.edu/htcondor/repo/keys/HTCondor-${htcondor_version}-Key",
    enabled             => '1',
    target              => '/etc/yum.repos.d/htcondor.repo',
  }
}
