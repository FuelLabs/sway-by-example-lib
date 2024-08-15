library;

use std::hash::sha256;
use std::hash::Hash;

/// Generates a SHA-256 hash of the input.
pub fn generate_sha256<T: Hash>(input: T) -> b256 {
    sha256(input)
}

/// Verifies if the SHA-256 hash of the input matches the provided hash.
pub fn verify_sha256<T: Hash>(input: T, expected_hash: b256) -> bool {
    let computed_hash = sha256(input);
    computed_hash == expected_hash
}
