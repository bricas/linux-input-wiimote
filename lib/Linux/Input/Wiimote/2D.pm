package Linux::Input::Wiimote::2D;

use Moose;

has [ qw( x y ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Linux::Input::Wiimote::2D - Represent a 2D coordinate

=head1 SYNOPSIS

    my $point = Linux::Input::Wiimote::2D->new( x => 5, y => 5 );

=head1 DESCRIPTION

This object is used to represent 2D data, such as the stick information for
the nunchuk and both sticks on the classic remote.

=head1 METHODS

=head2 x( )

The x axis.

=head2 y( )

The y axis.

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009-2010 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
