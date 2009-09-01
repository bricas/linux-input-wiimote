#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <stdio.h>
#include <stdlib.h>
#include <cwiid.h>
#include "ppport.h"

typedef cwiid_wiimote_t *Linux__Input__Wiimote;
typedef struct cwiid_state Linux__Input__Wiimote__State;

SV *
_nunchuk_state_to_obj( struct nunchuk_state *nunchuk )
{
    HV *nun_hv = newHV();
    SV *rv;
    AV *acc = newAV();
    AV *stick = newAV();

    av_push( acc, newSVuv( nunchuk->acc[ CWIID_X ] ) );
    av_push( acc, newSVuv( nunchuk->acc[ CWIID_Y ] ) );
    av_push( acc, newSVuv( nunchuk->acc[ CWIID_Z ] ) );
    hv_store( nun_hv, "acc", 3,  newRV_noinc((SV *)acc ), 0 );

    av_push( stick, newSVuv( nunchuk->stick[ CWIID_X ] ) );
    av_push( stick, newSVuv( nunchuk->stick[ CWIID_Y ] ) );
    hv_store( nun_hv, "stick", 5,  newRV_noinc((SV *)stick ), 0 );

    hv_store( nun_hv, "buttons", 7, newSVuv( nunchuk->buttons ), 0 ); 

    rv = newRV_noinc((SV *)nun_hv);
    return rv;
}

STATIC SV *
_state_struct_to_obj(struct cwiid_state state)
{
    SV *rv;
    HV *stash, *hv_state = newHV();
    AV *acc = newAV();
    AV *ir_src = newAV();
    HV *exts = newHV();
    int i;

    if (!hv_store( hv_state, "battery",     7,  newSVuv( state.battery  ), 0 )) croak ("failed to store battery");
    if (!hv_store( hv_state, "led",         3,  newSVuv( state.led      ), 0 )) croak ("failed to store led");
    if (!hv_store( hv_state, "report_mode", 11, newSVuv( state.rpt_mode ), 0 )) croak ("failed to store report_mode");
    if (!hv_store( hv_state, "rumble",      6,  newSVuv( state.rumble   ), 0 )) croak ("failed to store rumble");
    if (!hv_store( hv_state, "buttons",     7,  newSVuv( state.buttons  ), 0 )) croak ("failed to store buttons");
    if (!hv_store( hv_state, "error",       5,  newSVuv( state.error    ), 0 )) croak ("failed to store error");
    if (!hv_store( hv_state, "ext_type",    8,  newSVuv( state.ext_type ), 0 )) croak ("failed to store ext_type");

    av_push( acc, newSVuv( state.acc[ CWIID_X ] ) );
    av_push( acc, newSVuv( state.acc[ CWIID_Y ] ) );
    av_push( acc, newSVuv( state.acc[ CWIID_Z ] ) );
    if (!hv_store( hv_state, "acc", 3,  newRV_noinc((SV *)acc ), 0 )) croak ("failed to store acc");

    switch ( state.ext_type ) {
        case CWIID_EXT_NONE:
            break;
        case CWIID_EXT_UNKNOWN:
            break;
        case CWIID_EXT_NUNCHUK:
            hv_store( exts, "nunchuk", 7, _nunchuk_state_to_obj( &state.ext.nunchuk ), 0 );
            break;
        case CWIID_EXT_CLASSIC:
            break;
#ifdef CWIID_EXT_BALANCE
        case CWIID_EXT_BALANCE:
            break;
#endif
#ifdef CWIID_EXT_MOTIONPLUS
        case CWIID_EXT_MOTIONPLUS:
            break;
#endif
    }
    if (!hv_store( hv_state, "exts", 4, newRV_noinc((SV *)exts), 0 )) croak ("failed to store exts");

    for ( i = 0; i < 4; i++ ) {
        if ( state.ir_src[ i ].valid ) {
            HV *ir = newHV();
            hv_store( ir, "x", 1, newSVuv( state.ir_src[ i ].pos[ CWIID_X ] ), 0 ); 
            hv_store( ir, "y", 1, newSVuv( state.ir_src[ i ].pos[ CWIID_Y ] ), 0 ); 
            hv_store( ir, "size", 4, newSVuv( state.ir_src[ i ].size ), 0 ); 
            av_push( ir_src, newRV_noinc((SV *)ir) ); 
        }
    }
    if (!hv_store( hv_state, "ir", 2, newRV_noinc((SV *)ir_src), 0 )) croak ("failed to store ir");


    rv = newRV_noinc((SV *)hv_state);
    stash = gv_stashpvs("Linux::Input::Wiimote::State", 0);
    sv_bless(rv, stash);

    return rv;
}

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

    /* Send a command so state will work properly */
    if( wiimote )
        cwiid_set_rumble( wiimote, 0 );

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

int
set_rpt_mode( self, rpt_mode )
    Linux::Input::Wiimote self
    unsigned char rpt_mode
CODE:
    RETVAL = cwiid_set_rpt_mode( self, rpt_mode );
OUTPUT:
    RETVAL

Linux::Input::Wiimote::State
get_state( self )
    Linux::Input::Wiimote self;
PREINIT:
    struct cwiid_state state;
CODE:
    cwiid_get_state( self, &state );
    RETVAL = state;
OUTPUT:
    RETVAL
