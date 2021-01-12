const port = process.env.HOST_PORT || 9095
const fs = require('fs');
const privatekey = fs.readFileSync(".secret").toString().trim();

module.exports = {
  networks: {
    mainnet: {
      // Don't put your private key here:
      privateKey: process.env.PRIVATE_KEY_MAINNET,
      /*
Create a .env file (it must be gitignored) containing something like

  export PRIVATE_KEY_MAINNET=4E7FECCB71207B867C495B51A9758B104B1D4422088A87F4978BE64636656243

Then, run the migration with:

  source .env && tronbox migrate --network mainnet

*/
      userFeePercentage: 100,
      feeLimit: 1e8,
      fullHost: 'https://api.trongrid.io',
      network_id: '1'
    },
    shasta: {
      //privateKey: process.env.PRIVATE_KEY_SHASTA,
      privateKey: privatekey,
      userFeePercentage: 50, 
      feeLimit: 1e8,
      fee_limit: 100000000,
      fullHost: 'https://api.shasta.trongrid.io',
      network_id: '2'
    },
    nile: {
      privateKey: process.env.PRIVATE_KEY_NILE,
      userFeePercentage: 100,
      feeLimit: 1e8,
      fullHost: 'https://api.nileex.io',
      network_id: '3'
    },
    development: {
      // For trontools/quickstart docker image
      privateKey: '2ff8a6b4237cbd2f6f1d64146c6214fff68a2aa778d8819b795ec1b53e1ee8df',
      userFeePercentage: 0,
      feeLimit: 0,
      fullHost: 'http://127.0.0.1:' + port,
      network_id: '9'
    },
    compilers: {
      solc: {
        version: '0.4.25'
      }
    }
  }
}
