library errors;

pub enum InitializationError {
    CannotReinitialize: (),
    ContractNotInitialized: (),
}