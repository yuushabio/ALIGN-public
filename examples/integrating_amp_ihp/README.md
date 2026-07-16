# Integrating amplifier (IHP SG13G2)

Flattened integrating amplifier (from IADC `grp03_bio_adc_integ_3`) sized for
the `pdks/ihpsg13g2` ALIGN abstraction: diff pair + PMOS loads, common-mode
feedback, diode-connected bias mirror, 5.5k input resistors and 756 fF MIM
integration caps.

## ALIGN sizing conventions used here

- `w` is the **per-finger** width and must be a multiple of the abstraction's
  260nm W-quantization (2 to 12 units per finger); `nf` must be even.
  All devices use a uniform `w=2.6e-6` finger, so `nf` carries the original
  20/30/40/60 um total-width ratios exactly (total = w*nf, ~4% above the
  original absolute sizes).
- Capacitors must be given as **values** (`c0 a b 756f`, max 1000 fF); ALIGN
  derives the MIM plate size from the ~1.5 fF/um^2 `cap_cmim` density
  (756 fF -> ~22.45um square), replacing the original `w=l=22.455e-6` form,
  which ALIGN's CAP generator cannot parse.
- Resistors use the `resistor` model with `r=<ohms>`.

## Run

```sh
schematic2layout.py examples/integrating_amp_ihp -p pdks/ihpsg13g2 -w <workdir>
```

Expected: 0 shorts / 0 opens / 0 DRC errors (a few informational
"DIFFERENT WIDTH" notes from cap plates sharing a centerline with routing
wires are harmless).
