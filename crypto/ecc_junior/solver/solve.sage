#!/usr/bin/env sage
# coding: utf-8
p=24565620203575534379878557094745997191092532968959998796957882824645147003970279263260678631256872687462209250393543
a1,a3=[0,0]
k = GF(p)
a2,a4,a6 = [0, 13678004042548466336084106411178795177819893811238301010652397713799276134892009191954457751462722237873748076136481, 3873878083421951975791095032760967751001940752765621296732985685694169629554942446981909211251265535782672317925689]
ec = EllipticCurve(k,[a1,a2,a3,a4,a6])
card = factor(ec.cardinality())
# minimum prime factor is 7
O=ec(0,1,0)
O.division_points(7)
x,y=O.division_points(7)[1][:2]
from pwn import *
context.log_level = 'debug' # output verbose log
if len(sys.argv) > 1 and sys.argv[1] == 'r':
    conn = remote("localhost", 27182)
else:
    conn = process('../src/problem.sage')

conn.recv()
while True:
    conn.send(str(x)+" "+str(y)+"\n"+"7"+"\n")
    dump=conn.recv()
    if b"TSGLIVE{" in dump:
        print(dump)
        break
