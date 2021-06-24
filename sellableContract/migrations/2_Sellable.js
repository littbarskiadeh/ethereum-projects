const Sellable = artifacts.require("Sellable");

module.exports = function (deployer) {
  deployer.deploy(Sellable);
};
