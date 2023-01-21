contract;

dep events;

use events::*;
use std::{
    logging::log,
    auth::{
        msg_sender
    },
    constants::ZERO_B256,
};

abi NFT {
    fn mint();
}

impl NFT for Contract {
    fn mint() {
        let sender = Identity::Address(Address {value: ZERO_B256});
        let user = msg_sender().unwrap();
        
        // ... some minting code ...

        log(Transfer {
            sender, 
            recipient: user, 
            token_id: 42, 
        })
    }
}
