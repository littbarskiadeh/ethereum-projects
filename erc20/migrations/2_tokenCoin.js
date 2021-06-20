const HCoin = artifacts.require("Hcoin");

module.exports = function (deployer) {
  deployer.deploy(HCoin,'1000', 'HCoin', 'HoC', '8');
};
