contract;

// Imports
// - Internal
// - External
// - Standard library (std)
// - Sway standards

mod imports_library;
use imports_library::*;

use std::{
    identity::*,
    auth::msg_sender,
};

use standards::src20::SRC20;

use math_lib::full_math::*;

abi MyContract {
    fn test_function() -> bool;
}

impl MyContract for Contract {
    fn test_function() -> bool {
        true
    }
}
