package Linux::Input::Wiimote::Role::Buttons;

use MooseX::Role::Parameterized;

parameter 'constants' => (
    isa      => 'HashRef',
    required => 1,
);

role {
    my $p = shift;
    my $constants = $p->constants;

    has 'buttons' => (
        is       => 'ro',
        init_arg => undef,
    );

    for my $bt ( keys %$constants ) {
        method "button_${bt}" => sub {
            my $self = shift;
            $self->buttons & $self->button_constants->{ $bt } ? 1 : 0;
        };
    }

    method 'button_pressed' => sub {
        my( $self, @btns ) = @_;
        my $buttons = $self->buttons;

        for( @btns ) {
            return 0 if !$buttons & $self->button_constants->{ $_ };
        }

        return 1;
    };

};

1;
