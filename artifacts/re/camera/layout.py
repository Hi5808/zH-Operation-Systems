import re,sys
h=open(sys.argv[1]).read(); name=sys.argv[2]
a=h.index('struct %s {'%name); b=h.index('};',a)
sz={'MUINT8':1,'MINT8':1,'MUINT16':2,'MINT16':2,'MUINT32':4,'MINT32':4,'kal_uint8':1,'kal_uint16':2,'kal_uint32':4,'MUINT64':8}
off=0;out={}
body=re.sub(r'/\*.*?\*/','',h[a:b],flags=re.S)
for line in body.splitlines()[1:]:
    line=re.sub(r'//.*','',line).strip()
    m=re.match(r'(enum \w+|\w+)\s+(\w+)\s*(\[(\w+)\])?\s*;',line)
    if not m: continue
    t,n,_,arr=m.groups(); s=4 if t.startswith('enum') else sz.get(t,4)
    cnt=int(arr) if arr and arr.isdigit() else 1
    off=(off+s-1)//s*s; out[n]=off; off+=s*cnt
out['__size']=off
for k in sys.argv[3:]: print(k,hex(out.get(k,-1)))
