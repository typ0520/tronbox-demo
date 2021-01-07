const TetherToken = artifacts.require('TetherToken');

module.exports = async (deployer) => {
  await deployer.deploy(TetherToken, '10000000000', 'Tether USD2', 'USDT2', 6);
};
