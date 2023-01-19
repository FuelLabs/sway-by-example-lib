contract;

dep lib;
dep errors;

use lib::*;
use errors::*;
use std::{
    identity::Identity
};

abi Initialization {
    #[storage(write)]
    fn transfer_ownership(new_owner: Identity);

    #[storage(read)]
    fn owner() -> Identity;
}

storage {
    owner: Identity = Identity::Address(Address {
        value: owner,
    })
}

impl Initialization for Contract {
    #[storage(write)]
    fn transfer_ownership(new_owner: Identity) {
        require(new_owner != Identity::Address(Address {value: 0x0000000000000000000000000000000000000000000000000000000000000000}), OwnerError::NewOwnerCannotBeZeroAddress);
        storage.owner = new_owner
    }

    #[storage(read)]
    fn owner() -> Identity {
        storage.owner
    }
}
