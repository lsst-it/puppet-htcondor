require epel

Yumrepo['epel'] -> Class['htcondor']

class { 'htcondor':
  htcondor_version  => '23.0',
  htcondor_host     => 'htcondor.example.com',
  htcondor_pswfile  => '/tmp/test',
  htcondor_password => 'corge',
}
