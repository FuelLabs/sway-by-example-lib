contract;

use std::{
    revert::require,
    auth::msg_sender,
};

abi OwnershipExample {
    #[storage(read, write)]
    fn revoke_ownership();
    #[storage(write)]
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
        assert(storage.owner.unwrap() == msg_sender().unwrap());
        storage.owner = Option::None();
    }

    #[storage(write)]
    fn set_owner(identity: Identity) {
        assert(storage.owner.unwrap() == msg_sender().unwrap());
        storage.owner = Option::Some(identity);
    }
    #[storage(read)]
    fn owner() -> Option<Identity> {
        storage.owner
    }

    // some function locked by onlyOwner
}