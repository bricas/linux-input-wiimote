use inc::Module::Install 0.68;
use Devel::AssertOS 'Linux';
use Devel::CheckLib;
use Config;

if ( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Linux/Input/Wiimote.pm > README' );

    include 'Devel::CheckLib';
    include 'Devel::CheckOS';
    include 'Devel::AssertOS';
    include 'Devel::AssertOS::Linux';
}

my @libs = ( 'cwiid', 'bluetooth' );
my $libpath = [ grep { -d } split( / /, $Config{'libpth'} ) ];
check_lib_or_exit( lib => \@libs, libpath => $libpath ); 

name 'Linux-Input-Wiimote';
all_from 'lib/Linux/Input/Wiimote.pm';

requires 'Moose';

test_requires 'Test::More';

makemaker_args LIBS => join( ' ', map { "-l${_}" } @libs );
ppport;

auto_install;
WriteAll;
