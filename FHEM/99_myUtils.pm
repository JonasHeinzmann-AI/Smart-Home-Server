##############################################
# $Id: myUtilsTemplate.pm 7570 2015-01-14 18:31:44Z rudolfkoenig $
#
# Save this file as 99_myUtils.pm, and create your own functions in the new
# file. They are then available in every Perl expression.

package main;

use strict;
use warnings;
use POSIX;

sub
myUtils_Initialize($$)
{
  my ($hash) = @_;
}

# Enter you functions below _this_ line.
sub Kalenderstart ($)
{
    my ($Ereignis) = @_;
    my @Ereignisarray = split(/.*:\s/, $Ereignis);
    my $Ereignisteil1 = $Ereignisarray[1];
    my @uids = split(/;/, $Ereignisteil1);
    
    foreach my $uid (@uids) {
        my $Kalendertext = fhem("get Abfuhkalender summary $uid");
        if ($Kalendertext =~ /Papierbehaelter/) {
            fhem("set Papier_Tonne ja");
        };
        if ($Kalendertext =~ /Bioabfallbehaelter/) {
            fhem("set Bio_Tonne ja");
        };
        if ($Kalendertext =~ /Gelber Sack/) {
            fhem("set Gelber_Sack ja");
        };
		if ($Kalendertext =~ /Restabfallbehaelter/) {
            fhem("set Restmeull_Tonne ja");
        };
    };
}
sub Kalenderende ($) {
    my ($Ereignis) = @_;
    my @Ereignisarray = split(/.*:\s/, $Ereignis);
    my $Ereignisteil1 = $Ereignisarray[1];
    my @uids = split(/;/, $Ereignisteil1);
    
    foreach my $uid (@uids) {
        my $Kalendertext = fhem("get Abfuhkalender summary $uid");
        if ($Kalendertext =~ /Papierbehaelter/) {
            fhem("set Papier_Tonne nein");
        };
        if ($Kalendertext =~ /Bioabfallbehaelter/) {
            fhem("set Bio_Tonne nein");
        };
        if ($Kalendertext =~ /Gelber Sack/) {
            fhem("set Gelber_Sack nein");
        };
		if ($Kalendertext =~ /Restabfallbehaelter/) {
            fhem("set Restmeull_Tonne nein");
        };
    };
}

sub LichtimFlur ($$$){
my ($Led, $relay1, $relay2) = @_;
  if (State ($Led eq "on")) {
    fhem( "set $relay1 on" );
	fhem( "set $relay2 off" );
  }
  else {
    fhem( "set $relay1 off" );
	fhem( "set $relay2 on" );
  }
}
1;
