var Vault = artifacts.require("./Vault.sol");

module.exports = function(deployer) {
  deployer.deploy(Vault, "0x90f8bf6a479f320ead074411a4b0e7944ea8c9c1",
      "0xffcf8fdee72ac11b5c542428b35eef5769c409f0",
      "0x22d491bde2303f2f43325b2108d26f1eaba1e32b",
      2000000000000000000,
      60);
}; //these are the function arguments that go into the main function of the contract, the function "Vault"

//20000... is the amount allowed for withdrawal
//60 number of time