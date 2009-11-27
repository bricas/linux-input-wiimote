package Linux::Input::Wiimote::Ext::Nunchuk;

use Moose;
use namespace::autoclean;

with 'Linux::Input::Wiimote::Role::Buttons' => {
    constants => {
        z => 0x0001,
        c => 0x0002,
    }
};

has [ qw( acc stick ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;
