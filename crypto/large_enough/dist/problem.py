from Crypto.Util.number import getStrongPrime

p = getStrongPrime(1024)
q = getStrongPrime(1024)
N = p * q

phi = (p - 1) * (q - 1)
e = phi - 3
d = pow(e, -1, phi)

with open('flag.txt', 'rb') as flag:
    m = int.from_bytes(flag.read(), 'big')

assert(m.bit_length() < 1000)

c = pow(m, e, N)

print(f'N = {N}')
print(f'c = {c}')