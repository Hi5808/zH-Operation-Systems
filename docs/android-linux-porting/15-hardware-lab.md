# 15. Hardware Lab: Serial Consoles and Probing

Firmware dumps and Ghidra get you most of the way. When a kernel boots
to a black screen, or a peripheral has no driver source, the physical
board is the next source of truth. This chapter covers the minimum
practical bench setup. Everything here involves opening the device;
only do it on hardware you're prepared to damage.

## 15.1 Minimum kit

| Item | Why |
|---|---|
| USB-UART adapter **with selectable logic level (1.8V / 3.3V)** | Serial console. Many phone SoCs use 1.8V UART. A 3.3V-only adapter can damage a 1.8V pin, so check before you connect. |
| Multimeter | Identify ground, measure the idle voltage of a suspected TX pin (it idles high, at the logic level). |
| Fine-tip soldering iron, thin wire, Kapton tape | Test points on phone boards are tiny; secure wires so they don't rip pads. |
| Logic analyser (cheap 8-channel units work with sigrok/PulseView) | Decode I2C/SPI/UART traffic you can't see in software. |
| Plastic pry tools, heat source for adhesive | Opening glued phones without cracking panels. |

## 15.2 Finding and using the UART

1. **Locate candidates:** look for unpopulated test pads near the SoC or
   labelled `TX`/`RX`/`GND`. Community teardowns or board photos for the
   same device often already mark them. Some devices route debug UART
   through the USB-C port or headphone jack in a special mode, so check
   the device's community docs before soldering.
2. **Identify ground** with continuity to a shield can or USB shield.
3. **Find TX:** power on and measure. The SoC's TX idles at the logic
   level (≈1.8V or ≈3.3V) and flickers during boot. Set your adapter to
   that level.
4. **Wire it:** device TX → adapter RX, device GND → adapter GND. You
   need device RX only if you want to type into the console. Never
   connect the adapter's VCC.
5. **Connect:** usually `115200 8N1`, e.g. `picocom -b 115200 /dev/ttyUSB0`.
   You should see bootloader output before Linux starts.

To get kernel output, add `earlycon` (with the right driver/address for
your SoC's UART, taken from the vendor `.dts`) and a matching `console=`
to the kernel command line (§4.3, §5.4). Bootloader output appearing
but no kernel output usually means the `earlycon`/`console` arguments
are wrong, not that the kernel is dead.

## 15.3 Logic analyser for undocumented peripherals

When §2's Ghidra work on a driver is inconclusive, capture what stock
Android actually sends on the bus:

- Clip onto the peripheral's I2C (SDA/SCL) or SPI lines (test pads or
  component pins), plus ground.
- Boot stock Android and trigger the peripheral (wake the screen, touch
  it, etc.).
- Decode in PulseView. The captured register writes and their order
  should match the init sequence you recovered in §2.3. When they don't,
  the capture wins.

This is the hardware cross-check for every "recovered init sequence"
table in `re-notes.md`.

## 15.4 Safety and risk

- Disconnect the battery before soldering where the design allows it.
- Swollen or punctured lithium batteries are a fire risk. Don't pry near
  the battery with metal tools, and dispose of damaged cells properly.
- Test-point soldering can lift pads permanently. Treat the first board
  you open as expendable if you can.
- A tripped tamper/warranty indicator (e.g. moisture stickers, Samsung
  KNOX in software) is not reversible.
