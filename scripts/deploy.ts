import { ethers, upgrades } from "hardhat";
const hre = require("hardhat");
const sepolia_vrfcoordinator = "0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625";
async function main() {
  const [deployer] = await ethers.getSigners();
  console.log(deployer.address, "deployed address");
  const items = await ethers.getContractFactory("FishNFT");
  const ITEMS = await items.deploy(13,sepolia_vrfcoordinator,"0x8af398995b04c28e9951adb9721ef74c74f93e6a478f39e7e0777be13527e7ef")  
  console.log(`Market address : ${ITEMS.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
