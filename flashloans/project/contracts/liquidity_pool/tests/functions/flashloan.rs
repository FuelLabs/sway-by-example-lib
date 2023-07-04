use crate::utils::{
    abi_calls::{inititalize, flash},
    test_helpers::{
        setup_and_initialize,
    },
};

abigen!(LiquidityPool, "./out/debug/liquidity_pool-abi.json");
abigen!(Flashloaner, "../flashloaner/out/debug/flashloaner-abi.json");

use fuels::prelude::*;

mod success {
    use super::*;

    #[tokio::test]
    async fn gets_some() {
        let (liquidity_pool, flash_loaner, lp_contract_id, wallet) = setup_and_initialize().await;

        inititalize(
            &liquidity_pool.instance,
            liquidity_pool.asset0,
            liquidity_pool.asset1,
            2500,
        ).await;

        // Send some money to the contract first
        let _token0_transfer = wallet.force_transfer_to_contract(&lp_contract_id, 100000, liquidity_pool.asset0, TxParameters::default()).await;
        let _token1_transfer = wallet.force_transfer_to_contract(&lp_contract_id, 100000, liquidity_pool.asset1, TxParameters::default()).await;

        let _blah = flash(
            &flash_loaner.instance,
            ContractId::zeroed()
        ).await;
    }
}