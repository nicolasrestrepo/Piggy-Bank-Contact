require("@nomiclabs/hardhat-waffle");
require('dotenv').config();

/**
 * @type import('hardhat/config').HardhatUserConfig
 */

const projectId =  process.env.INFURA_PROJECT_ID;
const deployerPrivateKey = process.env.DEPLOYER_SIGNER_PRIVATE_KEY;

module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: `https://rinkeby.infura.io/v3/${projectId}`,
      accounts: [
        deployerPrivateKey
      ]
    }
  }
};
