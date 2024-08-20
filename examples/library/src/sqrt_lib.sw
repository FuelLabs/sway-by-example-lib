library;

pub fn math_sqrt(y: u256) -> u256 {
    let mut z: u256 = 0;
    if y > 3 {
        z = y;
        let mut x = y / 2 + 1;
        while x < z {
            z = x;
            x = (y / x + x) / 2;
        }
    } else if y != 0 {
        z = 1;
    }
    z
}
