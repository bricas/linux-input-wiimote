use inc::Module::Install 0.68;
use ExtUtils::Liblist;
use lib 'inc';
use Devel::AssertOS 'Linux';

if ( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Linux/Input/Wiimote.pm > README' );

    include 'Devel::AssertOS';
    include 'Devel::AssertOS::Linux';
}

my @libvars = ExtUtils::Liblist->ext( '-lcwiimote -lbluetooth', 0, 1 );

if( @{ $libvars[ 4 ] } != 2 ) {
    die 'libcwiimote or libbluetooth not installed; aborting.';
}

name 'Linux-Input-Wiimote';
all_from 'lib/Linux/Input/Wiimote.pm';

test_requires 'Test::More';

makemaker_args
    INC    => '-Isrc/libwiimote-0.4/src',
    LIBS   => $libvars[ 2 ],
    DEFINE => '-D_ENABLE_TILT -D_ENABLE_FORCE';

auto_install;
WriteAll;
