function routes(app, accounts, recievePaymentContract, OWNER_ADDRESS) {
    app.get('/payments', async (req, res) => {
        const payment = await recievePaymentContract.methods.getPayment(req.query.payer).call();
        res.json(payment);
    })
}

module.exports = routes