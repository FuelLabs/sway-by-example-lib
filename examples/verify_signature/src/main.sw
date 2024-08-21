contract;

use std::hash::*;
use std::ecr::{ec_recover_address, EcRecoverError};
use std::bytes::Bytes;
use std::b512::B512;
use std::constants::ZERO_B256;

abi VerifySignature {
    fn get_message_hash(_to: b256, _amount: u64, _message: str, _nonce: u64) -> b256;
    fn get_eth_signed_message_hash(_message_hash: b256) -> b256;
    fn recover_signer(_eth_signed_message_hash: b256, _signature: B512) -> b256;
    fn verify(_signer: b256, _to: b256, _amount: u64, _message: str, _nonce: u64, _signature: B512) -> bool;
    
}

fn get_message_hash(_to: b256, _amount: u64, _message: str, _nonce: u64) -> b256 {
        keccak256({
        let mut bytes = Bytes::new();
        bytes.append(Bytes::from(core::codec::encode(_to)));
        bytes.append(Bytes::from(core::codec::encode(_amount)));
        bytes.append(Bytes::from(core::codec::encode(_message)));
        bytes.append(Bytes::from(core::codec::encode(_nonce)));
        bytes
    })
    }

    fn get_eth_signed_message_hash(_message_hash: b256) -> b256 {
        keccak256({
        let mut bytes = Bytes::new();
        bytes.append(Bytes::from(core::codec::encode("\x19Fuel Signed Message:\n32")));
        bytes.append(Bytes::from(core::codec::encode(_message_hash)));
        bytes
    })
    }

    fn recover_signer(_eth_signed_message_hash: b256, _signature: B512) -> b256 {
        match ec_recover_address(_signature, _eth_signed_message_hash) {
            Ok(address) => address.bits(),
            Err(_) => ZERO_B256,
        }
    }

impl VerifySignature for Contract {


    fn get_message_hash(_to: b256, _amount: u64, _message: str, _nonce: u64) -> b256{
        ::get_message_hash(_to, _amount, _message, _nonce)
    }

    fn get_eth_signed_message_hash(_message_hash: b256) -> b256 {
        ::get_eth_signed_message_hash(_message_hash)
    }

    fn recover_signer(_eth_signed_message_hash: b256, _signature: B512) -> b256{
        ::recover_signer(_eth_signed_message_hash, _signature)
    }
    
   fn verify(_signer: b256, _to: b256, _amount: u64, _message: str, _nonce: u64, _signature: B512) -> bool {   
        let message_hash = get_message_hash(_to, _amount, _message, _nonce);
        let eth_signed_message_hash = get_eth_signed_message_hash(message_hash);
        let recovered_signer = recover_signer(eth_signed_message_hash, _signature);
        recovered_signer == _signer
    }
}
