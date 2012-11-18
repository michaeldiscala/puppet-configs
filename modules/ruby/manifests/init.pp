class ruby {
	$ruby_pkgs = ["ruby19", "ruby19-devel"]
	package { $ruby_pkgs: ensure => installed }
}
