contract;

dep interfaces;

use liquidity_pool::*;

use std::{
    call_frames::{
        contract_id,
    }
};

abi FlashLoaner {
    // flashCallback
    fn callback(
        fee0: u64,
        fee1: u64,
        // some sort of data
    );
    fn init_flash(
        curve: ContractId,
    );
}

// should just put it in here for simplicity
impl FlashLoaner for Contract {
    fn callback(fee0: u64, fee1: u64) {
        // TODO: define token0, token1, and lp contract - should be coming from a third field which is the data
        // Can just hardcode for now

        // ensure that the amount of tokens requested exists

        // Do something with the tokens!

        // calculate how much the tokens need to be returned

        // transfer the tokens back to the original contract
    }

    // add some more params here
    fn init_flash(lp_contract_id: ContractId){
        // get the address of the function we're calling
        let lp_pool = abi(
            LiquidityPool,
            lp_contract_id.into()
        );

        // call the flash function
        lp_pool.flash(
            Identity::ContractId(contract_id()),
            10,
            10,
        );

    }
}