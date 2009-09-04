package Linux::Input::Wiimote::State::Exts::Classic;

use Moose;
use namespace::autoclean;

has [ qw( l_stick r_stick buttons l r ) ] => ( is => 'ro', init_arg => undef );

my %btn = (
    up    => 0x0001,
    left  => 0x0002,
    zr    => 0x0004,
    x     => 0x0008,
    a     => 0x0010,
    y     => 0x0020,
    b     => 0x0040,
    zl    => 0x0080,
    r     => 0x0200,
    plus  => 0x0400,
    home  => 0x0800,
    minus => 0x1000,
    l     => 0x2000,
    down  => 0x4000,
    right => 0x8000,
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
