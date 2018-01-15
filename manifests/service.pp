class awscli::service inherits awscli {

  #
  validate_bool($awscli::manage_docker_service)
  validate_bool($awscli::manage_service)
  validate_bool($awscli::service_enable)

  validate_re($awscli::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${awscli::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $awscli::manage_docker_service)
  {
    if($awscli::manage_service)
    {
      service { $awscli::params::service_name:
        ensure => $awscli::service_ensure,
        enable => $awscli::service_enable,
      }
    }
  }
}
