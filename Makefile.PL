use inc::Module::Install 0.68;
use ExtUtils::Liblist;
use lib 'inc';
use Devel::AssertOS 'Linux';

if ( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Linux/Input/Wiimote.pm > README' );

    include 'Devel::AssertOS';
    include 'Devel::AssertOS::Linux';
}

my @libvars = ExtUtils::Liblist->ext( '-llibcwiimote', 0, 0 );

# This is sub-optimal. We have the source under the src/ directory,
# we should be able to use it.
if( !$libvars[ 2 ] ) {
    die 'libcwiimote not installed; aborting.';
}

name 'Linux-Input-Wiimote';
all_from 'lib/Linux/Input/Wiimote.pm';

test_requires 'Test::More';

makemaker_args
    INC    => '-Isrc/libwiimote-0.4/src',
    LIBS   => '-lcwiimote -lbluetooth',
    DEFINE => '-D_ENABLE_TILT -D_ENABLE_FORCE';

auto_install;
WriteAll;
