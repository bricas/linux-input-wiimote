package Linux::Input::Wiimote::State;

use Moose;
use namespace::autoclean;

has [ qw(rumble battery report_mode led buttons ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

sub led_1 {
    return shift->led & 0x01 ? 1 : 0;
}

sub led_2 {
    return shift->led & 0x02 ? 1 : 0;
}

sub led_3 {
    return shift->led & 0x04 ? 1 : 0;
}

sub led_4 {
    return shift->led & 0x08 ? 1 : 0;
}

1;
