#!/bin/perl

use warnings;
use Time::HiRes;
# DEPENDENCIES
# Builtin
# Additional
use JSON;

# xz unzip zip
# shouldnt have openssl and wgetxpp
my @packages = qw(libc busybox perl sed binutils m4 gawk gmp mpfr mpc gcc zlib make patch openssl wget perl-compress-raw-zlib bzip2 perl-compress-raw-bzip2 perl-json perl-io-compress config-minimal curses dialog kernel autoconf automake libtool nano pppkg);

sub die_error {
	my ($text, $errcode) = @_;
	if(!defined($errcode)) {$errcode=1;}
	draw_popup($text);
	exit($errcode);
}
sub draw_appinst {
	my ($text, $prog, $height) = @_;
	if(!defined($height)) {$height=0;}
	system("dialog --gauge '".$text."' 0 0 ".int($prog)." </dev/null");
}
sub draw_popup {
	my $text = shift;
	my $tl = length($text)+4;
	system("dialog","--infobox",$text,"0","0");
}
my $pkg_len = @packages;
my $pkg_drop = 100.0/$pkg_len;
my $dir;
print "Where do you want to install Twili?: ";
chomp($dir =<>);
draw_popup("Preparing installer...");
my $prefix = $dir . "/";
my $time = 0;
system("mkdir -p ".$prefix."etc");
draw_popup("Updating pppkg...");
# system("wget http://twi.asiekierka.pl/repo/pppkg.ppk");
# system("tar xf pppkg.ppk");
# system("cp root/bin/pppkg files/pppkg");
# system("rm -rf root build.sh info.json pppkg.ppk");
system("cp files/pppkg.json ".$prefix."etc/");
draw_popup("Downloading repo...");
system("files/pppkg -P " . $prefix . " -u 2>&1") == 0
	or exit(2);
for(my $i=0;$i<$pkg_len;$i++) {
	draw_appinst("Installing " . $packages[$i] . "...",$i*$pkg_drop);
	open(PPPKG, "files/pppkg -P " . $prefix . " -di " . $packages[$i] . " 2>&1 |")
		or die_error("Couldn't download package " . $packages[$i] . "!",3);
	while(defined(my $info=<PPPKG>))
	{
		if($time<(Time::HiRes::time()-0.05))
		{
			my $tinfo = $info;
			$tinfo=~s/\n//;
			print $tinfo;
			draw_appinst("Installing " . $packages[$i] . "...\n\n".$info,$i*$pkg_drop);
			$time=Time::HiRes::time();
		}
	}
}
exit(0);
