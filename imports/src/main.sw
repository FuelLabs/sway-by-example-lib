contract;
// Importing within the same project
// ABI
// must be imported first
dep imports_library;

use imports_library::*;

// Importing the standard library
// STD Lib
// https://github.com/FuelLabs/sway/tree/master/sway-lib-std
use std::{
    identity::*,
    address::*,
    constants::*,
    auth::msg_sender,
};

// Importing library from a different project
// Math libraries copied from https://github.com/sway-libs/concentrated-liquidity/
use math_lib::full_math::*;

storage {
    z: u64 = 0,
    last_user: Identity = Identity::Address(Address::from(ZERO_B256)),
}

impl Imports for Contract {
    #[storage(write)]
    fn add(x: u64, y: u64) {
        storage.z = x + y;
    }

    #[storage(write)]
    fn last_user() {
        storage.last_user = msg_sender().unwrap();
    }

    #[storage(write)]
    fn fixed_point_multiply_and_divide(a: u64, b: u64, c: u64) {
        storage.z = mul_div_u64(a, b, c);
    }
}
