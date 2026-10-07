#!/usr/bin/env python3
"""Extract the MIPI-DSI init sequence from a disassembled stock MTK panel
lcm_prepare (llvm-objdump --no-show-raw-insn output) + the decompressed Image.
Tracks x1 (adrp/add data ptr), w2/x2 (length) and w0 (msleep/gpio arg)."""
import re, sys
asm, image = sys.argv[1], sys.argv[2]
BASE = 0xffffff8008080000
img = open(image, 'rb').read()
rd = lambda va, n: img[va - BASE: va - BASE + n]
reg, out = {}, []
for line in open(asm):
    m = re.match(r'\s*([0-9a-f]+):\s+(\w+)\s+(.*)', line)
    if not m: continue
    op, args = m.group(2), m.group(3)
    a = [x.strip() for x in re.sub(r'//.*', '', args).split(',')]
    def imm(s):
        s = s.strip('#[]! ');  return int(s, 0)
    try:
        if op == 'adrp': reg[a[0]] = int(a[1].split()[0], 16)
        elif op == 'add' and len(a) == 3 and a[2].startswith('#') and a[1] in reg:
            reg[a[0]] = reg[a[1]] + imm(a[2])
        elif op == 'mov' and a[1].startswith('#'): reg[a[0].replace('w', 'x')] = imm(a[1])
        elif op == 'mov' and a[1] in ('wzr', 'xzr'): reg[a[0].replace('w', 'x')] = 0
        elif op == 'mov' and a[1].replace('w', 'x') in reg: reg[a[0].replace('w','x')] = reg[a[1].replace('w','x')]
        elif op == 'bl':
            fn = re.search(r'<([^>$+]+)', args).group(1)
            if fn in ('mipi_dsi_dcs_write_buffer', 'mipi_dsi_generic_write'):
                n = reg.get('x2'); p = reg.get('x1')
                if p is not None and n:
                    out.append('W ' + ' '.join('%02X' % b for b in rd(p, n)))
                else: out.append('W ? (unresolved)')
            elif fn == 'msleep': out.append('SLEEP %d' % reg.get('x0', -1))
            elif fn in ('usleep_range', 'udelay'): out.append('USLEEP %s' % reg.get('x0'))
            elif fn == 'gpiod_set_value': out.append('GPIO set %s' % reg.get('x1'))
            elif fn == 'lcm_i2c_set_data': out.append('BIAS_I2C reg=%s val=%s' % (reg.get('x0'), reg.get('x1')))
            for r in ('x0','x1','x2','x3'): reg.pop(r, None)
    except (ValueError, IndexError): pass
print('\n'.join(out))
