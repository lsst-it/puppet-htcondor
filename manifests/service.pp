# @api private
class htcondor::service {
  assert_private()
  service { 'condor':
    ensure => 'running',
    enable => true,
  }
}
