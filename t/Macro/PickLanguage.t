#-------------------------------------------------------------------
# WebGUI is Copyright 2001-2009 Plain Black Corporation.
#-------------------------------------------------------------------
# Please read the legal notices (docs/legal.txt) and the license
# (docs/license.txt) that came with this distribution before using
# this software.
#-------------------------------------------------------------------
# http://www.plainblack.com                     info@plainblack.com
#-------------------------------------------------------------------

use FindBin;
use strict;
use lib "$FindBin::Bin/../lib";

use WebGUI::Test;
use WebGUI::Session;
use File::Spec;
use File::Copy;
use JSON;
use Data::Dumper;

use Test::More; # increment this value for each test you create
use Test::Deep;

my $session = WebGUI::Test->session;

my $numTests = 3;

$numTests += 1; #For the use_ok

plan tests => $numTests;

my $macro = 'WebGUI::Macro::PickLanguage';
my $loaded = use_ok($macro);
my $count = "0";
my $outputLinks; 
my $installedLanguages;
my $numberInstalledLanguages;
my $countBeforePigLatin;

SKIP: {

skip "Unable to load $macro", $numTests-1 unless $loaded;

$outputLinks = WebGUI::Macro::PickLanguage::process($session);
$installedLanguages = WebGUI::International->getLanguages();
$numberInstalledLanguages = scalar keys %$installedLanguages;
$count++ while ($outputLinks =~ /\?/g);
$countBeforePigLatin = $count;
is($count, $numberInstalledLanguages , "Just make links for installed languages: $count");

}
$count = "0";
installPigLatin();

$outputLinks = WebGUI::Macro::PickLanguage::process($session);
$installedLanguages = WebGUI::International->getLanguages();
$numberInstalledLanguages = scalar keys %$installedLanguages;
$count++ while ($outputLinks =~ /\?/g);
is($count, $numberInstalledLanguages , "After install links and installed languages should still match: $count");
is($count, $countBeforePigLatin + 1 , "The amount of languages should be higher after install");

sub installPigLatin {
        mkdir File::Spec->catdir(WebGUI::Test->lib, 'WebGUI', 'i18n', 'PigLatin');
        copy(
                WebGUI::Test->getTestCollateralPath('WebGUI.pm'),
                File::Spec->catfile(WebGUI::Test->lib, qw/WebGUI i18n PigLatin WebGUI.pm/)
        );
        copy(
                WebGUI::Test->getTestCollateralPath('PigLatin.pm'),
                File::Spec->catfile(WebGUI::Test->lib, qw/WebGUI i18n PigLatin.pm/)
        );
}

END {   unlink File::Spec->catfile(WebGUI::Test->lib, qw/WebGUI i18n PigLatin WebGUI.pm/);
        unlink File::Spec->catfile(WebGUI::Test->lib, qw/WebGUI i18n PigLatin.pm/);
        rmdir File::Spec->catdir(WebGUI::Test->lib, qw/WebGUI i18n PigLatin/);
}
