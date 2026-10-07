import re,sys
regs={};st={}
for l in open(sys.argv[1]):
    m=re.match(r'\s*[0-9a-f]+:\s+(\S+)\s*(.*)',l)
    if not m: continue
    op,args=m.groups(); p=[x.strip() for x in args.split(',')]
    if op=='mov' and len(p)==2 and p[1].startswith('#'): regs[p[0][1:]]=int(p[1][1:])
    elif op=='mov' and len(p)==2 and p[1] in('wzr','xzr'): regs[p[0][1:]]=0
    elif op=='movk' and p[0][1:] in regs: regs[p[0][1:]]|=int(p[1][1:])<<int(p[2].split('#')[-1])
    elif op in('str','strb','strh') and '[x19' in args:
        r=p[0][1:]; off=int(re.search(r'#(\d+)',args).group(1)) if '#' in args else 0
        v=0 if p[0] in('wzr','xzr') else regs.get(r)
        st[(off,op)]=v
for k in sorted(st): print(k[0],k[1],st[k])
