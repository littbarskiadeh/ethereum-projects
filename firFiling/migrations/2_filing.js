const Filing = artifacts.require("Filing");

module.exports = function (deployer) {
  deployer.deploy(Filing, "Business Requirements doc", "Document","Business Requirement for Project");
};
