contract;

dep lib;
dep errors;

use lib::*;
use errors::*;

abi Initialization {
    #[storage(read, write)]
    fn initialize();

    #[storage(read, write)]
    fn upgrade_blockchain();

    #[storage(read)]
    fn blockchain() -> str[11];
}

storage {
    state: State = State::NotInitialized,
    
    blockchain_type: str[11] = "monolithic!",
}

impl Initialization for Contract {
    #[storage(read, write)]
    fn initialize() {
        require(storage.state == State::NotInitialized, InitializationError::CannotReinitialize);
        
        storage.state = State::Initialized;
    }

    #[storage(read, write)]
    fn upgrade_blockchain() {
        require(storage.state == State::Initialized, InitializationError::ContractNotInitialized);
        storage.blockchain_type = "**modular**"
    }

    #[storage(read)]
    fn blockchain() -> str[11] {
        storage.blockchain_type
    }
}
