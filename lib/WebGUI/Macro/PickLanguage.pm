package WebGUI::Macro::PickLanguage; # edit this line to match your own macro name

#-------------------------------------------------------------------
# WebGUI is Copyright 2001-2009 Plain Black Corporation.
#-------------------------------------------------------------------
# Please read the legal notices (docs/legal.txt) and the license
# (docs/license.txt) that came with this distribution before using
# this software.
#-------------------------------------------------------------------
# http://www.plainblack.com                     info@plainblack.com
#-------------------------------------------------------------------

use strict;

=head1 NAME

Package WebGUI::Macro::PickLanguage

=head1 DESCRIPTION

This macro makes a link for each installed language so when clicked the SetLanguage contetntHandler is called and sets the language in the scratch. The link text is the label from the language.

=head2 process( $session )

The main macro class, Macro.pm, will call this subroutine and pass it

=over 4

=item *

A session variable

=item *

This macro takes no parameters

=back

=cut


#-------------------------------------------------------------------
sub process {
	my $session = shift;
	my $i18n = WebGUI::International->new($session);
	my $languages = $i18n->getLanguages();
	my $outputLinks;
	foreach my $language ( keys %$languages ) {
		my $linkText = $i18n->getLanguage($language , 'label');
		$outputLinks .= '<a href="?op=setLanguage;language='. $language .'">'. $linkText . ' </a>';
	}
	return $outputLinks;
}

1;

#vim:ft=perl
