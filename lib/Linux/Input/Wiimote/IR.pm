package Linux::Input::Wiimote::IR;

use Moose;

extends 'Linux::Input::Wiimote::2D';

has [ qw( size ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Linux::Input::Wiimote::IR - Represent IR point data

=head1 SYNOPSIS

    my $ir = Linux::Input::Wiimote::IR->new( x => 5, y => 5, size => 5 );

=head1 DESCRIPTION

IR sensor data is represented by a 2D point and a blob size value.

=head1 METHODS

=head2 x( )

The x axis.

=head2 y( )

The y axis.

=head2 size( )

The size of the blob.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009-2010 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
