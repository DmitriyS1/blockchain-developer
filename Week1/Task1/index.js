var crypto = require('crypto');
const secp256k1 = require('secp256k1');

var result = crypto.createHash('md5').update('123456').digest('hex');
console.log(result);

