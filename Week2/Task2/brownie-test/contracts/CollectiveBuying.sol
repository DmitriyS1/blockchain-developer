// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.6.12;
contract CollectiveBuying {
    address private owner;
    string ciphered_buyers_adresses;
    string public_key;
    bytes[] asset;

    address[] buyers_addresses;
    uint256 buyers_count;
    
    mapping(uint256 => bool) private usedNonces;

    constructor() public {
        owner = msg.sender;
        public_key = "";
    }


    function getPublicKey() public view returns (string memory) {
        // require(keccak256(abi.encodePacked(public_key)) != keccak256(abi.encodePacked("")));
        return public_key;
    }

    function initPublicKey(string memory pub_key) public {
        require(msg.sender == owner);
        public_key = pub_key;
    }

    function initOrder(string memory _order_adresses) public payable {
        if (msg.value == 2000000000000000) {
            ciphered_buyers_adresses = _order_adresses;
        }
    }

    function getOrderAddresses() public view returns (string memory) {
        require(msg.sender == owner);
        return ciphered_buyers_adresses;
    }

    function transferAssetToAddresses(address[] memory addresses) public {
        require(msg.sender == owner);
        for (uint i = 0; i < addresses.length; i++) {
            buyers_addresses.push(addresses[i]);
        }
    }

    function getBuyerAddresses() public view returns (address[] memory) {
        require(msg.sender == owner);
        return buyers_addresses;
    }

    // function order(uint256 amount, uint256 nonce, bytes memory signature) external {
    //     require(!usedNonces[nonce]);
    //     usedNonces[nonce] = true;

    //     // this recreates the message that was signed on the client
    //     bytes32 message = prefixed(keccak256(abi.encodePacked(msg.sender, amount, nonce, this)));

    //     require(recoverSigner(message, signature) == owner);

    //     payable(msg.sender).transfer(amount);
    // }

    /// destroy the contract and reclaim the leftover funds.
    // function shutdown() external {
    //     require(msg.sender == owner);
    //     selfdestruct(payable(msg.sender));
    // }

    /// signature methods.
    function splitSignature(bytes memory sig)
        internal
        pure
        returns (uint8 v, bytes32 r, bytes32 s)
    {
        require(sig.length == 65);

        assembly {
            // first 32 bytes, after the length prefix.
            r := mload(add(sig, 32))
            // second 32 bytes.
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes).
            v := byte(0, mload(add(sig, 96)))
        }

        return (v, r, s);
    }

    function recoverSigner(bytes32 message, bytes memory sig)
        internal
        pure
        returns (address)
    {
        (uint8 v, bytes32 r, bytes32 s) = splitSignature(sig);

        return ecrecover(message, v, r, s);
    }

    /// builds a prefixed hash to mimic the behavior of eth_sign.
    function prefixed(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
}