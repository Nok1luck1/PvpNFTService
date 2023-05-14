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
    let websokcet = web3::transports::WebSocket::new(&env::var("INFURA_SEPOLIA").unwrap()).await?;
    let web3s = web3::Web3::new(websokcet);
    let mut accounts = web3s.eth().accounts().await?;
    println!("{:?}", accounts);
    let contract = Contract::from_json(
        web3s,
        Address::from("value"),
        ("../artifacts/contracts/FishNFT.json"),
    )
    .unwrap()
    .await?;
    Ok(())
}
