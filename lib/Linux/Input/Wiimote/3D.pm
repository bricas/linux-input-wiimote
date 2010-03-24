package Linux::Input::Wiimote::3D;

use Moose;

extends 'Linux::Input::Wiimote::2D';

has [ qw( z ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Linux::Input::Wiimote::3D - Represent a 3D coordinate

=head1 SYNOPSIS

    my $point = Linux::Input::Wiimote::3D->new( x => 5, y => 5, z => 5 );

=head1 DESCRIPTION

This object is used to represent 3D data, such as accelerometer data in
the wiimote and the nunchuk.

=head1 METHODS

=head2 x( )

The x axis.

=head2 y( )

The y axis.

=head2 z( )

The z axis.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009-2010 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
