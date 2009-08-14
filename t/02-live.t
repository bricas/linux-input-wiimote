use strict;
use warnings;

use Test::More;

plan skip_all => '$ENV{WIIMOTE_ADDR} not set' if !exists $ENV{ WIIMOTE_ADDR };
plan tests => 3;

use_ok( 'Linux::Input::Wiimote' );

note( 'Press buttons 1 + 2 on your Wiimote' );

my $wiimote = Linux::Input::Wiimote->new( $ENV{ WIIMOTE_ADDR } || () );
BAIL_OUT 'Unable to connect Wiimote' unless $wiimote;

isa_ok( $wiimote, 'Linux::Input::Wiimote' );

note( 'Wiimote ID: ' . $wiimote->id );

#$wiimote->set_led_state( 1 );
#$wiimote->set_led_state( 2 );
#$wiimote->set_led_state( 4 );
#$wiimote->set_led_state( 8 );
#$wiimote->set_led_state( 0 );

#$wiimote->set_rumble( 1 );
#$wiimote->set_rumble( 0 );

my $state = $wiimote->get_state;
is( $state->rumble, 0, 'state->rumble' );

my $status = $wiimote->disconnect;
is( $status, 0, 'disconnect' );
