sha = "2A:7E:20:AE:49:E0:53:E3:88:E3:5D:CD:C1:B2:5D:2A:FC:E6:A5:27:B0:89:0D:80:41:8F:78:F4:E2:50:B6:B6"
ook = sha.lower()
final = ""
for ch in ook:
    if(ch != ':'):
        final+=ch
    
print(final)