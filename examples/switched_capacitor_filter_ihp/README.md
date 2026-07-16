# Switched-capacitor filter (IHP SG13G2)

IHP SG13G2 adaptation of `examples/switched_capacitor_filter`, targeting the
`pdks/ihpsg13g2` ALIGN abstraction (see that directory's README for the
PDK details).

## Netlist conversion

- Devices are `sg13_lv_nmos` / `sg13_lv_pmos` (1.5V LV CMOS), `l=150e-9`.
- The abstraction quantizes gate width in 260nm units: all devices use
  `w=1.04e-6` (4 units); relative drive strengths follow the original
  ASAP7 `nfin*nf` products (input pair 72 -> nf=12, cascodes 36 -> nf=6,
  PMOS loads 12 -> nf=2). `nf` must be even.
- Capacitors map to MIM caps (`cap_cmim`, ~1.5 fF/um^2) built between
  Metal5 and TopMetal1. Values are scaled 4x from the ASAP7 original
  (30fF/60fF -> 120fF/240fF), matching the ~4x per-finger transistor width
  scaling; the 1:2 cap ratios are preserved.

## Run

```sh
schematic2layout.py examples/switched_capacitor_filter_ihp -p pdks/ihpsg13g2 -w <workdir>
```

Expected result: layout completes with 0 shorts / 0 opens / 0 DRC errors
(two informational "DIFFERENT WIDTH" notes are emitted because cap plates
share an M5 centerline with regular wires elsewhere in the die — a scanline
checker artifact, not an electrical issue).

## Known limitations

- `GroupCaps` (common-centroid cap arrays) are not supported: the PnR-side
  cap array router produces plate shorts, on this PDK and on SKY130 alike.
  The caps here are therefore placed as individual primitives.
