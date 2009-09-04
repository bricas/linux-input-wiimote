package Linux::Input::Wiimote::State::Exts::Nunchuk;

use Moose;
use namespace::autoclean;

has [ qw( acc stick buttons ) ] => ( is => 'ro', init_arg => undef );

my %btn = (
    z => 0x0001,
    c => 0x0002,
);
for my $bt ( keys %btn ) {
    __PACKAGE__->meta->add_method( "button_${bt}" => sub { shift->buttons & $btn{ $bt } ? 1 : 0 } );
}

__PACKAGE__->meta->make_immutable;

sub button_pressed {
    my( $self, @btns ) = @_;
    my $buttons = $self->buttons;

    for( @btns ) {
        return 0 if !$buttons & $btn{ $_ };
    }

    return 1;
}

1;
