*******************************************************
* design_params.sp -- Global Circuit Parameters
*******************************************************

* --- Power Supplies ---
.param VDD = 1.0
.param VSS = 0.0

* --- Biasing ---
* This is your reference tail current. 
* Ensure this matches your dut.sp biasing requirements.
.param IBIAS = 5u
.param DUT_HAS_VB2 = 0 $ Change to 1 for LV Cas and Cascode (telescopic) OTAs
* --- Loading ---
* Standard load for area/speed trade-offs
.param CL = 500f
.param c0 = 0.5p
.param r0 = 2.5k
* --- Leakage/Safety ---
* High resistance to prevent floating nodes during DC convergence
.param RLEAK = 100Meg

* --- Timing Constants ---
* Default UGF used as a fallback if the AC sim hasn't run yet
.param UGF_DEFAULT = 50Meg

*******************************************************
* Optimization/Simulator Options
*******************************************************
.option post=2      $ Enables waveform viewing (RTA/Custom WaveView)
.option nomod       $ Clean up the .lis file by hiding model parameters
.option probe       $ Only save signals explicitly requested in .probe
.option runlvl=5

*******************************************************
* Device parameters (Update manually)
*******************************************************

.param m0_w=8e-06
.param m2_w=8e-06
.param m0_l=2.4e-07
.param m2_l=2.4e-07
.param m1_w=1.05e-05
.param m3_w=1.05e-05
.param m1_l=3e-07
.param m3_l=3e-07
.param m4_w=1.4e-05
.param m4_l=3.6e-07
.param m5_w=1.05e-05
.param m5_l=3.6e-07
.param m6_l=180n
.param m6_w=1u
.param m7_l=180n
.param m7_w=1u
.param m8_l=180n
.param m8_w=1u
.param m9_l=180n
.param m9_w=1u
.param m10_l=180n
.param m10_w=1u

