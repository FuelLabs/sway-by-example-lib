contract;

// 1. Importing within the same project
// Using "mod" keyword, you can define the library as a dependency within a program.
mod sqrt_lib;

// It is a good practice to import in ABI
// It is also a good practice to define events and custom errors using this way

// Using "use" keyword imports in a library
// use srt_lib::*;

// 2. Importing the standard library
// The standard library consists of
//   a. language primitives
//   b. blockchain contextual operations
//   c. native asset management
//   etc.
// Functions like msg.sender(), block.timestamp(),etc are found here https://github.com/FuelLabs/sway/tree/master/sway-lib-std
// use std::{
//     identity::*,
//     address::*,
//     constants::*,
//     auth::msg_sender,
// };

// 3. Importing from a different project
// If any library is not listed as a dependency, but present in forc.toml, you can use it as below.
// Math libraries copied from https://github.com/sway-libs/concentrated-liquidity/
// use math_lib::full_math::*;

use ::sqrt_lib::math_sqrt;

abi TestMath {
    fn test_square_root(x: u256) -> u256;
}

impl TestMath for Contract {
    fn test_square_root(x: u256) -> u256 {
        math_sqrt(x)
    }
}