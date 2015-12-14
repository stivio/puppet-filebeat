class filebeat::config {

  $filebeat_config = {
    'filebeat' => {
      'spool_size'    => $filebeat::spool_size,
      'idle_timeout'  => $filebeat::idle_timeout,
      'registry_file' => $filebeat::registry_file,
      'config_dir'    => $filebeat::config_dir,
    },
    'output'   => $filebeat::outputs,
    'shipper'  => $filebeat::shipper,
    'logging'  => $filebeat::logging,
  }

  if $filebeat::config_template {
    $template_file = $filebeat::config_template
  } else {
    $template_file = versioncmp($::puppetversion, '4.0.0') ? {
      '-1'    => "${module_name}/filebeat3.yml.erb",
      default => "${module_name}/filebeat.yml.erb",
    }
  }

  file {'filebeat.yml':
    ensure  => file,
    path    => '/etc/filebeat/filebeat.yml',
    content => template("${template_file}"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Service['filebeat'],
  }

  file {'filebeat-config-dir':
    ensure  => directory,
    path    => $filebeat::config_dir,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => $filebeat::purge_conf_dir,
    purge   => $filebeat::purge_conf_dir,
  }
}
