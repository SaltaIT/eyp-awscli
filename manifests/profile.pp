define awscli::profile(
                        $aws_access_key_id,
                        $aws_secret_access_key,
                        $region      = 'eu-central-1',
                        $output      = 'json',
                        $home        = '/root',
                        $username    = 'root',
                        $group       = 'root',
                        $profilename = $name,
                        $order       = '42',
                      ) {
  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin'
  }

  if(!defined(Concat["${home}/.aws/config"]))
  {
    file { "${home}/.aws":
      ensure => 'directory',
      owner  => $username,
      group  => $group,
      mode   => '0750',
    }

    concat { "${home}/.aws/config":
      ensure  => 'present',
      owner   => $username,
      group   => $group,
      mode    => '0640',
      require => File["${home}/.aws"],
    }

    concat::fragment{ "${home} awscli banner":
      target  => "${home}/.aws/config",
      order   => '00',
      content => "# puppet managed file\n",
    }
  }

  concat::fragment{ "${home} awscli config profile ${profilename}":
    target  => "${home}/.aws/config",
    order   => $order,
    content => template("${module_name}/profile.erb"),
  }
}
