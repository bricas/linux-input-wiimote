use strict;
use warnings;

use Test::More;

plan skip_all => '$ENV{WIIMOTE_ADDR} not set' if !exists $ENV{ WIIMOTE_ADDR };
plan tests => 22;

use_ok( 'Linux::Input::Wiimote' );

note( 'Press buttons 1 + 2 on your Wiimote' );

my $wiimote = Linux::Input::Wiimote->new( $ENV{ WIIMOTE_ADDR } || () );
BAIL_OUT 'Unable to connect Wiimote' unless $wiimote;

isa_ok( $wiimote, 'Linux::Input::Wiimote' );

note( 'Wiimote ID: ' . $wiimote->id );

diag explain $wiimote->get_state;

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

    for( 0..3 ) {
        my $led_bit = 2 ** $_;
        my $led_num = $_ + 1;

        $wiimote->set_led_state( $led_bit );
        $state = $wiimote->get_state;
        is( $state->led, $led_bit, "led ${led_num} on" );

        my $method = "led_${led_num}";
        is( $state->$method, 1, "onvenience method: $method" );
    }

    $wiimote->set_led_state( 15 );
    $state = $wiimote->get_state;
    is( $state->led_1, 1, 'all on: led 1' );    
    is( $state->led_2, 1, 'all on: led 2' );    
    is( $state->led_3, 1, 'all on: led 3' );    
    is( $state->led_4, 1, 'all on: led 4' );    

    $wiimote->set_led_state( 0 );
    $state = $wiimote->get_state;
    is( $state->led, 0, 'leds off' );
}

# test buttons
{
    my $state = $wiimote->get_state;
    is( $state->buttons, 0, 'no buttons pressed' );
}

