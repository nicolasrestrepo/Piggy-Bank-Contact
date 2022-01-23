const { expect } = require("chai");

describe('Piggy Bank Contract', () => {
 
   const setup = async() => {
    const PiggyBank = await ethers.getContractFactory("PiggyBank");

    const deployed = await PiggyBank.deploy();

    return {
        deployed
    }
   } 

   describe('Deployment', () => {
       it('deposit created successfully', async () => {
           const { deployed } = await setup();
          
           await deployed.deposit(1)

           const result = await deployed.getBalance()

           expect(result)
       })
   })
})