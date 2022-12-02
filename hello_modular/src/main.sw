// The underlying smart contracts written in Sway are no different than those in Solidity, where some bytecode is deployed with an API and state to interact with.
contract;

// The ABI (Application Binary Interface) clearly defines the signature of the functions present in the contract
abi HelloModular {
    // The "annotation" storage indicates the impure actions of the function
    // In this case the greet() function only has reading capabilities.
    // Note: Storage can only be found in contract type programs
    #[storage(read)]
    fn greet() -> str[16];
}

// Storage contains all of the state available in the contract 
storage {
    greet: str[16] = "Welcome to Sway!"
}

// The actual implementation of ABI for the contract
impl HelloModular for Contract {
    #[storage(read)]
    fn greet() -> str[16] {
        storage.greet
    }
}
