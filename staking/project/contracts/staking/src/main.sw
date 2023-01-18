contract;

abi MyContract {
    fn test_function() -> bool;
}

storage {
    rewards_token: ContractId = ContractId{value:0x0000000000000000000000000000000000000000000000000000000000000000},
    staking_token: ContractId = ContractId{value:0x0000000000000000000000000000000000000000000000000000000000000000},
    // probably have to change these to 128 or 256
    period_finish: u64 = 0,
    reward_rate: u64 = 0,
    reward_duration: u64 = 1234567, // 7 days
    last_update_time: u64 = 0,
    reward_per_token_stored: u64 = 0,

    // TODO: ownable
    // TODO: pausable

    // TODO: mapping for address <> userRewardPerTokenPaid
    // TODO: mapping for address <> rewards

    total_supply: u64 = 0, // priv?
    // TODO: mapping for balances // priv?
}

impl MyContract for Contract {
    fn test_function() -> bool {
        true
    }
}
