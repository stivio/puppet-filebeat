class filebeat::install {
  anchor { 'filebeat::install::begin': }

  case $::kernel {
    'Linux':   {
      class{ 'filebeat::install::linux': }
      Anchor['filebeat::install::begin'] -> Class['filebeat::install::linux'] -> Anchor['filebeat::install::end']
      if $::filebeat::manage_repo {
        class { 'filebeat::repo': }
        Class['filebeat::repo'] -> Class['filebeat::install::linux']
      }
    }
    'Windows': {
      class{'filebeat::install::windows':}
      Anchor['filebeat::install::begin'] -> Class['filebeat::install::windows'] -> Anchor['filebeat::install::end']
    }
    default:   {
      fail($filebeat::kernel_fail_message)
    }
  }

  anchor { 'filebeat::install::end': }
}
