use hex_literal::hex;
use secp256k1::SecretKey;
use std::env;
use std::str::FromStr;
use std::time;
use web3::contract::{Contract, Options};
use web3::futures::StreamExt;
use web3::types::{Address, FilterBuilder, H160, U256};

#[tokio::main]
async fn connection() -> web3::Result<()> {
    dotenv::dotenv().ok();
    let transport = web3::transports::Http::new(
        "https://sepolia.infura.io/v3/dd62ce7250a1497691073a36067363a8",
    );
    let web3s = web3::Web3::new(transport);
    let mut accounts = web3s.eth().accounts();
    let addresss = "0xE0bAEDe5a060E7e67e3f530fdE6A20b048C234E0";
    let addr: Address = addresss.parse().unwrap();
    let balance = web3s.eth().balance(addr, None);
    print!("{:?}", balance);
    let contractaddr: Address = "0xb23b0Cc8691838900cB51855796512c483dFC3E3"
        .parse()
        .unwrap();
    let json = include_bytes!("../fishing/abis/FishNFT.json");
    let contract = Contract::from_json(web3s.eth(), contractaddr, json).unwrap();
    Ok(())
}
