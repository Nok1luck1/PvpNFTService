use axum::{
    http::StatusCode,
    response::{IntoResponse, Response},
};

#[derive(Debug)]
pub enum Error {
    LoginFail,
}
impl IntoResponse for Error {
    fn into_response(self) -> Response {
        println!("->>{:12} - {self:?}", "INTO_RES");
        (StatusCode::INTERNAL_SERVER_ERROR, "UNHADLED_CLIENT_ERROR").into_response()
    }
}
