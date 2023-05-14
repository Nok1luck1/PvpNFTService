use hex_literal::hex;
use secp256k1::SecretKey;
use std::env;
use std::str::FromStr;
use std::time;
use web3::contract::{Contract, Options};
use web3::futures::StreamExt;
use web3::types::{Address, FilterBuilder, H160, U256};

#[tokio::main]
async fn main() -> web3::Result<()> {
    dotenv::dotenv().ok();

    Ok(())
}
