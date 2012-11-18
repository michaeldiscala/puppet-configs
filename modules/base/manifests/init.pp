class base {
	$default_packages = ["gcc", "git", "glibc-devel", "make"]
	package { $default_packages:  ensure => installed }
}
