#!/usr/bin/env sage
from flag import flag
from random import SystemRandom
randgen = SystemRandom()
class EC:
    O = (0,1,0)
    def __init__(self,k,a):
        a1,a2,a3,a4,a6 = map(k,a)
        self.f = lambda x,y: y**2+a1*x*y+a3*y-x**3-a2*x**2-a4*x-a6
        self.dfdx = lambda x,y: a1*y-3*x**2 - 2*a2*x - a4
        self.dfdy = lambda x,y: 2*y+a1*x + a3
        self.a1 = a1
        self.a2 = a2
        self.a3 = a3
        self.a4 = a4
        self.a6 = a6
        self.delta = -k(a1^6*a6 - a1^5*a3*a4 + a1^4*a2*a3^2 + 12*a1^4*a2*a6 - a1^4*a4^2 - 8*a1^3*a2*a3*a4 - a1^3*a3^3 + 8*a1^2*a2^2*a3^2 - 36*a1^3*a3*a6 + 48*a1^2*a2^2*a6 - 8*a1^2*a2*a4^2 + 30*a1^2*a3^2*a4 - 16*a1*a2^2*a3*a4 - 36*a1*a2*a3^3 + 16*a2^3*a3^2 - 72*a1^2*a4*a6 - 144*a1*a2*a3*a6 + 96*a1*a3*a4^2 + 64*a2^3*a6 - 16*a2^2*a4^2 - 72*a2*a3^2*a4 + 27*a3^4 - 288*a2*a4*a6 + 216*a3^2*a6 + 64*a4^3 + 432*a6^2)
        assert(self.delta != 0)
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
        return (x,-y-self.a1*x-self.a3)
    def add(self,p1,p2):
        assert(self.iszeropoint(p1) and self.iszeropoint(p2))
        if p1==EC.O:
            return p2
        if p2==EC.O:
            return p1
        if self.minus(p1)==p2:
            return EC.O
        if p1 == p2:
            x,y = p1
            x1,x2,y1,y2 = (x,x,y,y)
            l = (3*x**2+2*self.a2*x+self.a4-self.a1*y)/(2*y+self.a1*x+self.a3)
            n = (-x**3+self.a4*x+2*self.a6-self.a3*y)/(2*y+self.a1*x+self.a3)
        else:
            x1,y1=p1
            x2,y2=p2
            l = (y2-y1)/(x2-x1)
            n = (y1*x2-y2*x1)/(x2-x1)
        x3 = l**2+self.a1*l-self.a2-x1-x2
        y3 = -(l+self.a1)*x3-n-self.a3
        assert( self.iszeropoint((x3,y3)))
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
    p = 24565620203575534379878557094745997191092532968959998796957882824645147003970279263260678631256872687462209250393543
    k = GF(p)
    a2,a4,a6 = [0, 13678004042548466336084106411178795177819893811238301010652397713799276134892009191954457751462722237873748076136481, 3873878083421951975791095032760967751001940752765621296732985685694169629554942446981909211251265535782672317925689]
    ec = EC(k,[0,a2,0,a4,a6])
    secret = randgen.randint((p-1)/2,p-1)
    P = list(map(int,input("Send a point: ").split()[:2]))
    Q=ec.scalar(secret,P)
    print(Q[0],Q[1])
    ans = int(input("Send a number: "))
    if ec.scalar(ans,P) == Q:
        print(flag)
        return True
    else:
        return False
while not problem():
    pass
