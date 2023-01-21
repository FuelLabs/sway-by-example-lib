library events;

pub struct Transfer {
    sender: Identity,
    recipient: Identity,
    token_id: u64,
}
