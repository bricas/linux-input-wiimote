package Linux::Input::Wiimote;

use strict;
use warnings;
use Linux::Input::Wiimote::State;
use Linux::Input::Wiimote::2D;
use Linux::Input::Wiimote::3D;
use Linux::Input::Wiimote::Angular;
use Linux::Input::Wiimote::IR;

use base qw( DynaLoader );

our $VERSION = '0.05001';

bootstrap Linux::Input::Wiimote $VERSION;

1;

__END__

=head1 NAME

Linux::Input::Wiimote - Perl interface to the libcwiid library

=head1 SYNOPSIS

    # search for a wiimote
    # NB: must be in discovery mode (press buttons 1 + 2)
    my $wiimote = Linux::Input::Wiimote->new;

    # turn on rumble for 3 seconds
    $wiimote->set_rumble( 1 );
    sleep( 3 );
    $wiimote->set_rumble( 0 );

=head1 DESCRIPTION

This module aims to provide simple perl bindings for the libcwiid library.

=head1 METHODS

=head2 new( [$addr] )

Connects to a wiimote. You may either specify a specific address, or leave
it out entirely to let the library pick the first available wiimote. Returns 
undef on failure.

=head2 id( )

Returns a unique integer represeting this wiimote.

=head2 set_led_state( $flag )

Set the state of the LEDs on the wiimote. C<$flag> is a simple bitmask
where each bit represents an LED.

    # turn the 3rd LED on
    $wiimote->set_led_state( 0x04 );

    # turn the 1st and 4th LEDs on
    $wiimote->set_led_state( 0x01 & 0x08 );

=head2 set_rumble( $flag )

Set the state of the rumble function on the wiimote. C<$flag> is a simple
boolean value.

    # turn rumble on
    $wiimote->set_rumble( 1 );

    # turn rumble off
    $wiimote->set_rumble( 0 );

=head2 set_rpt_mode( $mode )

=head2 get_state( )

Returns a L<Linux::Input::Wiimote::State> object.

=head2 disconnect( )

Disconnect the wiimote. This will automatically happen when the object destroyed.

=head1 SEE ALSO

=over 4

=item * http://abstrakraft.org/cwiid/wiki/libcwiid

=back

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 ORIGINALLY WRITTEN BY

Chad Phillips E<lt>chad@chadphillips.orgE<gt>

=head1 THANK YOU

Florian Ragwitz for helping me along the way.

=head1 COPYRIGHT AND LICENSE

Copyright 2007 by Chad Phillips

Copyright 2007-2010 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

