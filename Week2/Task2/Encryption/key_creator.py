from Crypto.PublicKey import RSA

def generate_keys():
    keyPair = RSA.generate(3072)

    pubKey = keyPair.publickey()
    # print(f"Public key:  (n={hex(pubKey.n)}, e={hex(pubKey.e)})")
    pubKeyPEM = pubKey.exportKey()
    print("Save keys in safe place. NOTE: Please, remove new lines, your key should be one line string.\nPUBLIC_KEY:")
    print(pubKeyPEM.decode('ascii'))

    # print(f"Private key: (n={hex(pubKey.n)}, d={hex(keyPair.d)})")
    privKeyPEM = keyPair.exportKey()
    print("PRIVATE_KEY:")
    print(privKeyPEM.decode('ascii'))
