package Linux::Input::Wiimote::3D;

use Moose;

extends 'Linux::Input::Wiimote::2D';

has [ qw( z ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;
