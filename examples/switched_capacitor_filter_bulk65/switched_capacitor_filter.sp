** Switched-capacitor filter adapted for the Bulk65nm mock PDK (pdks/Bulk65nm_Mock_PDK)
** Derived from examples/switched_capacitor_filter (ASAP7 version)
** Device sizing notes:
**  - w is the per-finger width and must be a multiple of the abstraction
**    W-quantization pitch (100e-9); all devices use w=1.0e-6 (10 units)
**  - nf carries the original nfin*nf drive ratios (input pair 72 -> nf=12,
**    cascodes 36 -> nf=6, PMOS loads 12 -> nf=2); l=60e-9 (65nm node)
**  - cap values scaled 4x from the ASAP7 original (30f/60f -> 120f/240f),
**    matching the sky130/ihpsg13g2 adaptations
**  - m6/m7 (PMOS cascode) bulks are tied to vdd instead of the original
**    source-tied bodies: this PDK's body-contact scheme cannot route an
**    isolated source-tied nwell, which left those nets open in LVS

.subckt telescopic_ota d1 vdd vinn vinp vss vbiasn vbiasp1 vbiasp2 voutn voutp
m9 voutn vbiasn net8 vss nmos_rvt w=1.0e-6 l=60e-9 nf=6
m8 voutp vbiasn net014 vss nmos_rvt w=1.0e-6 l=60e-9 nf=6
m5 d1 d1 vss vss nmos_rvt w=1.0e-6 l=60e-9 nf=4
m4 net10 d1 vss vss nmos_rvt w=1.0e-6 l=60e-9 nf=6
m3 net014 vinn net10 vss nmos_rvt w=1.0e-6 l=60e-9 nf=12
m0 net8 vinp net10 vss nmos_rvt w=1.0e-6 l=60e-9 nf=12
m7 voutp vbiasp2 net012 vdd pmos_rvt w=1.0e-6 l=60e-9 nf=4
m6 voutn vbiasp2 net06 vdd pmos_rvt w=1.0e-6 l=60e-9 nf=4
m2 net012 vbiasp1 vdd vdd pmos_rvt w=1.0e-6 l=60e-9 nf=2
m1 net06 vbiasp1 vdd vdd pmos_rvt w=1.0e-6 l=60e-9 nf=2
.ends telescopic_ota
** End of subcircuit definition.

.subckt switched_capacitor_filter voutn voutp vinp vinn id agnd vss vdd
m0 voutn phi1 net67 vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
m7 net66 phi1 net63 vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
m6 net72 phi1 vinn vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
m3 agnd phi2 net67 vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
m5 agnd phi2 net63 vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
m4 net72 phi2 agnd vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
m8 net60 phi2 agnd vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
m11 agnd phi2 net68 vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
m9 agnd phi2 net62 vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
m10 net64 phi1 net62 vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
m12 net60 phi1 vinp vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
m14 voutp phi1 net68 vss nmos_rvt w=1.0e-6 l=60e-9 nf=2
xi0 id vdd net64 net66 vss vbiasn vbiasp1 vbiasp2 voutn voutp telescopic_ota
c9 voutp vss 240e-15
c8 voutn vss 240e-15
c7 net62 net68 120e-15
c6 net64 voutp 240e-15
c5 vinn net64 120e-15
c4 net60 net62 240e-15
c3 net66 voutn 240e-15
c2 vinp net66 120e-15
c1 net63 net67 120e-15
c0 net72 net63 240e-15
.ends switched_capacitor_filter
