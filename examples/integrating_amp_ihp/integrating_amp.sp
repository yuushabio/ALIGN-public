* Integrating amplifier for ALIGN (flattened from IADC grp03_bio_adc_integ_3)
* Sized for the ihpsg13g2 ALIGN PDK:
*  - w is the per-finger width and must be a multiple of the abstraction
*    W-quantization pitch (260e-9); nf must be even
*  - all devices use a uniform 2.6e-6 finger (10 units), so device ratios
*    match the original 20/30/40/60 um totals exactly (total = w*nf)
*  - caps are given as values (ALIGN computes MIM plate size from the
*    cap_cmim density of ~1.5 fF/um^2: 756f -> ~22.45um x 22.45um)

.subckt integrating_amp ia_in ia_ip ia_on ia_op v_cm vdd vss
* Input resistors
r01 ia_in cap_sw_n resistor r=550
r02 ia_in cap_sw_n resistor r=550
r03 ia_in cap_sw_n resistor r=550
r04 ia_in cap_sw_n resistor r=550
r05 ia_in cap_sw_n resistor r=550
r06 ia_in cap_sw_n resistor r=550
r07 ia_in cap_sw_n resistor r=550
r08 ia_in cap_sw_n resistor r=550
r09 ia_in cap_sw_n resistor r=550
r010 ia_in cap_sw_n resistor r=550
r11 ia_ip cap_sw_p resistor r=550
r12 ia_ip cap_sw_p resistor r=550
r13 ia_ip cap_sw_p resistor r=550
r14 ia_ip cap_sw_p resistor r=550
r15 ia_ip cap_sw_p resistor r=550
r16 ia_ip cap_sw_p resistor r=550
r17 ia_ip cap_sw_p resistor r=550
r18 ia_ip cap_sw_p resistor r=550
r19 ia_ip cap_sw_p resistor r=550
r110 ia_ip cap_sw_p resistor r=550

* Integration capacitors
c01 cap_sw_n vss 456f
c02 cap_sw_n vss 456f
c03 cap_sw_n vss 456f
c04 cap_sw_n vss 456f
c05 cap_sw_n vss 456f
c06 cap_sw_n vss 456f
c07 cap_sw_n vss 456f
c08 cap_sw_n vss 456f
c09 cap_sw_n vss 456f
c010 cap_sw_n vss 456f
c10 cap_sw_p vss 456f
c11 cap_sw_p vss 456f
c12 cap_sw_p vss 456f
c13 cap_sw_p vss 456f
c14 cap_sw_p vss 456f
c15 cap_sw_p vss 456f
c16 cap_sw_p vss 456f
c17 cap_sw_p vss 456f
c18 cap_sw_p vss 456f
c19 cap_sw_p vss 456f
c110 cap_sw_p vss 456f

* Bias current (diode-connected NMOS, replaces switched i_ref block)
mbias ibias ibias vss vss sg13_lv_nmos l=0.13e-6 w=2.6e-6 nf=8 m=1
* Differential amplifier core (grp03_bio_adc_damp)
m4 ia_op cap_sw_p tail vss sg13_lv_nmos l=0.13e-6 w=2.6e-6 nf=12 m=1
m3 ia_on cap_sw_n tail vss sg13_lv_nmos l=0.13e-6 w=2.6e-6 nf=12 m=1
m2 tail ibias vss vss sg13_lv_nmos l=0.13e-6 w=2.6e-6 nf=24 m=1
m7 ia_on cmb vdd vdd sg13_lv_pmos l=0.13e-6 w=2.6e-6 nf=16 m=1
m6 ia_op cmb vdd vdd sg13_lv_pmos l=0.13e-6 w=2.6e-6 nf=16 m=1
* Common-mode feedback (grp03_bio_adc_cmfb)
m20 cm_n ia_on cm_tail_n vss sg13_lv_nmos l=0.13e-6 w=2.6e-6 nf=8 m=1
m21 cmb v_cm cm_tail_n vss sg13_lv_nmos l=0.13e-6 w=2.6e-6 nf=8 m=1
m22 cm_tail_n ibias vss vss sg13_lv_nmos l=0.13e-6 w=2.6e-6 nf=12 m=1
m12 cm_p ia_op cm_tail_p vss sg13_lv_nmos l=0.13e-6 w=2.6e-6 nf=8 m=1
m13 cmb v_cm cm_tail_p vss sg13_lv_nmos l=0.13e-6 w=2.6e-6 nf=8 m=1
m14 cm_tail_p ibias vss vss sg13_lv_nmos l=0.13e-6 w=2.6e-6 nf=12 m=1
m18 cm_n cm_n vdd vdd sg13_lv_pmos l=0.13e-6 w=2.6e-6 nf=8 m=1
m17 cmb cmb vdd vdd sg13_lv_pmos l=0.13e-6 w=2.6e-6 nf=8 m=1
m16 cm_p cm_p vdd vdd sg13_lv_pmos l=0.13e-6 w=2.6e-6 nf=8 m=1
m15 cmb cmb vdd vdd sg13_lv_pmos l=0.13e-6 w=2.6e-6 nf=8 m=1
.ends integrating_amp
