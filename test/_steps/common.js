
const utils = require("../test_utils");
const config = require("../../republic-config");
const steps = require('./steps').steps;

const { accounts, indexMap } = require("../accounts");

// Wait for contracts:
let ren;
(async () => {
  ren = await artifacts.require("RepublicToken").deployed();
})();


module.exports = {

  ApproveRen: // async
    // from and to must match interface {address: ...}
    (from, to, amount) => ren.approve(to.address, amount, { from: from.address })
  ,

  // Distribute ren
  DistributeRen: // async
    (accounts) => Promise.all(accounts.map(account => ren.transfer(account.address, 1000000)))
  ,

  /** GetRenBalance */
  GetRenBalance: async (account) => {
    return await ren.balanceOf(account.address, { from: account.address });
  },

}