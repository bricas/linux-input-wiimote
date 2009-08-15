#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <stdio.h>
#include <stdlib.h>
#include <cwiid.h>
#include "ppport.h"

typedef cwiid_wiimote_t *Linux__Input__Wiimote;
typedef struct cwiid_state *Linux__Input__Wiimote__State;

MODULE = Linux::Input::Wiimote  PACKAGE = Linux::Input::Wiimote

PROTOTYPES: DISABLE

Linux::Input::Wiimote
new( packname="Linux::Input::Wiimote", ... )
    char *packname
PREINIT:
    char *addr;
    bdaddr_t bdaddr;
    cwiid_wiimote_t *wiimote = NULL;
CODE:
    if( items > 1 ) {
        addr = (char *)SvPV_nolen( ST( 1 ) );
        str2ba( addr, &bdaddr );
    }
    else {
        bdaddr = *BDADDR_ANY;
    }

    wiimote = cwiid_open( &bdaddr, 0 );
    RETVAL = wiimote;
OUTPUT:
    RETVAL

void
DESTROY( self )
    Linux::Input::Wiimote self
CODE:
    cwiid_close( self );

int
id( self )
    Linux::Input::Wiimote self
CODE:
    RETVAL = cwiid_get_id( self );
OUTPUT:
    RETVAL

int
set_led_state( self, state )
    Linux::Input::Wiimote self
    unsigned char state
CODE:
    RETVAL = cwiid_set_led( self, state );
OUTPUT:
    RETVAL

int
set_rumble( self, rumble )
    Linux::Input::Wiimote self
    unsigned char rumble
CODE:
    RETVAL = cwiid_set_rumble( self, rumble );
OUTPUT:
    RETVAL    

Linux::Input::Wiimote::State
get_state( self )
    Linux::Input::Wiimote self
PREINIT:
    struct cwiid_state *state;
INIT:
    Newx( state, 1, struct cwiid_state );
CODE:
    cwiid_get_state( self, state );
    RETVAL = state;
OUTPUT:
    RETVAL

MODULE = Linux::Input::Wiimote  PACKAGE = Linux::Input::Wiimote::State

int
rumble( self )
    Linux::Input::Wiimote::State self
CODE:
    RETVAL = self->rumble;
OUTPUT:
    RETVAL

int
battery( self )
    Linux::Input::Wiimote::State self
CODE:
    RETVAL = self->battery;
OUTPUT:
    RETVAL

void
DESTROY( self )
    Linux::Input::Wiimote::State self
CODE:
    Safefree( self );
