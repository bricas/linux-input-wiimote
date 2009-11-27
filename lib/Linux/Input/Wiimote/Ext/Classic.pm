package Linux::Input::Wiimote::Ext::Classic;

use Moose;
use namespace::autoclean;

with 'Linux::Input::Wiimote::Role::Buttons' => {
    constants => {
        up    => 0x0001,
        left  => 0x0002,
        zr    => 0x0004,
        x     => 0x0008,
        a     => 0x0010,
        y     => 0x0020,
        b     => 0x0040,
        zl    => 0x0080,
        r     => 0x0200,
        plus  => 0x0400,
        home  => 0x0800,
        minus => 0x1000,
        l     => 0x2000,
        down  => 0x4000,
        right => 0x8000,
    }
};

has [ qw( l_stick r_stick l r ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;
