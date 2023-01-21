contract;

use std::{
    constants::ZERO_B256,
    auth::msg_sender,
    identity::*,
};

abi AccountTypes {
    fn match_address(some_address: Address) -> str[16];
    fn match_contract(some_contract: ContractId) -> str[17];
    fn match_identity(some_identity: Identity) -> str[17];
}

// Refer to how Native Tokens are Handled with each
impl AccountTypes for Contract {
    fn match_address(some_address: Address) -> str[16] {
        if (some_address == Address::from(secret_b256)){
            "Correct Address!"
        } else {
            "Mismatch Address"
        }
    }

    fn match_contract(some_contract: ContractId) -> str[17] {
        if (some_contract == ContractId::from(secret_b256)){
            "Correct Contract!"
        } else {
            "Mismatch Contract"
        }
    }
    
    // Expecting both contracts and EOAs to be calling this function since Identity is agnostic
    fn match_identity(some_identity: Identity) -> str[17] {
        match some_identity {
            // For example token transfers differ because contracts cant hold UTXOs
            my_contract_identity => {
                // Do something contract related!
                "Contract Identity"
            },
            my_address_identity => {
                // Do something address related!
                "Address Identity!"
            },
            _ => "Mismatch Identity",
        }
    }
}

