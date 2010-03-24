#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <stdio.h>
#include <stdlib.h>
#include <cwiid.h>
#include "ppport.h"

typedef cwiid_wiimote_t *Linux__Input__Wiimote;
typedef struct cwiid_state Linux__Input__Wiimote__State;

STATIC SV *
_nunchuk_state_to_obj( struct nunchuk_state *nunchuk )
{
    HV *stash, *nun_hv = newHV();
    SV *rv, *rv_acc, *rv_stick;
    HV *hv_acc = newHV();
    HV *hv_stick = newHV();

    // acc
    if (!hv_store( hv_acc, "x", 1, newSVuv( nunchuk->acc[ CWIID_X ] ), 0 )) croak ("failed to store acc->x");
    if (!hv_store( hv_acc, "y", 1, newSVuv( nunchuk->acc[ CWIID_Y ] ), 0 )) croak ("failed to store acc->y");
    if (!hv_store( hv_acc, "z", 1, newSVuv( nunchuk->acc[ CWIID_Z ] ), 0 )) croak ("failed to store acc->z");

    rv_acc = newRV_noinc((SV *)hv_acc);
    stash = gv_stashpvs("Linux::Input::Wiimote::3D", 0);
    sv_bless(rv_acc, stash);

    hv_store( nun_hv, "acc", 3, rv_acc, 0 );

    // stick
    if (!hv_store( hv_stick, "x", 1, newSVuv( nunchuk->stick[ CWIID_X ] ), 0 )) croak ("failed to store stick->x");
    if (!hv_store( hv_stick, "y", 1, newSVuv( nunchuk->stick[ CWIID_Y ] ), 0 )) croak ("failed to store stick->y");

    rv_stick = newRV_noinc((SV *)hv_stick);
    stash = gv_stashpvs("Linux::Input::Wiimote::2D", 0);
    sv_bless(rv_stick, stash);

    hv_store( nun_hv, "stick", 5, rv_stick, 0 );

    hv_store( nun_hv, "buttons", 7, newSVuv( nunchuk->buttons ), 0 ); 

    rv = newRV_noinc((SV *)nun_hv);
    stash = gv_stashpvs("Linux::Input::Wiimote::Ext::Nunchuk", 0);
    sv_bless(rv, stash);

    return rv;
}

STATIC SV *
_classic_state_to_obj( struct classic_state *classic )
{
    HV *stash, *classic_hv = newHV();
    SV *rv, *rv_l_stick, *rv_r_stick;
    HV *hv_l_stick = newHV();
    HV *hv_r_stick = newHV();

    // l_stick
    if (!hv_store( hv_l_stick, "x", 1, newSVuv( classic->l_stick[ CWIID_X ] ), 0 )) croak ("failed to store l_stick->x");
    if (!hv_store( hv_l_stick, "y", 1, newSVuv( classic->l_stick[ CWIID_Y ] ), 0 )) croak ("failed to store l_stick->y");

    rv_l_stick = newRV_noinc((SV *)hv_l_stick);
    stash = gv_stashpvs("Linux::Input::Wiimote::2D", 0);
    sv_bless(rv_l_stick, stash);

    hv_store( classic_hv, "l_stick", 7, rv_l_stick, 0 );

    // r_stick
    if (!hv_store( hv_r_stick, "x", 1, newSVuv( classic->r_stick[ CWIID_X ] ), 0 )) croak ("failed to store r_stick->x");
    if (!hv_store( hv_r_stick, "y", 1, newSVuv( classic->r_stick[ CWIID_Y ] ), 0 )) croak ("failed to store r_stick->y");

    rv_r_stick = newRV_noinc((SV *)hv_r_stick);
    stash = gv_stashpvs("Linux::Input::Wiimote::2D", 0);
    sv_bless(rv_r_stick, stash);

    hv_store( classic_hv, "r_stick", 7, rv_r_stick, 0 );

    hv_store( classic_hv, "buttons", 7, newSVuv( classic->buttons ), 0 ); 
    hv_store( classic_hv, "l", 1, newSVuv( classic->l ), 0 ); 
    hv_store( classic_hv, "r", 1, newSVuv( classic->r ), 0 ); 

    rv = newRV_noinc((SV *)classic_hv);
    stash = gv_stashpvs("Linux::Input::Wiimote::Ext::Classic", 0);
    sv_bless(rv, stash);

    return rv;
}

#ifdef CWIID_EXT_BALANCE
STATIC SV *
_balance_state_to_obj( struct balance_state *balance )
{
    HV *stash, *balance_hv = newHV();
    SV *rv;

    hv_store( balance_hv, "right_top", 9, newSVuv( balance->right_top ), 0 ); 
    hv_store( balance_hv, "right_bottom", 12, newSVuv( balance->right_bottom ), 0 ); 
    hv_store( balance_hv, "left_top", 8, newSVuv( balance->left_top ), 0 ); 
    hv_store( balance_hv, "left_bottom", 11, newSVuv( balance->left_bottom ), 0 ); 

    rv = newRV_noinc((SV *)balance_hv);
    stash = gv_stashpvs("Linux::Input::Wiimote::Ext::Balance", 0);
    sv_bless(rv, stash);

    return rv;
}
#endif

#ifdef CWIID_EXT_MOTIONPLUS
STATIC SV *
_motionplus_state_to_obj( struct motionplus_state *motionplus )
{
    HV *stash, *mp_hv = newHV();
    HV *hv_angle_rate = newAV();
    SV *rv, *rv_angle_rate;

    if (!hv_store( hv_angle_rate, "phi",   3, newSVuv( motionplus->angle_rate[ CWIID_PHI ] ), 0 )) croak ("failed to store angle_rate->phi");
    if (!hv_store( hv_angle_rate, "theta", 5, newSVuv( motionplus->angle_rate[ CWIID_THETA ] ), 0 )) croak ("failed to store angle_rate->theta");
    if (!hv_store( hv_angle_rate, "psi",   3, newSVuv( motionplus->angle_rate[ CWIID_PSI ] ), 0 )) croak ("failed to store angle_rate->psi");

    rv_angle_rate = newRV_noinc((SV *)hv_angle_rate);
    stash = gv_stashpvs("Linux::Input::Wiimote::Angular", 0);
    sv_bless(rv_angle_rate, stash);

    hv_store( mp_hv, "angle_rate", 10, rv_angle_rate, 0 );

    rv = newRV_noinc((SV *)mp_hv);
    stash = gv_stashpvs("Linux::Input::Wiimote::Ext::MotionPlus", 0);
    sv_bless(rv, stash);

    return rv;
}
#endif

STATIC SV *
_state_struct_to_obj(struct cwiid_state state)
{
    SV *rv, *rv_acc;
    HV *stash, *hv_state = newHV();
    HV *hv_acc = newHV();
    AV *ir_src = newAV();
    int i;

    if (!hv_store( hv_state, "battery",     7,  newSVuv( state.battery  ), 0 )) croak ("failed to store battery");
    if (!hv_store( hv_state, "led",         3,  newSVuv( state.led      ), 0 )) croak ("failed to store led");
    if (!hv_store( hv_state, "report_mode", 11, newSVuv( state.rpt_mode ), 0 )) croak ("failed to store report_mode");
    if (!hv_store( hv_state, "rumble",      6,  newSVuv( state.rumble   ), 0 )) croak ("failed to store rumble");
    if (!hv_store( hv_state, "buttons",     7,  newSVuv( state.buttons  ), 0 )) croak ("failed to store buttons");
    if (!hv_store( hv_state, "error",       5,  newSVuv( state.error    ), 0 )) croak ("failed to store error");

    // acc
    if (!hv_store( hv_acc, "x", 1, newSVuv( state.acc[ CWIID_X ] ), 0 )) croak ("failed to store acc->x");
    if (!hv_store( hv_acc, "y", 1, newSVuv( state.acc[ CWIID_Y ] ), 0 )) croak ("failed to store acc->y");
    if (!hv_store( hv_acc, "z", 1, newSVuv( state.acc[ CWIID_Z ] ), 0 )) croak ("failed to store acc->z");

    rv_acc = newRV_noinc((SV *)hv_acc);
    stash = gv_stashpvs("Linux::Input::Wiimote::3D", 0);
    sv_bless(rv_acc, stash);

    if (!hv_store( hv_state, "acc", 3, rv_acc, 0 )) croak ("failed to store acc");

    switch ( state.ext_type ) {
        case CWIID_EXT_NONE:
            break;
        case CWIID_EXT_UNKNOWN:
            break;
        case CWIID_EXT_NUNCHUK:
            hv_store( hv_state, "extension", 9, _nunchuk_state_to_obj( &state.ext.nunchuk ), 0 );
            break;
        case CWIID_EXT_CLASSIC:
            hv_store( hv_state, "extension", 9, _classic_state_to_obj( &state.ext.classic ), 0 );
            break;
#ifdef CWIID_EXT_BALANCE
        case CWIID_EXT_BALANCE:
            hv_store( hv_state, "extension", 9, _balance_state_to_obj( &state.ext.balance ), 0 );
            break;
#endif
#ifdef CWIID_EXT_MOTIONPLUS
        case CWIID_EXT_MOTIONPLUS:
            hv_store( hv_state, "extension", 9, _motionplus_state_to_obj( &state.ext.motionplus ), 0 );
            break;
#endif
    }

    for ( i = 0; i < CWIID_IR_SRC_COUNT; i++ ) {
        if ( state.ir_src[ i ].valid ) {
            HV *ir = newHV();
            hv_store( ir, "x", 1, newSVuv( state.ir_src[ i ].pos[ CWIID_X ] ), 0 ); 
            hv_store( ir, "y", 1, newSVuv( state.ir_src[ i ].pos[ CWIID_Y ] ), 0 ); 
            hv_store( ir, "size", 4, newSVuv( state.ir_src[ i ].size ), 0 ); 

            SV *rv_ir = newRV_noinc((SV *)ir);
            stash = gv_stashpvs("Linux::Input::Wiimote::IR", 0);
            sv_bless(rv_ir, stash);

            av_push( ir_src, rv_ir ); 
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
    struct acc_cal wm_cal;
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
    if( wiimote ) {
        cwiid_set_rumble( wiimote, 0 );
        cwiid_get_acc_cal( wiimote, CWIID_EXT_NONE, &wm_cal );
    }

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
PREINIT:
    struct acc_cal wm_cal;
CODE:
    // if we want NUNCHUK data, we should calibrate the acc
    if( rpt_mode & CWIID_RPT_NUNCHUK != 0 ) {
        cwiid_get_acc_cal( self, CWIID_EXT_NUNCHUK, &wm_cal );
    }

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

int
disconnect( self )
    Linux::Input::Wiimote self;
CODE:
    RETVAL = cwiid_close( self );
OUTPUT:
    RETVAL
