class awscli::install inherits awscli {

  if($awscli::manage_package)
  {
    include ::python

    pythonpip { 'awscli':
      ensure => 'present',
    }
  }

}
