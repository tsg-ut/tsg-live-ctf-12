#!/usr/bin/env sage
from random import SystemRandom
from Crypto.Util.number import getPrime
from flag import flag
randgen = SystemRandom()
class EC:
    O = (0,1,0)
    def __init__(self,k,a):
        a4,a6 = map(k,a)
        self.f = lambda x,y: y**2-x**3-a4*x-a6
        self.dfdx = lambda x,y: 3*x**2 - a4
        self.dfdy = lambda x,y: 2*y
        self.a4 = a4
        self.a6 = a6
        self.k = k
    def iszeropoint(self,p):
        if p==EC.O:
            return True
        x,y=p
        assert not (self.dfdx(x,y)==0 and self.dfdy(x,y)==0)
        return self.f(x,y)==self.k(0)
    def minus(self,p):
        if p==EC.O:
            return EC.O

        x,y=p
        return (x,-y)
    def add(self,p1,p2):
        #assert(self.iszeropoint(p1) and self.iszeropoint(p2))
        if p1==EC.O:
            return p2
        if p2==EC.O:
            return p1
        if self.minus(p1)==p2:
            return EC.O
        if p1 == p2:
            x,y = p1
            x1,x2,y1,y2 = (x,x,y,y)
            l = (3*x**2+self.a4)/(2*y)
            n = (-3*x**3-self.a4*x+2*y**2)/(2*y)
        else:
            x1,y1=p1
            x2,y2=p2
            l = (y2-y1)/(x2-x1)
            n = (y1*x2-y2*x1)/(x2-x1)
        x3 = l**2-x1-x2
        y3 = -(l)*x3-n
        #assert( self.iszeropoint((x3,y3)))
        return (x3,y3)
    def scalar(self,a,p):
        ret = EC.O
        i = 1
        tmp = p
        while i<= a:
            if (i&a)!=0:
                ret = self.add(ret,tmp)
            tmp = self.add(tmp,tmp)
            i <<= 1
        return ret
def problem():
    p = getPrime(1024)
    k = GF(p)
    def delta(a,c):
        return -16*(-4*a**3+27*c**2)
    a,c = 0,k.random_element()
    while delta(a,c) == 0:
        c = k.random_element()
    ec = EC(k,[a,c])
    print(p,c)
    secret = randgen.randint(0,p-1)
    P = list(map(int,input("Send a point: ").split()[:2]))
    Q=ec.scalar(secret,P)
    print(Q[0],Q[1])
    ans = int(input("Send a number: "))
    if ans == secret:
        print(flag)
        return True
    else:
        return False
while not problem():
    pass
