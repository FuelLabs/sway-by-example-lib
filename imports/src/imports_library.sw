library imports_library;

abi Imports {
    #[storage(write)]
    fn add(x: u64, y: u64);

    #[storage(write)]
    fn last_user();

    #[storage(write)]
    fn fixed_point_multiply_and_divide(a: u64, b: u64, c: u64);
}