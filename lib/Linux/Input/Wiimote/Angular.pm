package Linux::Input::Wiimote::Angular;

use Moose;

has [ qw( phi theta psi ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Linux::Input::Wiimote::Angular - Represent angular data

=head1 SYNOPSIS

    my $rot = Linux::Input::Wiimote::Angular->new(
        phi => 0, theta => 0, psi => 0
    );

=head1 DESCRIPTION

The MotionPlus accessory has an angular rate sensor, whose data is
represented by this object.

=head1 METHODS

=head2 phi( )

Represents "roll", the rotational speed of x axis.

=head2 theta( )

Represents "pitch", the rotational speed of y axis.

=head2 psi( )

Represents "yaw", the rotational speed of z axis.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009-2010 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
