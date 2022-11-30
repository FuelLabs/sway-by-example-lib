contract;

dep errors;

use errors::*;

use std::{
    revert::require,
    auth:: { AuthError, msg_sender },
};

abi OwnershipExample {
    #[storage(read, write)]
    fn revoke_ownership();
    #[storage(read, write)]
    fn set_owner(identity: Identity);
    #[storage(read)]
    fn owner() -> Option<Identity>;
}

storage {
    owner: Option<Identity> = Option::None,
}

impl OwnershipExample for Contract {
    #[storage(read, write)]
    fn revoke_ownership() {
        let sender: Result<Identity, AuthError> = msg_sender(); 
        require(sender.unwrap() == storage.owner.unwrap(), OwnerError::IsNotOwner);
        storage.owner = Option::None();
    }

    #[storage(read, write)]
    fn set_owner(identity: Identity) {
        let sender: Result<Identity, AuthError> = msg_sender(); 
        require(sender.unwrap() == storage.owner.unwrap(), OwnerError::IsNotOwner);
        storage.owner = Option::Some(identity);
    }
    #[storage(read)]
    fn owner() -> Option<Identity> {
        storage.owner
    }
}