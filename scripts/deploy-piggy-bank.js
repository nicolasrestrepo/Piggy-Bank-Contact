async function deployPiggyBank(){
    // ether is in the context
    const [deployer] = await ethers.getSigners();

    console.log('Deploying contract with the account', deployer.address);

    // get info from compilation cache
    const piggyBank = await ethers.getContractFactory("PiggyBank");

    const deployed = await piggyBank.deploy();

    console.log('piggyBank is deployed at:', deployed.address);
}

deployPiggyBank()
    .then(() => process.exit(0))
    .catch((error) => {
        console.log('error', error);
        process.exit(1);
    })