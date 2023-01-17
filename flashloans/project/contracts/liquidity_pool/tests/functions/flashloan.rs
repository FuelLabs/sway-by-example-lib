use crate::utils::{
    abi_calls::{fee, asset0, asset1, inititalize, flash},
    test_helpers::{
        setup,
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
        
        let init_fee = fee(&liquidity_pool.instance).await.value;
        // TODO: rename flashloan_user to wallet something
        // let (fl_contract_id, lp_contract_id, flashloan_user, [token0_id, token1_id]) = setup().await;
        // println!("Contract deployed @ {fl_contract_id}");

        println!("Fee! {init_fee}");

        let token0 = asset0(&liquidity_pool.instance).await.value;
        println!("Token Zero! {token0}");

        let token0Generated = liquidity_pool.asset0;
        println!("Token Zero Generated! {token0Generated}");

        let token1Generated = liquidity_pool.asset1;
        println!("Token One Generated! {token1Generated}");

        let token1 = asset1(&liquidity_pool.instance).await.value;
        println!("Token One! {token1}");

        inititalize(
            &liquidity_pool.instance,
            liquidity_pool.asset0,
            liquidity_pool.asset1,
            6969,
        ).await;

        let token0After = asset0(&liquidity_pool.instance).await.value;
        println!("Token Zero! {token0After}");

        let token1After = asset1(&liquidity_pool.instance).await.value;
        println!("Token One! {token1After}");

        // Send some money to the contract first
        // TODO .into() gets the address from the object write that down
        wallet.force_transfer_to_contract(&lp_contract_id, 69, liquidity_pool.asset0, TxParameters::default()).await;
        wallet.force_transfer_to_contract(&lp_contract_id, 69, liquidity_pool.asset1, TxParameters::default()).await;

        let contract_balances = wallet.get_provider().unwrap().get_contract_balances(&lp_contract_id).await;
        println!("LP Contract Token Balance {:?}", contract_balances);

        println!("LP Contract Token Balance {:?}", lp_contract_id);


        let blah = flash(
            &flash_loaner.instance,
            ContractId::zeroed()
        ).await;

        // println!("fl_user={:?} token0={:?} token1={:?}", flashloan_user, token0_id, token1_id);

        // let token0_balance: u64 = flashloan_user.get_asset_balance(&AssetId::from(*token0_id)).await.unwrap();
        // let token1_balance: u64 = flashloan_user.get_asset_balance(&AssetId::from(*token1_id)).await.unwrap();
        // println!("balance of flash user{:?}", token0_balance);
        // println!("balance of flash user{:?}", token1_balance);

        // let contract_balances = flashloan_user.get_provider().unwrap().get_contract_balances(&lp_contract_id).await;
        // println!("balance of flash user{:?}", contract_balances);

        // flashloan_user.force_transfer_to_contract(&lp_contract_id, 100, AssetId::from(*token0_id), TxParameters::default()).await;
        // flashloan_user.force_transfer_to_contract(&lp_contract_id, 69, AssetId::from(*token1_id), TxParameters::default()).await;

        // let contract_balances_after = flashloan_user.get_provider().unwrap().get_contract_balances(&lp_contract_id).await;
        // println!("balance of flash user{:?}", contract_balances_after);

        // let token0_balance_after: u64 = flashloan_user.get_asset_balance(&AssetId::from(*token0_id)).await.unwrap();
        // let token1_balance_after: u64 = flashloan_user.get_asset_balance(&AssetId::from(*token1_id)).await.unwrap();
        // println!("balance of flash user{:?}", token0_balance_after);
        // println!("balance of flash user{:?}", token1_balance_after);
        // // assert!(contract_balances.is_empty());

        // let lp_instance = LiquidityPool::new(lp_contract_id, flashloan_user);

        // let fl_instance = Flashloaner::new(fl_contract_id.clone(), flashloan_user.clone());

        
        // let res = &lp_instance.methods().init(
        //     token0_id,
        //     token1_id,
        //     696969
        // ).call().await;

        // let blah = fl_instance.methods().init_flash(ContractId::from(&lp_contract_id)).call().await;
        
        // let blah = lp_instance.methods().get_fee().call().await.unwrap();
        // println!("fee{:?}", blah);
        // let counter = lp_instance.token0().await
        // println!("token zero{:?}", counter);

        // fl_instance.methods.get_token0

        // let contract_balances_after2 = flashloan_user.get_provider().unwrap().get_contract_balances(&lp_contract_id).await;
        // println!("balance of flash user{:?}", contract_balances_after2);

        // let contract_balances_after3 = flashloan_user.get_provider().unwrap().get_contract_balances(&fl_contract_id).await;
        // println!("balance of flash user{:?}", contract_balances_after3);

        // assert!(contract_balances.is_empty());
        
    }
}