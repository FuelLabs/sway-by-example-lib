contract;

abi Alice {
    #[storage(read)]
    fn get_number() -> u64;
}

storage {
    favourite_number: u64 = 42,
}

impl Alice for Contract {
    #[storage(read)]
    fn get_number() -> u64 {
        return storage.favourite_number;
    }
}
