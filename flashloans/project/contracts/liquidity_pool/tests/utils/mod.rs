use fuels::{contract::call_response::FuelCallResponse, prelude::*};

// Load abi from json
abigen!(LiquidityPool, "./out/debug/liquidity_pool-abi.json");
abigen!(FlashLoaner, "./tests/artifacts/flashloaner/out/debug/flashloaner-abi.json");

pub mod paths {
    pub const LIQUIDITY_POOL_BINARY_PATH: &str = "./out/debug/liquidity_pool.bin";
    pub const LIQUIDITY_POOL_STORAGE_PATH: &str = "./out/debug/liquidity_pool-storage_slots.json";
    pub const FLASH_LOANER_BINARY_PATH: &str = "./tests/artifacts/flashloaner/out/debug/flashloaner.bin";
    pub const FLASH_LOANER_STORAGE_PATH: &str = "./tests/artifacts/flashloaner/out/debug/flashloaner-storage_slots.json";
}

pub struct LiquidityPoolContract {
    pub asset0: AssetId,
    pub asset1: AssetId,
    pub instance: LiquidityPool,
}

pub struct FlashLoanerContract {
    pub instance: FlashLoaner,
}

pub mod abi_calls {
    use super::*;

    pub async fn inititalize(
        contract: &LiquidityPool,
        asset0: AssetId,
        asset1: AssetId,
        swap_fee: u64,
    ) -> FuelCallResponse<()> {
        contract
            .methods()
            .init(
                ContractId::new(*asset0),
                ContractId::new(*asset1),
                swap_fee
            )
            .call()
            .await
            .unwrap()
    }

    pub async fn flash (
        contract: &FlashLoaner,
        lp_contract_id: ContractId
    ) -> FuelCallResponse<()> {
        println!("In here! {:?}", lp_contract_id);
        contract
            .methods()
            .init_flash(
                lp_contract_id
            )
            .call()
            .await
            .unwrap()
    }
}

pub mod test_helpers {
    use super::*;

    use paths::{
        LIQUIDITY_POOL_BINARY_PATH, 
        LIQUIDITY_POOL_STORAGE_PATH,
        FLASH_LOANER_BINARY_PATH,
        FLASH_LOANER_STORAGE_PATH
    };

    pub async fn setup_and_initialize() -> (
        LiquidityPoolContract,
        FlashLoanerContract,
        Bech32ContractId,
        WalletUnlocked,
    ) {
        let (lp_instance, fl_instance, wallet, lp_contract_id, asset0, asset1) = setup().await;

        let liquidity_pool = LiquidityPoolContract {
            asset0,
            asset1,
            instance: lp_instance,
        };

        let flash_loaner = FlashLoanerContract {
            instance: fl_instance,
        };

        (liquidity_pool, flash_loaner, lp_contract_id, wallet)
    }

    pub async fn setup() -> (LiquidityPool, FlashLoaner, WalletUnlocked, Bech32ContractId, AssetId, AssetId){
        let mut wallet = WalletUnlocked::new_random(None);
        let num_assets = 3;
        let coins_per_asset = 1;
        let amount_per_coin = 1_000_000;
        let (coins, asset_ids) = setup_multiple_assets_coins(
            wallet.address(),
            num_assets,
            coins_per_asset,
            amount_per_coin,
        );
        let (provider, _socket_addr) = setup_test_provider(coins.clone(), vec![], None, None).await;
        wallet.set_provider(provider);

        let lp_contract_id = Contract::deploy(
            LIQUIDITY_POOL_BINARY_PATH,
            &wallet,
            TxParameters::default(),
            StorageConfiguration::with_storage_path(Some(LIQUIDITY_POOL_STORAGE_PATH.to_string())),
        )
        .await
        .unwrap();

        let lp_instance = LiquidityPool::new(lp_contract_id.clone(), wallet.clone());

        let fl_contract_id = Contract::deploy(
            FLASH_LOANER_BINARY_PATH,
            &wallet,
            TxParameters::default(),
            StorageConfiguration::with_storage_path(Some(FLASH_LOANER_STORAGE_PATH.to_string())),
        )
        .await
        .unwrap();

        let fl_instance = FlashLoaner::new(fl_contract_id.clone(), wallet.clone());



        (
            lp_instance,
            fl_instance, 
            wallet,
            // liquidity_pool_id,
            lp_contract_id,
            asset_ids[0],
            asset_ids[1],
        )
    }
}