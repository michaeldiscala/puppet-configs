node default {
	$ruby_version = 'ruby-1.9.3-p327'
	$passenger_version = '3.0.17'

	include base
	include httpd
	include rvm
	rvm_system_ruby { $ruby_version:
		ensure      => "present",
		default_use => true,
		before      => Class["rvm::passenger::apache"],
	}
	class { "rvm::passenger::apache":
		ruby_version => $ruby_version,
		version      => $passenger_version,
		require      => Class["httpd", "rvm"], 
	} 


}
