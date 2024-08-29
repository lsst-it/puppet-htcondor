# @summary
#   Installs htcondor as scheduler
#
# @param htcondor_version
#   check https://research.cs.wisc.edu/htcondor/repo/ for more versions
#
# @param htcondor_host
#   sets the central-manager host
#
# @param htcondor_pswfile
#   sets the location of the file
#
# @param htcondor_password
#   sets the access password
#
class htcondor (

  String[1] $htcondor_version,
  String[1] $htcondor_host,
  Optional[String[1]] $htcondor_pswfile = undef,
  Optional[String[1]] $htcondor_password = undef,

) {
  contain htcondor::repo
  contain htcondor::install
  contain htcondor::config
  contain htcondor::service

  Class['htcondor::repo']
  -> Class['htcondor::install']
  -> Class['htcondor::config']
  ~> Class['htcondor::service']
}
