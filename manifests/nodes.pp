node default {
	include base
	include rvm
	rvm_system_ruby { 'ruby-1.9.3-p327':
		ensure      => "present",
		default_use => true,
	}

}
