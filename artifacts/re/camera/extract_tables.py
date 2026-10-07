import re,struct,sys
d=open('vmlinux.elf','rb').read()
e_phoff,=struct.unpack_from('<Q',d,0x20); ph_es,ph_n=struct.unpack_from('<HH',d,0x36)
segs=[]
for i in range(ph_n):
    t,f,off,va,pa,fs,ms,al=struct.unpack_from('<IIQQQQQQ',d,e_phoff+i*ph_es)
    if t==1: segs.append((off,va,fs))
def v2o(v):
    for off,va,fs in segs:
        if va<=v<va+fs: return off+v-va
ins=[]
for l in open(sys.argv[1]):
    m=re.match(r'\s*([0-9a-f]+):\s+(\S+)\s*(.*)',l)
    if m: ins.append((int(m.group(1),16),m.group(2),m.group(3)))
regs={}; out=[]
for i,(pc,op,args) in enumerate(ins):
    a=[x.strip() for x in args.split(',')]
    if op=='adrp':
        regs[a[0]]=(pc&~0xfff)+int(a[1].lstrip('#'))
    elif op=='add' and len(a)==3 and a[0]==a[1] and a[0] in regs and a[2].startswith('#'):
        base=regs[a[0]]+int(a[2].lstrip('#'))
        # look ahead for the loop bound on x9 within 40 insns
        for pc2,op2,args2 in ins[i+1:i+45]:
            m=re.match(r'x9, #(\d+)',args2)
            if op2=='cmp' and m:
                n=int(m.group(1))+2
                out.append((pc,base,n)); break
        del regs[a[0]]
seen=set()
for pc,base,n in out:
    if (base,n) in seen: continue
    seen.add((base,n))
    vals=struct.unpack_from('<%dH'%n,d,v2o(base))
    pairs=list(zip(vals[0::2],vals[1::2]))
    print('# table @%x (from pc %x): %d pairs'%(base,pc,len(pairs)))
    print(' '.join('%04X=%02X'%p for p in pairs[:6]),'...')
