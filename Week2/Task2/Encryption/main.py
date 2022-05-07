import encryptor, key_creator

def main():
    print("Welcome to encryption program")
    input_str = input("To generate new keys press 1, to encrypt press 2, to decrypt press 3, to quit insert \'quit\': ")
    if input_str == "1":
        key_creator.generate_keys()
    elif input_str == "2":
        message = input("Insert adresses in next format:\n\"0x0000000000000000000000000000000000000001\", \"0x0000000000000000000000000000000000000002\", \"0x0000000000000000000000000000000000000003\"\n")
        encrypted = encryptor.encrypt(message)
    elif input_str == "3":
        message = input("Insert your encrypted message:")
        decrypted = encryptor.decrypt(message)
    elif input_str == "quit":
        print("Bye!")
    else:
        print("Wrong input")
        main()

main()