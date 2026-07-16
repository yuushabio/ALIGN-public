** Switched-capacitor filter adapted for the SkyWater SKY130 PDK
** Derived from examples/switched_capacitor_filter (ASAP7 version)
** Device sizing notes:
**  - w must be a multiple of the SKY130_PDK abstraction fin pitch (210e-9)
**  - nf must be even; relative drive strengths follow the original nfin*nf ratios
**  - cap values scaled 4x from the ASAP7 original (30f/60f -> 120f/240f),
**    matching the ~4x per-finger transistor width scaling (270n -> 1.05u)

.subckt telescopic_ota d1 vdd vinn vinp vss vbiasn vbiasp1 vbiasp2 voutn voutp
m9 voutn vbiasn net8 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=6
m8 voutp vbiasn net014 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=6
m5 d1 d1 vss vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=4
m4 net10 d1 vss vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=6
m3 net014 vinn net10 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=12
m0 net8 vinp net10 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=12
m7 voutp vbiasp2 net012 net012 sky130_fd_pr__pfet_01v8 w=10.5e-7 l=150e-9 nf=4
m6 voutn vbiasp2 net06 net06 sky130_fd_pr__pfet_01v8 w=10.5e-7 l=150e-9 nf=4
m2 net012 vbiasp1 vdd vdd sky130_fd_pr__pfet_01v8 w=10.5e-7 l=150e-9 nf=2
m1 net06 vbiasp1 vdd vdd sky130_fd_pr__pfet_01v8 w=10.5e-7 l=150e-9 nf=2
.ends telescopic_ota
** End of subcircuit definition.

.subckt switched_capacitor_filter voutn voutp vinp vinn id agnd vss vdd
m0 voutn phi1 net67 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
m7 net66 phi1 net63 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
m6 net72 phi1 vinn vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
m3 agnd phi2 net67 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
m5 agnd phi2 net63 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
m4 net72 phi2 agnd vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
m8 net60 phi2 agnd vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
m11 agnd phi2 net68 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
m9 agnd phi2 net62 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
m10 net64 phi1 net62 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
m12 net60 phi1 vinp vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
m14 voutp phi1 net68 vss sky130_fd_pr__nfet_01v8 w=10.5e-7 l=150e-9 nf=2
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
