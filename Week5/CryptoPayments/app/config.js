const CONTRACT_ADDRESS = '0x1e94FbB8CC73cb9B1A1d46E2Bc5DF891E23F68b1';

const OWNER_ADDRESS = '0x4eC2C5082e48874f4FD7d391d097521557e06490';

const CONTRACT_ABI = [
    {
        "inputs": [],
        "name": "last_completed_migration",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "owner",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "shopHash",
                "type": "string"
            },
            {
                "internalType": "uint256",
                "name": "shopPrice",
                "type": "uint256"
            }
        ],
        "name": "pay",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "payer",
                "type": "address"
            }
        ],
        "name": "getPayment",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
            },
            {
                "internalType": "string",
                "name": "shopHash",
                "type": "string"
            },
            {
                "internalType": "uint256",
                "name": "price",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "amount",
                "type": "uint256"
            },
            {
                "internalType": "address payable",
                "name": "reciever",
                "type": "address"
            }
        ],
        "name": "withdraw",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "completed",
                "type": "uint256"
            }
        ],
        "name": "setCompleted",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "repairWithdraw",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    }
];

module.exports = {
    CONTRACT_ADDRESS,
    CONTRACT_ABI,
    OWNER_ADDRESS
};