use strict;
use warnings;

use Test::More;

plan skip_all => '$ENV{WIIMOTE_ADDR} not set' if !exists $ENV{ WIIMOTE_ADDR };
plan tests => 10;

use_ok( 'Linux::Input::Wiimote' );

note( 'Press buttons 1 + 2 on your Wiimote' );

my $wiimote = Linux::Input::Wiimote->new( $ENV{ WIIMOTE_ADDR } || () );
BAIL_OUT 'Unable to connect Wiimote' unless $wiimote;

isa_ok( $wiimote, 'Linux::Input::Wiimote' );

note( 'Wiimote ID: ' . $wiimote->id );

# test rumble
{
    my $state = $wiimote->get_state;
    is( $state->rumble, 0, 'rumble off' );

    $wiimote->set_rumble(1);
    $state = $wiimote->get_state;
    is( $state->rumble, 1, 'rumble on' );

    $wiimote->set_rumble(0);
    $state = $wiimote->get_state;
    is( $state->rumble, 0, 'rumble off' );
}

# test battery
{
    my $state = $wiimote->get_state;
    ok( $state->battery > 0, 'battery: ' . $state->battery );
}

# test report mode
{
    my $state = $wiimote->get_state;
    is( $state->report_mode, 0, 'report mode: none' );
}

# test led
{
    my $state = $wiimote->get_state;
    is( $state->led, 0, 'leds off'  );

    $wiimote->set_led_state( 2 );
    $state = $wiimote->get_state;
    is( $state->led, 2, 'led 2 on' );

    $wiimote->set_led_state( 0 );
    $state = $wiimote->get_state;
    is( $state->led, 0, 'leds off' );
}

#$wiimote->set_led_state( 1 );
#$wiimote->set_led_state( 2 );
#$wiimote->set_led_state( 4 );
#$wiimote->set_led_state( 8 );
#$wiimote->set_led_state( 0 );
