package Linux::Input::Wiimote::Angular;

use Moose;

has [ qw( phi theta psi ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;
