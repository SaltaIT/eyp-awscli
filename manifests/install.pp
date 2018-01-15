class awscli::install inherits awscli {

  if($awscli::manage_package)
  {
    package { $awscli::params::package_name:
      ensure => $awscli::package_ensure,
    }
  }

}
