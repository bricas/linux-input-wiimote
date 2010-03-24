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

__END__

=head1 NAME

Linux::Input::Wiimote::Role::Buttons - A role for components with buttons

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009-2010 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
