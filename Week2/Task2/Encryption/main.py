import encryptor, key_creator, asset_converter

def main():
    print("Welcome to encryption program")
    input_str = input("To generate new keys press 1, to encrypt press 2, to decrypt press 3, to create asset press 4, to make file from asset press 5, to quit insert \'quit\': ")
    if input_str == "1":
        key_creator.generate_keys()
    elif input_str == "2":
        message = input("Insert adresses in next format:\n\"0x0000000000000000000000000000000000000001\", \"0x0000000000000000000000000000000000000002\", \"0x0000000000000000000000000000000000000003\"\n")
        encrypted = encryptor.encrypt(message)
    elif input_str == "3":
        message = input("Insert your encrypted message:")
        decrypted = encryptor.decrypt(message)
    elif input_str == "4":
        asset_converter.create_asset_from_file(input("Insert the path to the file:"))
    elif input_str == "5":
        asset_converter.create_file_from_asset()
    elif input_str == "quit":
        print("Bye!")
    else:
        print("Wrong input")
        main()

main()