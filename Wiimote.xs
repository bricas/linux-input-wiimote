#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <stdio.h>
#include <stdlib.h>
#include <cwiid.h>
#include "ppport.h"

typedef cwiid_wiimote_t *Linux__Input__Wiimote;

MODULE = Linux::Input::Wiimote         PACKAGE = Linux::Input::Wiimote

PROTOTYPES: DISABLE

Linux::Input::Wiimote
_new( packname="Linux::Input::Wiimote", addr )
    char *packname
    char *addr
CODE:
    bdaddr_t bdaddr;
 
    if( strlen( addr ) > 0 ) {
        str2ba( addr, &bdaddr );
    }
    else {
        bdaddr = *BDADDR_ANY;
    }

    cwiid_wiimote_t *wiimote = NULL;
    wiimote = cwiid_open( &bdaddr, 0 );
    RETVAL = wiimote;
OUTPUT:
    RETVAL

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
    cwiid_set_led( self, state );
OUTPUT:
    RETVAL

int
set_rumble( self, rumble )
    Linux::Input::Wiimote self
    unsigned char rumble
CODE:
    cwiid_set_rumble( self, rumble );
OUTPUT:
    RETVAL    

int
disconnect( self )
    Linux::Input::Wiimote self
CODE:
    RETVAL = cwiid_close( self );
OUTPUT:
    RETVAL
