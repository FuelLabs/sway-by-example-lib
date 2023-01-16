library flash_callback;

abi flashloaner {
    fn callback(
        // TODO add fees
        fee0: u64,
        fee1: u64,
        // some sort of data about returning funds
    );
}
