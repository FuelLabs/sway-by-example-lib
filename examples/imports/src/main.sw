contract;

// Imports
// - Internal
mod imports_library;
use imports_library::*;

// - External
use math_lib::full_math::*;

// - Standard library (std)
use std::{
    identity::*,
    auth::msg_sender,
};

// - Sway standards
use standards::src20::SRC20;

abi MyContract {
    fn test_function() -> bool;
}

impl MyContract for Contract {
    fn test_function() -> bool {
        true
    }
}
