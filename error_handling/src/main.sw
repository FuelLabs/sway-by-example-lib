contract;

dep errors;

use errors::*;

use std::{
    revert::require,
    assert::assert,
    logging::log
};

abi Error {
    fn test_require(special_number: u64);
    fn test_assert(special_number: u64);
    fn test_require_import(special_number: u64);
}

impl Error for Contract {
    fn test_require(special_number: u64) {
        require(special_number == 42, "Special number must be equal to 42");
    }

    fn test_assert(special_number: u64) {
        assert(special_number == 42);
    }

    fn test_require_import(special_number: u64) {
        require(special_number == 42, InputError::InputSmallerThan42);
    }
}
