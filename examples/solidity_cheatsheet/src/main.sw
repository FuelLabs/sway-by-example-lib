contract;

use std::{
    identity::Identity,
    block::{ height, timestamp },
    auth::msg_sender,
    constants::*,
    u128::U128
};

abi SolidityCheatsheet {
    fn get_blocknumber() -> u32;
    fn get_blocktime() -> u64;
    fn get_msg_sender() -> Identity;
    fn get_u128_number() -> U128;
}

impl SolidityCheatsheet for Contract {
    fn get_blocknumber() -> u32 {
        return height(); // block.number equivalent
    }
    
    fn get_blocktime() -> u64 {
        return timestamp(); // block.timestamp equivalent
    }
    
    fn get_msg_sender() -> Identity {
        return msg_sender().unwrap(); // msg.sender equivalent
    }

    fn get_u128_number() -> U128 { 
        /*  There is no uint128 in Sway so it is composed of two 64-bit components
            Within the library Sway team has also provided full list of operations 
            i.e. exponents, plus, minus, multiply, divide, square roots, etc
            Full of operations here https://github.com/FuelLabs/sway/blob/master/sway-lib-std/src/u128.sw
            Note there is also an equivalent for uint256 composed of four 64-bit components
        */
        return U128::from((0, 12)) + U128::from((0, 12)); // uint128 equivalent
    }
}
