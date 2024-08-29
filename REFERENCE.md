# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`htcondor`](#htcondor): Installs htcondor as scheduler

#### Private Classes

* `htcondor::config`
* `htcondor::install`
* `htcondor::repo`
* `htcondor::service`

## Classes

### <a name="htcondor"></a>`htcondor`

Installs htcondor as scheduler

#### Parameters

The following parameters are available in the `htcondor` class:

* [`htcondor_version`](#-htcondor--htcondor_version)
* [`htcondor_host`](#-htcondor--htcondor_host)
* [`htcondor_pswfile`](#-htcondor--htcondor_pswfile)
* [`htcondor_password`](#-htcondor--htcondor_password)

##### <a name="-htcondor--htcondor_version"></a>`htcondor_version`

Data type: `String[1]`

check https://research.cs.wisc.edu/htcondor/repo/ for more versions

##### <a name="-htcondor--htcondor_host"></a>`htcondor_host`

Data type: `String[1]`

sets the central-manager host

##### <a name="-htcondor--htcondor_pswfile"></a>`htcondor_pswfile`

Data type: `Optional[String[1]]`

sets the location of the file

Default value: `undef`

##### <a name="-htcondor--htcondor_password"></a>`htcondor_password`

Data type: `Optional[String[1]]`

sets the access password

Default value: `undef`
