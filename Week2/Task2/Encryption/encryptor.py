from datetime import datetime, tzinfo
from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_OAEP
from base64 import b64decode, b64encode
import binascii


def encrypt(message: str) -> bytes:
    public_key_raw_str = input("Insert your public key:")
    decoded_pub_key = b64decode(public_key_raw_str)
    public_key = RSA.import_key(decoded_pub_key)

    #msg = b64decode(message)

    encryptor = PKCS1_OAEP.new(public_key)
    encrypted = encryptor.encrypt(message.encode())
    # with open("encrypted_.txt", "wb") as f:
    #     f.write(encrypted)
    print(binascii.hexlify(encrypted))
    return encrypted


def decrypt(message) -> bytes:
    private_key_raw_str = input("Insert your private key:")
    decoded_priv_key = b64decode(private_key_raw_str)
    private_key = RSA.import_key(decoded_priv_key)
    text = binascii.a2b_hex(message)

    decryptor = PKCS1_OAEP.new(private_key)
    decrypted = decryptor.decrypt(text)
    print('Decrypted:', decrypted)
    return decrypted
