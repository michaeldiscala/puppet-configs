class httpd($documentroot = '/var/www/html') {
	$packages = ["httpd", "httpd-devel"]
	package {$packages: ensure => installed}
	service {"httpd": 
		enable  => true,
		ensure  => running,
		require => Package["httpd"],
	}

	file {"/etc/httpd/conf/httpd.conf":
		ensure  => present,
		content => template("httpd/httpd.conf.erb"),
		mode    => "0644",
		owner   => "root",
		group   => "root",
		notify  => Service["httpd"],
	}

	#Clean out the welcome config files
	$getting_started = ['/etc/httpd/conf.d/README', 
			    '/etc/httpd/conf.d/welcome.conf']
	file {$getting_started:
		ensure => absent,
		notify => Service["httpd"]
	}

	define vhost($domain_arg = '', $docroot_arg = '') {
		if ($domain_arg == '') {
			$vhost_domain = $name
		} else {
			$vhost_domain = $domain_arg
		}
		
		if ($docroot_arg == '') {
			$vhost_documentroot = "${httpd::documentroot}/${name}"
		} else {
			$vhost_documentroot = $docroot_arg
		}
		
		file { "/etc/httpd/conf.d/${vhost_domain}.conf":
			ensure  => present,
			content => template("httpd/vhost.conf.erb"),
			mode    => "0644",
			owner   => "root",
			group   => "root",
			notify  => Service["httpd"]
		}
	
		file { $vhost_documentroot: ensure => directory }
	} 
}

