library events;

pub struct FlashEvent {
    sender: Identity,
    recipient: Identity,
    amount0: u64,
    amount1: u64,
    paid0: u64,
    paid1: u64,
}
