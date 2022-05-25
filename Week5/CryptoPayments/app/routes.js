const v4guid = require('uuid');

function routes(app, accounts, mongodb, recievePaymentContract, OWNER_ADDRESS) {
    app.get('/payments', async (req, res) => {
        const payment = await recievePaymentContract.methods.getPayment(req.query.payer).call();
        var dbo = mongodb.db("crypto");
        dbo.collection("")
        res.json(payment);
    });

    app.post('/shops', async (req, res) => {
        var dbo = mongodb.db("crypto");
        var newShop = { id: v4guid.v4(), shopHash: req.body.shopHash, created: Date.now(), bankAccount: req.body.bankAccount };
        dbo.collection("shop").insertOne(newShop, function(err, res) {
            if (err) throw err;
            console.log("Document inserted");
            mongodb.close();
        });
        res.json(newShop);
    })
}


module.exports = routes