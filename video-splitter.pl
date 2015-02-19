use strict;
use warnings;
use Data::Dumper;

my $CMD_TEMPLATE = "ffmpeg -i <in> -ss <start> -t <duration> -vcodec copy -acodec copy -y <out>";
my $in = shift;
my $outdir = "video";

unless(defined $in) {
  die "Need input video";
}

my $count = 1;
foreach (<DATA>) {
	s/(\d+)\.(\d+)/($1*60)+$2/ge;
	if(m/(\d+)\s*-\s*(\d+)/ ) {
		my $start = $1;
		my $end = $2;
		my $dur = $end - $start;
		my $cmd = $CMD_TEMPLATE;
		$cmd =~ s/<in>/$in/g;
		$cmd =~ s/<start>/$start/g;
		$cmd =~ s/<duration>/$dur/g;
		$cmd =~ s#<out>#$count.mp4#g;
		system $cmd and die "Failed $cmd";
		$count++;
		
	} else {
		die "Bad input $_";
	}
}


__DATA__
7.07 - 7.27
