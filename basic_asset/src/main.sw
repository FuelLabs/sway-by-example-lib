contract;

use std::{
    auth::{
        msg_sender,
    },
    call_frames::{
        contract_id,
        msg_asset_id,
    },
    constants::BASE_ASSET_ID,
    context::{
        balance_of,
        msg_amount,
    },
    token::{
        transfer,
    },
};

abi MyContract {
    #[payable]
    fn deposit();
    fn withdraw(amount: u64);
    fn get_balance() -> u64;
}

impl MyContract for Contract {
    #[payable]
    fn deposit() {
        require(msg_asset_id() == BASE_ASSET_ID, "not base asset");
        require(msg_amount() > 0, "amount = 0");
    }

    fn withdraw(amount: u64) {
        transfer(amount, BASE_ASSET_ID, msg_sender().unwrap());
    }

    fn get_balance() -> u64 {
        balance_of(BASE_ASSET_ID, contract_id())
    }
}
