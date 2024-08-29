# @api private
class htcondor::install {
  assert_private()

  ensure_packages(['condor'], { ensure => 'present' })
}
