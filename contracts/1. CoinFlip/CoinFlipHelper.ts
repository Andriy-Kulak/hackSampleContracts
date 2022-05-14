import { expect } from "chai";
import { ethers } from "hardhat";

const helper = async (attacker: any) => {
  // add code here that will help you pass the test
  console.log("test");
  let i = 0;
  while (i <= 9) {
    await attacker.hackContract();
    i++;
  }
};

export default helper;
