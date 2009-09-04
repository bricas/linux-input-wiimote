package Linux::Input::Wiimote::State::Exts::MotionPlus;

use Moose;
use namespace::autoclean;

has [ qw( angle_rate ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;
