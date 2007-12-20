use inc::Module::Install 0.68;

if ( -e 'MANIFEST.SKIP' ) {
    system( 'pod2text lib/Linux/Input/Wiimote.pm > README' );
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
