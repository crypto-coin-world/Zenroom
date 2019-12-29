#!/bin/sh

if ! [ -d $PWD/src ]; then
	echo "usage: ./build/codegen_ecp_factory.sh CURVE_NAME BIG_SIZE"
	return 1
fi

CN="${1:-BLS383}"
BS=""
case $CN in
	"BLS383") BS="384_29" ;;
	"BLS381") BS="384_29" ;;
	"BLS461") BS="464_28 " ;;
	"BLS48")  BS="560_29" ;;
esac

cat <<EOF > src/zen_ecp_factory.h
// Generated by build/codegen_ecp_factory.sh
// `date`

#ifndef __ZEN_ECP_${CN}_H__

#include <ecp_${CN}.h>
#include <ecp2_${CN}.h>
#include <ecdh_${CN}.h>
#include <pair_${CN}.h>

#define BIGSIZE 384
#include <zen_big_factory.h>
#include <zen_ecp.h>

#define ECP ECP_${CN}
#define ECP2 ECP2_${CN}

#define CURVE_NAME "${CN}"
#define CURVE_A CURVE_A_${CN}
#define CURVE_B Curve_B_${CN}
#define CURVE_B_I CURVE_B_I_${CN}
#define CURVE_Gx CURVE_Gx_${CN}
#define CURVE_Gy CURVE_Gy_${CN}
#define CURVE_Order CURVE_Order_${CN}
#define CURVE_Cofactor CURVE_Cof_${CN}
#define CURVE_G2xa CURVE_Pxa_${CN}
#define CURVE_G2xb CURVE_Pxb_${CN}
#define CURVE_G2ya CURVE_Pya_${CN}
#define CURVE_G2yb CURVE_Pyb_${CN}

#define ECP_copy(d,s) ECP_${CN}_copy(d,s)
#define ECP_set(d,x,y) ECP_${CN}_set(d, x, y)
#define ECP_setx(d,x,n) ECP_${CN}_setx(d, x, n)
#define ECP_affine(d) ECP_${CN}_affine(d)
#define ECP_inf(d) ECP_${CN}_inf(d)
#define ECP_isinf(d) ECP_${CN}_isinf(d)
#define ECP_unity(d) ECP_${CN}_isunity(d)
#define ECP_parity(d) ECP_${CN}_parity(d)
#define ECP_add(d,s) ECP_${CN}_add(d,s)
#define ECP_sub(d,s) ECP_${CN}_sub(d,s)
#define ECP_neg(d) ECP_${CN}_neg(d)
#define ECP_dbl(d) ECP_${CN}_dbl(d)
#define ECP_mul(d,b) ECP_${CN}_mul(d,b)
#define ECP_equals(l,r) ECP_${CN}_equals(l,r)
#define ECP_fromOctet(d,o) ECP_${CN}_fromOctet(d, o)
#define ECP_toOctet(o,d,b) ECP_${CN}_toOctet(o,d,b)
#define ECP_generator(e) ECP_${CN}_generator(e)
#define ECP_mapit(q,w) ECP_${CN}_mapit(q,w)
#define ECP_validate(o) ECP_${CN}_PUBLIC_KEY_VALIDATE(o)

#define FP2 FP2_${CN}
#define FP2_from_BIGs(x,a,b) FP2_${CN}_from_BIGs(x,a,b)

#define ECP2_copy(d,s) ECP2_${CN}_copy(d,s)
#define ECP2_set(d,x,y) ECP2_${CN}_set(d, x, y)
#define ECP2_setx(d,x) ECP2_${CN}_setx(d, x)
#define ECP2_affine(d) ECP2_${CN}_affine(d)
#define ECP2_inf(d) ECP2_${CN}_inf(d)
#define ECP2_isinf(d) ECP2_${CN}_isinf(d)
#define ECP2_add(d,s) ECP2_${CN}_add(d,s)
#define ECP2_sub(d,s) ECP2_${CN}_sub(d,s)
#define ECP2_neg(d) ECP2_${CN}_neg(d)
#define ECP2_dbl(d) ECP2_${CN}_dbl(d)
#define ECP2_mul(d,b) ECP2_${CN}_mul(d,b)
#define ECP2_equals(l,r) ECP2_${CN}_equals(l,r)
#define ECP2_fromOctet(d,o) ECP2_${CN}_fromOctet(d, o)
#define ECP2_toOctet(o,d) ECP2_${CN}_toOctet(o,d)
#define ECP2_generator(e) ECP2_${CN}_generator(e)
#define ECP2_mapit(q,w) ECP2_${CN}_mapit(q,w)

#define PAIR_ate(r,p,q) PAIR_${CN}_ate(r,p,q)
#define PAIR_fexp(x) PAIR_${CN}_fexp(x)
#define PAIR_G2mul(p,b)	PAIR_${CN}_G2mul(p,b)
#define PAIR_G1mul(p,b) PAIR_${CN}_G1mul(p,b)

#endif
EOF

cat <<EOF > src/zen_big_factory.h
// Generated by build/codegen_ecp_factory.sh
// `date`

#ifndef __ZEN_BIG_TYPES_H__
#define __ZEN_BIG_TYPES_H__
#include <arch.h>

#include <fp12_${CN}.h>
// cascades includes for big_ fp_ fp2_ and fp4_

#define BIG BIG_${BS}

// from milagro's pair_${CN}.h
extern void PAIR_${CN}_GTpow(FP12_${CN} *x,BIG_${BS} b);


// instance is in rom_field_XXX.c and included by fp_XXX.h
/* #define Modulus Modulus_BLS383
#define CURVE_Gx CURVE_Gx_BLS383
#define CURVE_Gy CURVE_Gy_BLS383
		 // 0x73435FD from rom_field_BLS383 at 32bit
*/

#define Montgomery MConst_${CN}

// CHUNK is 32bit

#define BIG  BIG_${BS}
#define DBIG DBIG_${BS}
#define MODBYTES MODBYTES_${BS}
#define BIGLEN NLEN_${BS}
#define DBIGLEN DNLEN_${BS}
#define BIG_zero(b) BIG_${BS}_zero(b)
#define BIG_fromBytesLen(b,v,l) BIG_${BS}_fromBytesLen(b,v,l)
#define BIG_inc(b,n) BIG_${BS}_inc(b,n)
#define BIG_norm(b) BIG_${BS}_norm(b)
#define BIG_nbits(b) BIG_${BS}_nbits(b)
#define BIG_copy(b,a) BIG_${BS}_copy(b,a)
#define BIG_rcopy(b,a) BIG_${BS}_rcopy(b,a)
#define BIG_shl(b,a) BIG_${BS}_shl(b,a)
#define BIG_shr(b,a) BIG_${BS}_shr(b,a)
#define BIG_fshl(b,a) BIG_${BS}_fshl(b,a)
#define BIG_fshr(b,a) BIG_${BS}_fshr(b,a)
#define BIG_dshl(b,a) BIG_${BS}_dshl(b,a)
#define BIG_dshr(b,a) BIG_${BS}_dshr(b,a)
#define BIG_parity(b) BIG_${BS}_parity(b)
#define BIG_isunity(b) BIG_${BS}_isunity(b)
#define BIG_toBytes(b,a) BIG_${BS}_toBytes(b,a)
#define BIG_comp(l,r) BIG_${BS}_comp(l,r)
#define BIG_add(d,l,r) BIG_${BS}_add(d,l,r)
#define BIG_sub(d,l,r) BIG_${BS}_sub(d,l,r)
#define BIG_mul(d,l,r) BIG_${BS}_mul(d,l,r)
#define BIG_mod(x,n) BIG_${BS}_mod(x,n)
#define BIG_invmodp(x,y,n) BIG_${BS}_invmodp(x,y,n)
#define BIG_monty(d,m,c,s) BIG_${BS}_monty(d,m,c,s)
// #define BIG_dmod(a,b,c) BIG_${BS}_dmod(a,b,c)
#define BIG_sdiv(x,n) BIG_${BS}_sdiv(x,n)
#define BIG_ddiv(d,l,r) BIG_${BS}_ddiv(d,l,r)
#define BIG_modmul(x,y,z,n) BIG_${BS}_modmul(x,y,z,n)
#define BIG_moddiv(x,y,z,n) BIG_${BS}_moddiv(x,y,z,n)
#define BIG_modsqr(x,y,n) BIG_${BS}_modsqr(x,y,n)
#define BIG_modneg(x,y,n) BIG_${BS}_modneg(x,y,n)
#define BIG_jacobi(x,y) BIG_${BS}_jacobi(x,y)
#define BIG_random(m,r) BIG_${BS}_random(m,r)
#define BIG_randomnum(m,q,r) BIG_${BS}_randomnum(m,q,r)

#define BIG_sqr(x,y) BIG_${BS}_sqr(x,y);
#define BIG_dcopy(d,s) BIG_${BS}_dcopy(d,s)
#define BIG_sducopy(d,s) BIG_${BS}_sducopy(d,s)
#define BIG_sdcopy(d,s) BIG_${BS}_sdcopy(d,s)
#define BIG_dnorm(x) BIG_${BS}_dnorm(x)
#define BIG_dcomp(l,r) BIG_${BS}_dcomp(l,r)
#define BIG_dscopy(d,s) BIG_${BS}_dscopy(d,s)
#define BIG_dsub(d,l,r) BIG_${BS}_dsub(d,l,r)
#define BIG_dadd(d,l,r) BIG_${BS}_dadd(d,l,r)
#define BIG_dmod(d,l,r) BIG_${BS}_dmod(d,l,r)
#define BIG_dfromBytesLen(d,o,l) BIG_${BS}_dfromBytesLen(d,o,l)
#define BIG_dzero(d) BIG_${BS}_dzero(d)
#define BIG_dnbits(d) BIG_${BS}_dnbits(d)

#define FP FP_${CN}
#define FP_nres(f,b) FP_${CN}_nres(f,b)
#define FP_copy(d,s) FP_${CN}_copy(d,s)
#define FP_redc(x,y) FP_${CN}_redc(x,y)
#define FP_reduce(x) FP_${CN}_reduce(x)
#define FP_mod(d,s) FP_${CN}_mod(d,s)

#define FP12 FP12_${CN}
// #define FP12_zero(b) FP12_${CN}_zero(b)
#define FP12_copy(d,s) FP12_${CN}_copy(d,s)
#define FP12_eq(l,r) FP12_${CN}_equals(l,r)
// #define FP12_cmove(d,s,c) FP12_${CN}_cmove(d,s,c)
#define FP12_fromOctet(f,o) FP12_${CN}_fromOctet(f,o)
#define FP12_toOctet(o,f) FP12_${CN}_toOctet(o,f)
#define FP12_mul(l, r) FP12_${CN}_mul(l, r)
// #define FP12_imul(d, l, r) FP12_${CN}_imul(d, l, r)
#define FP12_sqr(d, s) FP12_${CN}_sqr(d, s)
// #define FP12_add(d, l, r) FP12_${CN}_add(d, l, r)
// #define FP12_sub(d, l, r) FP12_${CN}_sub(d, l, r)
#define FP12_div2(d, s) FP12_${CN}_div2(d,s)
#define FP12_GTpow(x, b) PAIR_${CN}_GTpow(x,b)
// #define FP12_pinpow(r, x, b) FP12_${CN}_pinpow(r,x,b)

// #define FP12_sqrt(d,s) FP12_${CN}_sqrt(d,s)
// #define FP12_neg(d,s) FP12_${CN}_neg(d,s)
// #define FP12_reduce(f) FP12_${CN}_reduce(f)
// #define FP12_norm(f) FP12_${CN}_norm(f)
// #define FP12_qr(f) FP12_${CN}_qr(f)
#define FP12_inv(d,s) FP12_${CN}_inv(d,s)

#endif // _H_
EOF
