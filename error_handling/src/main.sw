contract;

dep errors;

use errors::*;

use std::{
    revert::require,
    assert::assert,
    logging::log
};

abi Error {
    fn test_revert(special_number: u64);
    fn test_require(special_number: u64);
    fn test_assert(special_number: u64);
    fn test_custom_require(special_number: u64);
    fn test_option(special_number: Option<u64>);
    fn test_result(special_number: u64) -> Result<u64, InputError>;
}

impl Error for Contract {
    fn test_revert(special_number: u64) {
        if (special_number != 42) {
            revert(0)
        }
    }

    fn test_require(special_number: u64) {
        require(special_number == 42, "Special number must be equal to 42");
    }

    fn test_assert(special_number: u64) {
        assert(special_number == 42);
    }

    fn test_custom_require(special_number: u64) {
        require(special_number == 42, InputError::InputSmallerThan42);
    }

    fn test_option(special_number: Option<u64>) {
        require(special_number.is_some(), InputError::NumberDoesNotExist);
        // require(special_number.is_none(), InputError::NumberExist);
    }

    fn test_result(special_number: u64) -> Result<u64, InputError> {
        match special_number == 42 {
            true => Result::Ok(special_number),
            false => Result::Err(InputError::InputIsNot42),
        }
    }
}
