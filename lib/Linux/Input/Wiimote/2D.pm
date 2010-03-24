package Linux::Input::Wiimote::2D;

use Moose;

has [ qw( x y ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;
