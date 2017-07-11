#class profile::apache(
#  Boolean $default_vhost = false,
#  Integer $port          = 80,
#  String $docroot        = '/var/www',
#) {
#  class { '::apache':
#    default_vhost => $default_vhost,
#  }
#  ::apache::vhost { 'kikobr822.mylabserver.com':
#    port    => $port,
#    docroot => $docroot,
#  }
#  file {'/var/www/index.html':
#    ensure  => file,
#    content => 'Teste Page. This is a test',
#  }
#}

class profile::apache {
  class { '::apache':
    default_vhost => true,
  }

  $docroot = "/var/www/${facts['fqdn']}"

  ::apache::vhost { $facts['fqdn']:
    port    => 80,
    docroot => $docroot,
    before  => File["${docroot}/index.html"],
  }

  file {  "${docroot}/index.html":
    content => "Test pageThis is a test",
  }
}
