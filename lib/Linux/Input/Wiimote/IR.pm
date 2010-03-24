package Linux::Input::Wiimote::IR;

use Moose;

extends 'Linux::Input::Wiimote::2D';

has [ qw( size ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;
