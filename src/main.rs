use serde::Deserialize;

pub use self::error::{Error, Result};
use axum::extract::{Path, Query};
use axum::response::Html;
use axum::response::IntoResponse;
use axum::routing::{get, get_service};
use axum::Router;
use std::net::SocketAddr;
use tower_http::services::ServeDir;
mod contract_connect;
mod error;

#[tokio::main]
async fn main() {
    let routes_all = Router::new()
        .merge(routes_Hello())
        .fallback_service(routes_static());

    let addr = SocketAddr::from(([127, 0, 0, 1], 8080));
    println!("-->Listening on {addr}\n");
    axum::Server::bind(&addr)
        .serve(routes_all.into_make_service())
        .await
        .unwrap();
}
fn routes_static() -> Router {
    Router::new().nest_service("/", get_service(ServeDir::new("./")))
}
fn routes_Hello() -> Router {
    Router::new()
        .route("/hello", get(handler_hello))
        .route("/hello2/:name", get(handler_hello2))
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
async fn handler_hello2(Path(name): Path<String>) -> impl IntoResponse {
    println!("->>{:<12}-handler_hello-{name:?}", "Handler");

    Html(format!("Hello <strong>{name} world!@!</strong>"));
}
