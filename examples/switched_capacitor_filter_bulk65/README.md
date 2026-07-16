# Switched-capacitor filter (Bulk65nm mock PDK)

Bulk 65nm adaptation of `examples/switched_capacitor_filter`, targeting
`pdks/Bulk65nm_Mock_PDK`.

## Netlist conversion

- Devices are `nmos_rvt` / `pmos_rvt` with `l=60e-9`; `w` is the per-finger
  width and must be a multiple of the abstraction's 100nm W-quantization.
  All devices use a uniform `w=1.0e-6` finger (10 units); `nf` carries the
  original ASAP7 `nfin*nf` drive ratios (input pair 72 -> nf=12, cascodes
  36 -> nf=6, PMOS loads 12 -> nf=2).
- Cap values scaled 4x from the ASAP7 original (30fF/60fF -> 120fF/240fF),
  matching the sky130/ihpsg13g2 adaptations.
- The PMOS cascode bulks (m6/m7) are tied to `vdd` instead of the original
  source-tied bodies: the mock PDK's body-contact scheme cannot route an
  isolated source-tied nwell, which left those nets OPEN in LVS.

## Run

This PDK needs non-default placer flags — the default aspect-ratio ILP
placer cannot place the power-grid sub-block (`TELESCOPIC_OTA_PG0`) on this
PDK, and `--use_analytical_placer` segfaults:

```sh
schematic2layout.py examples/switched_capacitor_filter_bulk65 \
    -p pdks/Bulk65nm_Mock_PDK -w <workdir> --place_using_ILP -n 1
```

`--place_using_ILP` falls back to an SA placer that finds feasible
sub-block placements; `-n 1` (single placement variant per block) keeps the
top-level ILP model small — without it the top-level placement stalls for
hours at ~9GB RSS.

Expected result: 0 shorts / 0 opens / 0 DRC errors (a few informational
"DIFFERENT WIDTH" notes appear because routed M1 wires are 100nm while the
mock primitives use 90nm rails on the same tracks — cosmetic).

## Known limitations

- `Bulk65nm_Mock_PDK` is excluded from ALIGN's own integration and
  regression CI (`skip_pdks` in `tests/integration/test_integration.py` and
  `tests/regression/test_regression.py`); only primitive-level generation
  is routinely tested, so full-flow placer quirks like the above are
  expected.
- `GroupCaps` (common-centroid cap arrays) were not enabled; the caps are
  placed as individual primitives, consistent with the sky130/ihpsg13g2
  adaptations.
