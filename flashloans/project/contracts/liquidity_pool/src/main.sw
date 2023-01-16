contract;

dep errors;
// dep interfaces;
dep events;
dep libs;

use lp_lib::*;
// use flash_callback::*;
use events::*;
use errors::*;

use std::{
    call_frames::{
        contract_id,
        msg_asset_id,
    },
    context::{
        msg_amount,
        this_balance
    },
    token::{
        mint_to_address,
        transfer_to_address,
    },
    auth::{
        caller_contract_id,
        msg_sender,
    },
    reentrancy::reentrancy_guard,
    logging::log,
    u128::*,
    token::transfer,
};

use math_lib::full_math::*;

pub struct flashData {
    amount: u64,
    liquidity_pool: Address,
}

abi LiquidityPool {
    #[storage(read, write)]
    fn init(first_token: ContractId, second_token: ContractId, swap_fee: u64);

    #[storage(read)]
    fn flash(
        // recipient: Identity,
        amount0: u64,
        amount1: u64,
    );

    #[storage(read)]
    fn get_token0() -> ContractId;
    #[storage(read)]
    fn get_token1() -> ContractId;
    #[storage(read)]
    fn get_identity(id: Identity) -> Identity;

    #[storage(read)]
    fn get_fee() -> u64;
    // fn deposit(recipient: Address);
    // fn withdraw(recipient: Address);
}



storage {
    state: State = State::NotInitialized,
    token0: ContractId = ContractId{value:0x0000000000000000000000000000000000000000000000000000000000000000},
    token1: ContractId = ContractId{value:0x0000000000000000000000000000000000000000000000000000000000000000},
    flash_fee: u64 = 0,
}

// const TOKEN_0 = ContractId::from(0x9ae5b658754e096e4d681c548daf46354495a437cc61492599e33fc64dcdc30c);
// const TOKEN_1 = ContractId::from(0x9ae5b658754e096e4d681c548daf46354495a437cc61492599e33fc64dcdc30c);
// const ZERO_U128 = U128{upper: 0, lower: 0};
// const ONE_E_6_U128 = U128{upper: 0, lower: 1000000};

impl LiquidityPool for Contract {
    
    // https://fuellabs.github.io/sway/v0.31.2/blockchain-development/calling_contracts.html?highlight=contract_i#example
    // initialize the tokens
    #[storage(read, write)]
    fn init(_token0: ContractId, _token1: ContractId, swap_fee: u64) {
        require(storage.state == State::NotInitialized, InitializationError::CannotReinitialize);
        storage.state = State::Initialized;
        storage.token0 = _token0;
        storage.token1 = _token1;

    }

    #[storage(read)]
    fn flash(
        // recipient: Identity,
        amount0: u64,
        amount1: u64,
        // TODO add some sort of custom data
        // some struct containing data (better if there was custom data)
    ) {
        // reentrancy_guard();
        // no delegate call in sway?
        // Can be set in constructor etc
        
        let sender = msg_sender().unwrap();

        // Require that there is some liquidity to flashloan
        // let balance_before0 = this_balance(storage.token0);
        // let balance_before1 = this_balance(storage.token1);

        // require(balance_before0 > 0, "token0-zero-liquidity-depth");
        // require(balance_before1 > 0, "token1-zero-liquidity-depth");

        // Calculate fee in terms of how much is being pulled out
        // let fee_amount0 = mul_div_rounding_up_u64(amount0, storage.flash_fee, 1000000);
        // let fee_amount1 = mul_div_rounding_up_u64(amount1, storage.flash_fee, 1000000);

        // send tokens along
        // if (amount0 > 0) { transfer(amount0, storage.token0, recipient) };
        // if (amount1 > 0) { transfer(amount1, storage.token1, recipient) };

        // let flashloaner_contract = abi(
        //     // TODO bad naming case
        //     FlashLoaner, 
        //     caller_contract_id().into()
        // );

        // flashloaner_contract.callback(fee_amount0, fee_amount1);

        // let balance_after0 = this_balance(storage.token0);
        // let balance_after1 = this_balance(storage.token1);

        // TODO change '<' to '<=' once the U128 std library updates
        // require((balance_before0 + storage.flash_fee) < balance_after0, "token0-insufficient-returned");
        // require((balance_before1 + storage.flash_fee) < balance_after1, "token1-insufficient-returned");
        
        // sub is safe because we know balanceAfter is gt balanceBefore by at least fee
        // let paid0 = balance_after0 - balance_before0;
        // let paid1 = balance_after1 - balance_before1;
        // let paid0 = 0;
        // let paid1 = 0;

        // log(FlashEvent {
        //     sender, 
        //     recipient, 
        //     amount0, 
        //     amount1, 
        //     paid0, 
        //     paid1
        // });
    }
    
    #[storage(read)]
    fn get_token0() -> ContractId {
        storage.token0
    }

    #[storage(read)]
    fn get_token1() -> ContractId {
        storage.token1
    }
    
    #[storage(read)]
    fn get_fee() -> u64 {
        storage.flash_fee
    }

    #[storage(read)]
    fn get_identity(id: Identity) -> Identity {
        id
    }
    // TODO Add withdraw and deposit back?
}
