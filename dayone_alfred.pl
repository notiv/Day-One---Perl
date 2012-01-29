#!/usr/bin/perl

# dayone_alfred.pl
# Viton Vitanis (http://notiv.gr)
# Modification of the original ruby script of Brett Terpstra (http://brettterpstra.com)
#
# This script uses the CLI of Day One (http://dayoneapp.com/) and parses 
# an input string starting with (optional) exclamation mark for starred entries and 
# a date string in square brackets []. The date could alternatively be entered 
# at the end of the string after the -d identifier.
#
# Required Module: 	Date::Manip (for date processing) 
# 					http://search.cpan.org/perldoc?Date::Manip
# 	
# Examples:
# perl dayone_alfred.pl ! [2011-02-15] An entry in Day One
# perl dayone_alfred.pl [last Friday ατ 20.00] Something I did last Friday at 20.00 pm
# perl dayone_alfred.pl Another thing I did 3 days ago -d last Friday at 8pm
#

use strict;
use warnings;

use Date::Manip;

my $input;							# User input
my $starred = "false"; 				# Flag for starred entries

my $date = new Date::Manip::Date; 	# Date::Manip::Date object
my $date_string;					# Corresponding date string
my $err;							# Error flag in case parsing unsuccessful

my $cmd; 							# DayOne command to be executed

if( @ARGV > 0 ){
	$input = "@ARGV";
} else {
	print "Log entry: ";
	chomp( $input = <>);
}

# If input starts with a star or an exclamation mark, entry will be starred
$starred = "true" if $input =~ /^!/;

# Remove ! and any subsequent spaces
$input =~ s/^!\s+//;

# If there is a date specified, parse and remove it from $input
if( $input =~ /^\[(.*)\]/ ){
	# $date_string = DateTimeX::Easy->new($1);
	$err = $date->parse($1);
	$input =~ s/^\[.*\]//;
} elsif ($input =~ /\-d\s+(.*)/) {
	# $date_string = DateTimeX::Easy->new($1);
	$err = $date->parse($1);
	$input =~ s/\s+\-d\s+.*//;
}

# print "$err\n";
# If parsing unsuccessful or no date specified, assume date is now (empty string)
if( $err eq 0 ) {
	$date_string = $date->printf("%m\/%d\/%Y\/%H\/%M\/%S")
} else {
	$date_string = "";
}

# Build the command to create a new entry in Day One and run it
$cmd = join "", "echo ", $input, "| /Applications/Day\\ One.app/Contents/MacOS/dayone -d=", $date_string, " -s=", $starred, " new\n";
# print "$cmd\n";

exec "$cmd";



