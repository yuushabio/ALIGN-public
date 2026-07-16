# Switched-capacitor filter (SKY130)

SKY130 adaptation of `examples/switched_capacitor_filter` (originally sized for the
ASAP7-style FinFET mock PDK).

## Netlist conversion

- Devices renamed to `sky130_fd_pr__nfet_01v8` / `sky130_fd_pr__pfet_01v8` with
  `l=150e-9`, matching the other `*_sky` examples.
- The SKY130 abstraction in `pdks/SKY130_PDK` requires `w` to be a multiple of the
  abstraction fin pitch (210e-9) and `nf` to be even. All devices use
  `w=10.5e-7` (5 "fins"); relative drive strengths follow the original `nfin*nf`
  products (e.g. input pair 72 -> nf=12, cascodes 36 -> nf=6, PMOS loads 12 -> nf=2).
- Capacitor values are scaled 4x from the ASAP7 original (30fF/60fF ->
  120fF/240fF), matching the ~4x per-finger transistor width scaling; the
  1:2 cap ratios are preserved.

## Run

```sh
schematic2layout.py examples/switched_capacitor_filter_sky -p pdks/SKY130_PDK -w <workdir>
```

## Known limitations

- The original example's `GroupCaps` (common-centroid array of `c1/c3` and `c6/c7`
  with `Cap_12f` units) is intentionally omitted here: the PnR-side cap array
  router generates overlapping plates that are flagged as LVS shorts between
  the two cap nets (same limitation as on the ihpsg13g2 PDK).
- The `pdks/SKY130_PDK` cap generator was rewritten (backported from
  `pdks/ihpsg13g2`) to fix the OPENs and off-grid M4 pin errors of the old
  generator: the plate is centered on an M4 routing track, the MIM contact is
  an extraction-invisible via3 patch with a real V4 to an on-grid rail, and
  both terminals are exposed as M3 pins (M3 shares the M1 pitch, so pins stay
  on-grid for any placement). The rewrite passes standalone generation for
  the cap sizes used here but has not yet been re-validated through the full
  schematic2layout flow.
