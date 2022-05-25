const PaymentsReciever = artifacts.require("PaymentsReciever");

module.exports = function (deployer) {
    deployer.deploy(PaymentsReciever);
};