import re,sys
def decode(path,start=None,stop=None):
    ins=[]
    for l in open(path):
        m=re.match(r'\s*([0-9a-f]+):\s+(\S+)\s*(.*)',l)
        if m:
            pc=int(m.group(1),16)
            if (start is None or pc>=start) and (stop is None or pc<stop): ins.append((pc,m.group(2),m.group(3)))
    regs={}; buf=None; out=[]
    for pc,op,args in ins:
        p=[x.strip() for x in args.split(',')]
        if op=='mov' and len(p)==2 and p[1].startswith('#'): regs[p[0]]=int(p[1][1:])&0xffffffff
        elif op=='movk' and p[0] in regs: regs[p[0]]|=int(p[1][1:])<<int(p[2].split('#')[-1])
        elif op in('str','strh','strb') and ('[sp, #4]' in args or args.rstrip().endswith('[sp]')) and p[0] in regs: buf=(op,regs[p[0]])
        elif op=='mov' and p[0]=='w1' and p[1].startswith('#'): ln=int(p[1][1:])
        elif op=='bl' and 'iWriteRegI2C' in args and buf:
            ln=regs.get('w1',4); v=buf[1].to_bytes(4,'little')
            if ln==4: out.append(('w16',(v[0]<<8)|v[1],(v[2]<<8)|v[3]))
            elif ln==3: out.append(('w8',(v[0]<<8)|v[1],v[2]))
            else: out.append(('?',ln,buf[1]))
            buf=None
        elif op=='bl' and '__delay' in args: out.append(('delay',0,0))
        elif op=='bl' and 'preview_setting' in args: out.append(('call_preview_setting',0,0))
    return out
if __name__=='__main__':
    w=decode(sys.argv[1])
    print(len(w),'writes'); print(w[:8])
