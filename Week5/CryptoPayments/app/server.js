const express = require('express');
const app = express(); 
const cors = require('cors');
const routes = require('./routes');
const Web3 = require('web3');
const mongodb = require('mongodb').MongoClient;
//const contract = require('@truffle/contract');
//const artifacts = require('./build/contracts/Contacts.json');
const CONTRACT_ABI = require('./config');
const CONTRACT_ADDRESS = require('./config');
const OWNER_ADDRESS = require('./config');

app.use(cors());
app.use(express.json());

if (typeof web3 !== 'undefined') {
    var web3 = new Web3(web3.currentProvider);
} else {
    var web3 = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));
}

mongodb.connect('mongodb://127.0.0.1:27017/blockchain-node-api',
    {
        useUnifiedTopology: true,
    }, async (err, client) => {
        const accounts = await web3.eth.getAccounts();
        const recievePaymentContract = new web3.eth.Contract(CONTRACT_ABI.CONTRACT_ABI, CONTRACT_ADDRESS.CONTRACT_ADDRESS);

        routes(app, accounts, recievePaymentContract, OWNER_ADDRESS);
        app.listen(process.env.PORT || 3001, () => {
            console.log('listening on port ' + (process.env.PORT || 3001));
        });
    });