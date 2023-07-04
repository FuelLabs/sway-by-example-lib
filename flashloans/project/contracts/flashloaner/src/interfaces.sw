library liquidity_pool;

abi LiquidityPool {
    #[storage(read, write)]
    fn init(first_token: ContractId, second_token: ContractId, swap_fee: u64);

    #[storage(read)]
    fn flash(
        recipient: Identity,
        amount0: u64,
        amount1: u64,
    );
    // fn deposit(recipient: Address);
    // fn withdraw(recipient: Address);
}
