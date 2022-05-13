from base64 import b64decode, b64encode
import os

def create_asset_from_file(file_path):
    """
    Create an asset from a file.
    :param file_path: The path to the file.
    """
    with open(file_path, 'rb') as f:
        _, file_extension = os.path.splitext(file_path)
        file = f.read()
        asset = b64encode(file)
        print("Copy this asset (inside the quotes) to the smart contract:")
        print(asset)
        print ("Copy file extension to to the smart contract:")
        print(file_extension)


def create_file_from_asset():
    """
    Create a file from an asset.
    """
    asset = input("Insert the asset:")
    asset_string = b64decode(asset)

    file_extension = input("Insert the file extension:")

    with open("asset"+file_extension, 'wb') as f:
        f.write(asset_string)

    print("Enjoy your asset!")
