from Enc_Dec import encrypt, decrypt

text = input("Enter the text you want to encrypt: ")
key = input("Enter your Password: ")

encrypted, vernam = encrypt(text, key)

print("\n")
print("Vernam = ",vernam)
print("Final Encryption = ",encrypted)

decrypted, vernam = decrypt(encrypted, key)

print("\n")
print("Vernam = ",vernam)
print("Final Decryption = ",decrypted)

