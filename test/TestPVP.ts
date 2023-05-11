import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { BigNumber } from "ethers";
import { expect } from "chai";

//const Web3 = require("web3");
const { upgrades, ethers } = require("hardhat");
//const sign = require("./sign");

describe(" Test FISH nft", function () {
  async function deployOneYearLockFixture() {
    const [deployer, addr1, addr2] = await ethers.getSigners();

    const items = await ethers.getContractFactory("FishNFT");
    const ITEMS = await items.deploy(13,addr1.address,"0x8af398995b04c28e9951adb9721ef74c74f93e6a478f39e7e0777be13527e7ef")
     
    const value = BigNumber.from("1000000000000000");
    const value2 = BigNumber.from("1000000000000000000");
   
   
    const hasOr =
      "0x0000000000000000000000000000000000000000000000000000000000000001";

    return {
      ITEMS,
      hasOr,
      deployer,
      addr1,
      addr2,
      value2,
    };
  }  
  it("Should check token uri and mint", async function () {
    const {  deployer, ITEMS,addr1 } = await loadFixture(
      deployOneYearLockFixture
    );
    // const getTenMinsTimestamp = () => {
    //   const minutesToAdd = 10;
    //   const currentDate = new Date();
    //   const expiry = new Date(currentDate.getTime() + minutesToAdd * 60000);
    //   return Math.floor(expiry.getTime() / 1000);
    // };
    const qwedqw = await ITEMS.grantRole(
      "0x0000000000000000000000000000000000000000000000000000000000000000",
      addr1.address
    );
    const mint13 = await ITEMS.mint(deployer.address, 4);
    const url = await ITEMS.tokenURI(1);
    //const url1 = await ITEMS.uri(1);
    console.log(url);
    //console.log(url1);
  });
  it("Should check token uri", async function () {
    const {  deployer, ITEMS,addr1 } = await loadFixture(
      deployOneYearLockFixture
    );

    const qwedqw = await ITEMS.grantRole(
      "0x0000000000000000000000000000000000000000000000000000000000000000",
      addr1.address
    );
    const mint13 = await ITEMS.mint(deployer.address, 4);
    const url = await ITEMS.tokenURI(1);
    const pause = await ITEMS.setPause(true);
    const unpause = await ITEMS.setPause(false);
  });
  
});
