import { ethers} from "hardhat";
const hre = require("hardhat");
const sepolia_vrfcoordinator = "0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625";
import Abi  from "../artifacts/contracts/FishNFT.sol/FishNFT.json";
async function main() {
  const [deployer] = await ethers.getSigners();
  console.log(deployer.address, "deployed address");
  const FisHNFT = await ethers.getContractAt(Abi.abi, "0x26FF03375bfd92bFdcE3FE54601CD61417F53567");
 const link = await FisHNFT.tokenURI(0);
 console.log(link);
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});