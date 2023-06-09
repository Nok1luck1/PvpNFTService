import { ethers, upgrades } from "hardhat";
const hre = require("hardhat");
const sepolia_vrfcoordinator = "0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625";
async function main() {
  const [deployer] = await ethers.getSigners();
  console.log(deployer.address, "deployed address");
  const items = await ethers.getContractFactory("FishNFT");
  const ITEMS = await items.deploy()  //2148,sepolia_vrfcoordinator,"0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c"
  console.log(`Market address : ${ITEMS.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
