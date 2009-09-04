package Linux::Input::Wiimote::State::Exts::Balance;

use Moose;
use namespace::autoclean;

has [ qw( right_top right_bottom left_top left_bottom ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;
