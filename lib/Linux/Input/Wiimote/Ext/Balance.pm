package Linux::Input::Wiimote::Ext::Balance;

use Moose;
use namespace::autoclean;

has [ qw( right_top right_bottom left_top left_bottom ) ] => ( is => 'ro', init_arg => undef );

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

Linux::Input::Wiimote::Ext::Balance - Balance Board Peripheral

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
