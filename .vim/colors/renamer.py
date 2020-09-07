import os
rep = input("replace: ")
wth = input("with: ")
[os.rename(f, f.replace(rep, wth)) for f in os.listdir('.') if not f.startswith('.')]