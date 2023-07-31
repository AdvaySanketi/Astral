import random
import pyaes, pbkdf2, binascii, os, secrets

class Crypto:
    def __init__(self):
        self.vernam_key=[]
        self.characters={'a': 0, 'b': 1, 'c': 2, 'd': 3, 'e': 4, 'f': 5, 'g': 6, 'h': 7, 'i': 8, 'j': 9, 'k': 10, 'l': 11, 'm': 12, 'n': 13, 'o': 14, 'p': 15, 'q': 16, 'r': 17, 's': 18, 't': 19, 'u': 20, 'v': 21, 'w': 22, 'x': 23, 'y': 24, 'z': 25, '.': 26, ',': 27, '!': 28, '?': 29}
        self.inverse_character={0:'a',1:'b',2:'c',3:'d',4:'e',5:'f',6:'g',7:'h',8:'i',9:'j',10:'k',11:'l',12:'m',13:'n',14:'o',15:'p',16:'q',17:'r',18:'s',19:'t',20:'u',21:'v',22:'w',23:'x',24:'y',25:'z',26:'.',27:',',28:'!',29:'?'}

    def encrypt(self,data):
        ciphertext = ''
        data=data.lower()
        key = self.random_key(len(data))
        key_binary = self.word_to_decimal(key)
        data_binary = self.word_to_decimal(data)
        pos = []
        self.vernam_key.append(key)
        for i in range(len(data)):
            if data_binary[i] != ' ':
                xor_res = key_binary[i] ^ data_binary[i]
                if xor_res >= 26:
                    xor_res -= 26
                    pos.append(str(i))
                ciphertext += self.inverse_character[xor_res]
            else:
                xor_res = ' '
                ciphertext += '?'
        ciphertext += ''.join(pos) + str(len(data)) + str(len(str(len(data))))
        return ciphertext, key
    
    def decrypt(self,encrypted, key):
        length_data = int(encrypted[-1])
        length = int(encrypted[-length_data-1:-1])
        pos = list(map(int,[*encrypted[length:-length_data-1]]))
        data = encrypted[:length]
        key_binary = self.word_to_decimal(key)
        data_binary = self.decimal_to_word(data)
        data = ''
        for i in range(len(data_binary)):
            if data_binary[i] != ' ':
                if i in pos:
                    xor_res = (data_binary[i]+26) ^ key_binary[i]
                else:
                    xor_res = (data_binary[i]) ^ key_binary[i]
                data += self.inverse_character[xor_res]
            else:
                xor_res = ' '
                data += ' '
        return data

    def aes_encrypt(self, text, pwd):
        password = pwd
        passwordSalt = os.urandom(16)
        key = pbkdf2.PBKDF2(password, passwordSalt).read(32)
        iv = secrets.randbits(256)
        plaintext = text
        aes = pyaes.AESModeOfOperationCTR(key, pyaes.Counter(iv))
        ciphertext = aes.encrypt(plaintext)
        return [ciphertext, passwordSalt, iv]
    
    def aes_decrypt(self, encrypted, pwd):
        password_salt = encrypted[1]
        iv = encrypted[2]
        encrypted = encrypted[0]
        key = pbkdf2.PBKDF2(pwd, password_salt).read(32)
        aes = pyaes.AESModeOfOperationCTR(key, pyaes.Counter(int(iv)))
        decrypted = aes.decrypt(encrypted)
        return decrypted

    def random_key(self,n):
        data=""
        for i in range(n):
            a=random.randint(97,122)
            b=chr(a)
            data=data+b
        return data
    
    def word_to_decimal(self,text):
        binary_word_list=[]
        letters = [*text]
        for i in letters:
            if i != ' ':
                num=bin(self.characters[i])[2::]
                num=int(num,2)
            else:
                num = i
            binary_word_list.append(num)
        return binary_word_list

    def decimal_to_word(self,text):
        binary = []
        parts = [*text]
        for i in parts:
            if i != '?':
                binary.append(self.characters[i])
            else:
                binary.append(' ')
        return binary
