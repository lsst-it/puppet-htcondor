# @api private
class htcondor::config {
  assert_private()

  $htcondor_host = $htcondor::htcondor_host
  $htcondor_pswfile = $htcondor::htcondor_pswfile
  $htcondor_password = $htcondor::htcondor_password
  $config_path = '/etc/condor/config.d'

  file { '/etc/condor/condor_config.local':
    ensure  => file,
    content => @(EOF)
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
      | EOF
    ,
  }

  file { "${config_path}/schedd":
    ensure  => file,
    content => @(CONTENT)
      DAEMON_LIST = MASTER, SCHEDD
      HISTORY_CONTAINS_JOB_ENVIRONMENT = False
      | CONTENT
    ,
  }

  file { "${config_path}/dagman":
    ensure  => file,
    content => 'DAGMAN_MANAGER_JOB_APPEND_GETENV = True',
  }

  if $htcondor_pswfile and $htcondor_password {
    file { regsubst($htcondor_pswfile, '^(.*/).*$', '\1'):
      ensure  => directory,
    }

    file { $htcondor_pswfile:
      ensure  => file,
      mode    => '0600',
      content => $htcondor_password,
    }

    file { "${config_path}/docker":
      ensure  => file,
      content => @("EOF")
        CONDOR_HOST = ${htcondor_host}
        SEC_PASSWORD_FILE = ${htcondor_pswfile}
        | EOF
      ,
    }
  }
}
