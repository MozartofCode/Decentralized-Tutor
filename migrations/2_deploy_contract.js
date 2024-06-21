const TutorSystem = artifacts.require("TutorSystem");

module.exports = function(deployer) {
  deployer.deploy(TutorSystem);
};