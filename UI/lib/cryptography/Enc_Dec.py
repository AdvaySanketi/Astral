from Cryptography import Crypto

key = 0

def encrypt(text, pwd):
    global key
    c = Crypto()
    vernam, key = c.encrypt(text)
    final = c.aes_encrypt(vernam, pwd)
    return final, vernam

def decrypt(encrypted, pwd):
    global key
    c = Crypto()
    vernam = c.aes_decrypt(encrypted, pwd)
    final = c.decrypt(str(vernam)[2:-1], key)
    return final, vernam
