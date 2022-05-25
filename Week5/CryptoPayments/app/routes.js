const v4guid = require('uuid');
const DB_NAME = "crypto";

function routes(app, accounts, mongodb, recievePaymentContract, OWNER_ADDRESS) {
    // get payment info from smart contract with query parameter 'payer'
    app.get('/crypto/payments', async (req, res) => {
        const payment = await recievePaymentContract.methods.getPayment(req.query.payer).call();
        res.json(payment);
    });

    // add new shop to integrations
    app.post('/shops', async (req, res) => {
        var dbo = mongodb.db(DB_NAME);
        var newShop = { id: v4guid.v4(), shopHash: req.body.shopHash, created: Date.now(), bankAccount: req.body.bankAccount };
        await dbo.collection("shop").insertOne(newShop, function(err, res) {
            if (err) throw err;
            console.log("Document inserted");
        });
        res.json(newShop);
    });

    // add new payment that should be payed in rub
    app.post('/payments', async (req, res) => {
        var dbo = mongodb.db(DB_NAME);
        var newPayment = { shopHash: req.body.shopHash, created: Date.now(), rubAmount: req.body.shopAmount, etherAmount: req.body.etherAmount, payerAddress: req.body.payerAddress, isPayedToShop: false };
        await dbo.collection("payment").insertOne(newPayment, function(err, res) {
            if (err) throw err;
            console.log("Document inserted");
        })
        res.json(newPayment);
    });

    // get payments between from and to dates
    app.get('/payments', async (req, res) => {
        var dbo = mongodb.db(DB_NAME);
        var to;
        if (req.query.to){
            to = req.query.to;
        }
        else{
            to = Date.now();
        }

        var response = [];

        const cursor = dbo.collection("payment").find({ created: {$gte: req.query.from, $lte: to} });
        console.log(await cursor);
        await cursor.forEach(response.push)
        res.json(response);
    })

    // mark payment as payed in system
    app.patch('/payments', async (req, res) => {
        var dbo = mongodb.db(DB_NAME);
        const filter = {shopHash: req.body.shopHash, payerAddress: req.body.payerAddress };
        const opts = { upsert: false };
        const updateDoc = {
            $set: {
                isPayedToShop: true
            },
        };

        await dbo.collection("payment").updateOne(filter, updateDoc, opts);
        res.sendStatus(204);
    });
}


module.exports = routes