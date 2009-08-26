package Linux::Input::Wiimote::State;

use Moose;
use namespace::autoclean;

has [ qw(rumble battery report_mode led buttons acc ) ] => ( is => 'ro', init_arg => undef );

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

sub acc_x {
    return shift->acc->[ 0 ];
}

sub acc_y {
    return shift->acc->[ 1 ];
}

sub acc_z {
    return shift->acc->[ 2 ];
}

sub btn_2 {
    return shift->buttons & 0x0001 ? 1 : 0;
}

sub btn_1 {
    return shift->buttons & 0x0002 ? 1 : 0;
}

sub btn_b {
    return shift->buttons & 0x0004 ? 1 : 0;
}

sub btn_a {
    return shift->buttons & 0x0008 ? 1 : 0;
}

sub btn_minus {
    return shift->buttons & 0x0010 ? 1 : 0;
}

sub btn_home {
    return shift->buttons & 0x0080 ? 1 : 0;
}

sub btn_left {
    return shift->buttons & 0x0100 ? 1 : 0;
}

sub btn_right {
    return shift->buttons & 0x0200 ? 1 : 0;
}

sub btn_down {
    return shift->buttons & 0x0400 ? 1 : 0;
}

sub btn_up {
    return shift->buttons & 0x0800 ? 1 : 0;
}

sub btn_plus {
    return shift->buttons & 0x1000 ? 1 : 0;
}

1;
