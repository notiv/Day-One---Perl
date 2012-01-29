# Perl Script for Day One

## Info
This Perl script was programmed in order to be used as an extension within Alfred (http://www.alfredapp.com). It is based on a ruby implementation by Brett Terpstra (http://brettterpstra.com)

The script uses the CLI of Day One (http://dayoneapp.com/) and parses an input string starting with an (optional) exclamation mark for starred entries and a date string in square brackets []. The date could alternatively be entered at the end of the string after the -d identifier.

## Required Module for date processing
Date::Manip (http://search.cpan.org/perldoc?Date::Manip)

## Alfred Extension Command
The Day One Alfred extension is a shell script extension with the following command:
perl ~/path/to/perl/file/dayone_alfred.pl {query}
In the Advanced options in the extension tab "Backquotes" and "Semicolons" should be set to be escaped.

## Examples for the command line:
* perl dayone_alfred.pl ! [2011-02-15] An entry in Day One
* perl dayone_alfred.pl [last Friday at 20.00] Something I did last Friday at 20.00 pm
* perl dayone_alfred.pl Another thing I did 3 days ago -d last Friday at 8pm
