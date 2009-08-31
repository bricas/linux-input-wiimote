package Linux::Input::Wiimote::State;

use Moose;
use namespace::autoclean;

has [ qw(rumble battery report_mode led buttons acc ext_type ) ] => ( is => 'ro', init_arg => undef );

for my $l ( 0..3 ) {
    __PACKAGE__->meta->add_method( 'led_' . ( $l + 1 ) => sub { shift->led & ( 2 ** $l ) ? 1 : 0 } );
}

my @acc = qw( x y z );
for my $ac ( 0..2 ) {
    __PACKAGE__->meta->add_method( 'acc' . ( $acc[ $ac ] ) => sub { shift->acc->[ $ac ] } );
} 

my %btn = (
    2     => 0x0001,
    1     => 0x0002,
    b     => 0x0004,
    a     => 0x0008,
    minus => 0x0010,
    home  => 0x0080,
    left  => 0x0100,
    right => 0x0200,
    down  => 0x0400,
    up    => 0x0800,
    plus  => 0x1000,
);
for my $bt ( keys %btn ) {
    __PACKAGE__->meta->add_method( "button_${bt}" => sub { shift->buttons & $btn{ $bt } ? 1 : 0 } );
}

__PACKAGE__->meta->make_immutable;

sub battery_level {
    return 100 * shift->battery / 0xd0;
}

sub button_pressed {
    my( $self, @btns ) = @_;
    my $buttons = $self->buttons;

    for( @btns ) {
        return 0 if !$buttons & $btn{ $_ };
    }

    return 1;
}

1;
