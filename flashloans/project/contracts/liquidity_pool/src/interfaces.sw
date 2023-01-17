library flash_loaner;

abi FlashLoaner {
    // flashCallback
    fn callback(
        fee0: u64,
        fee1: u64,
        // some sort of data
    );
    fn init_flash(
        curve: ContractId,
    );
}