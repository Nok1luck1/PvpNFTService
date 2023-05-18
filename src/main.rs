use hex_literal::hex;
use secp256k1::SecretKey;
use serde::Deserialize;
use std::env;
use std::str::FromStr;
use std::time;
use web3::contract::{Contract, Options};
use web3::futures::StreamExt;
use web3::types::{Address, FilterBuilder, H160, U256};

use axum::extract::Query;
use axum::response::Html;
use axum::response::IntoResponse;
use axum::routing::get;
use axum::Router;
use std::net::SocketAddr;
#[tokio::main]
async fn main() {
    let routes_hi = Router::new().route("/hello", get(handler_hello));
    //start serv
    let addr = SocketAddr::from(([127, 0, 0, 1], 8080));
    println!("-->Listening on {addr}\n");
    axum::Server::bind(&addr)
        .serve(routes_hi.into_make_service())
        .await
        .unwrap();
}
#[derive(Debug, Deserialize)]
struct HelloParams {
    name: Option<String>,
}
async fn handler_hello(Query(params): Query<HelloParams>) -> impl IntoResponse {
    println!("->>{:<12}-handler_hello-{params:?}", "Handler");
    let name = params.name.as_deref().unwrap();
    Html(format!("Hello <strong>{name} world!@!</strong>"));
}
// pub fn connection() {
//     dotenv::dotenv().ok();
//     let transport = web3::transports::Http::new(
//         "https://sepolia.infura.io/v3/dd62ce7250a1497691073a36067363a8",
//     );
//     let web3s = web3::Web3::new(transport);
//     let mut accounts = web3s.eth().accounts();
//     let addresss = "0xE0bAEDe5a060E7e67e3f530fdE6A20b048C234E0";
//     let addr: Address = addresss.parse().unwrap();
//     let balance = web3s.eth().balance(addr, None);
//     print!("{:?}", balance);
//     let contractaddr: Address = "0xb23b0Cc8691838900cB51855796512c483dFC3E3"
//         .parse()
//         .unwrap();
//     let json = include_bytes!("../fishing/abis/FishNFT.json");
//     let contract = Contract::from_json(web3s.eth(), contractaddr, json).unwrap();
//     Ok(())
// }
