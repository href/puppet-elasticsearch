# Internal: Manages the elasticsearch package
#
class elasticsearch::package(
  $ensure  = $elasticsearch::params::ensure,
  $version = $elasticsearch::params::version,
  $package = $elasticsearch::params::package,
) inherits elasticsearch::params {

  $package_ensure = $ensure ? {
    present => $version,
    default => installed,
  }

  # if $::operatingsystem == 'Darwin' {
  #   homebrew::formula { 'elasticsearch': }
  # }

  package { 'java': 
    ensure => "present",
    provider => "brewcask",
    install_options => ['--appdir=/Applications', "--binarydir=${boxen::config::homebrewdir}/bin"]
  } ->

  package { $package:
    ensure  => $package_ensure,
  }

}
