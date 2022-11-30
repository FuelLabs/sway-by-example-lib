use std::str::FromStr;

use fuels::{prelude::*, tx::ContractId};

// Load abi from json
abigen!(MyContract, "out/debug/ownership-abi.json");

async fn get_contract_instance() -> (MyContract, ContractId) {
    // Launch a local network and deploy the contract
    let mut wallets = launch_custom_provider_and_get_wallets(
        WalletsConfig::new(
            Some(1),             /* Single wallet */
            Some(1),             /* Single coin (UTXO) */
            Some(1_000_000_000), /* Amount per coin */
        ),
        None,
        None,
    )
    .await;
    let wallet = wallets.pop().unwrap();

    let id = Contract::deploy(
        "./out/debug/ownership.bin",
        &wallet,
        TxParameters::default(),
        StorageConfiguration::with_storage_path(Some(
            "./out/debug/ownership-storage_slots.json".to_string(),
        )),
    )
    .await
    .unwrap();

    let instance = MyContract::new(id.clone(), wallet);

    (instance, id.into())
}

#[tokio::test]
async fn can_get_contract_id() {
    let (instance, _id) = get_contract_instance().await;

    // // Increment the counter
    let _result = instance.methods().owner().call().await.unwrap();

    let hex_str = "0x0000000000000000000000000000000000000000000000000000000000000001";
    let address = Address::from_str(hex_str).expect("failed to create Address from string");
    let my_identity: Identity = Identity::Address(Address::from(address));

    // // Get the current value of the counter
    instance.methods().set_owner(my_identity).call().await.unwrap();

    let result = instance.methods().owner().call().await.unwrap();

    instance.methods().revoke_ownership().call().await.unwrap();
    // // Check that the current value of the counter is 1.
    // // Recall that the initial value of the counter was 0.
    // assert_eq!(result.value, 1);
    println!("{:?}", result.value);
}
