from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_OAEP
from base64 import b64decode
import binascii


def encrypt(message) -> bytes:
    public_key_raw_str = input("Insert your public key:")
    decoded_pub_key = b64decode(public_key_raw_str)
    public_key = RSA.import_key(decoded_pub_key)

    msg = message.encode("ascii")

    encryptor = PKCS1_OAEP.new(public_key)
    encrypted = encryptor.encrypt(msg)
    print("Encrypted:", binascii.hexlify(encrypted))
    return encrypted.decode("ascii")


def decrypt(message) -> bytes:
    private_key_raw_str = input("Insert your private key:")
    decoded_priv_key = b64decode(private_key_raw_str)
    private_key = RSA.import_key(decoded_priv_key)
    
    decryptor = PKCS1_OAEP.new(private_key)
    decrypted = decryptor.decrypt(message)
    print('Decrypted:', decrypted)
    return decrypted
