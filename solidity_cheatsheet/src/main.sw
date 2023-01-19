contract;

use std::{
    identity::Identity,
    block::{
        height,
        timestamp,
    },
    auth::{
        msg_sender
    },
    constants::*,
    u128::U128
};

abi SolidityCheatsheet {
    #[storage(write)]
    fn set_blocknumber(); // block.number equivalent
    
    #[storage(write)]
    fn set_blocktime(); // block.timestamp equivalent
    
    #[storage(write)]
    fn set_msg_sender(); // msg.sender equivalent

    #[storage(write)]
    fn set_u128_number(); // uint128 equivalent
}

storage {
    sender: Identity = Identity::Address(Address {value: ZERO_B256}),
    block_time: u64 = 0,
    block_number: u64 = 0,
    u128_number: U128 = U128::from((0, 0)),
}

impl SolidityCheatsheet for Contract {
    #[storage(write)]
    fn set_blocknumber() {
        storage.block_number = height();
    }
    
    #[storage(write)]
    fn set_blocktime() {
        storage.block_time = timestamp();
    }
    
    #[storage(write)]
    fn set_msg_sender() {
        storage.sender = msg_sender().unwrap();
    }

    #[storage(write)]
    fn set_u128_number() {
        // There is no uint128 in Sway so it is composed of two 64-bit components
        // Within the library Sway team has also provided full list of operations 
        // i.e. exponents, plus, minus, multiply, divide, square roots, etc
        // Full of operations here https://github.com/FuelLabs/sway/blob/master/sway-lib-std/src/u128.sw
        // Note there is also an equivalent for uint256 composed of four 64-bit components
        storage.u128_number = U128::from((0, 12)) + U128::from((0, 12));
    }
}
