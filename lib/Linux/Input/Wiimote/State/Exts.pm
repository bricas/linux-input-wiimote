package Linux::Input::Wiimote::State;

use Moose;
use namespace::autoclean;

has [ qw( nunchuk classic balance motionplus ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;
