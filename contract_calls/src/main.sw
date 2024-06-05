contract;

use alice::Alice;

abi Bob {
    #[storage(write, read)]
    fn copy_alices_number(contract_id: b256) -> u64;
}

storage {
    copied_number: u64 = 0,
}

impl Bob for Contract {
    #[storage(write, read)]
    fn copy_alices_number(contract_id: b256) -> u64 {
        // Calling other contracts
        let alice_contract = abi(Alice, contract_id);
        storage.copied_number = alice_contract.get_number();
        return storage.copied_number;
    }
}
