require epel

Yumrepo['epel'] -> Class['htcondor']
Class['yum'] -> Class['htcondor']

class { 'yum':
  managed_repos => [
    'crb',
  ],
  repos => {
    'crb' => {
      'enabled' => true,
    },
  },
}

class { 'htcondor':
  htcondor_version  => '23.0',
  htcondor_host     => 'htcondor.example.com',
  htcondor_pswfile  => '/tmp/test',
  htcondor_password => 'corge',
}
