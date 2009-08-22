package Linux::Input::Wiimote::State;

use Moose;
use namespace::autoclean;

has [qw/rumble battery report_mode led/] => (is => 'ro', init_arg => undef);

__PACKAGE__->meta->make_immutable;

1;
