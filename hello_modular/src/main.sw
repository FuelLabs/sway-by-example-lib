contract;

abi HelloModular {
    #[storage(read)]
    fn greet() -> str[16];
}

storage {
    greet: str[16] = "Welcome to Sway!"
}

impl HelloModular for Contract {
    #[storage(read)]
    fn greet() -> str[16] {
        storage.greet
    }
}
