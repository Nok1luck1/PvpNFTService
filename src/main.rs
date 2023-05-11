use postgres::{Client, Error, NoTls};
use std::{
    fs,
    io::{prelude::*, BufReader},
    net::{TcpListener, TcpStream},
};
#[derive(Debug)]
struct User {
    username: String,
    email: String,
    address: String,
}

fn main() {
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();
    let db = connectDB();
    let user = createuser(
        String::from("Nick"),
        String::from("kolambo4ka@gmail.com"),
        String::from("0x3f4F5d9971c265a7485540207023EA4B68Af6dc6"),
    );
    println!("user is {:?}", &user);
    for stream in listener.incoming() {
        let stream = stream.unwrap();

        println!("Connection established!");
    }
}
fn createuser(name: String, mail: String, addressWallet: String) -> User {
    User {
        username: name,
        email: mail,
        address: addressWallet,
    }
}

fn handle_connection(mut stream: TcpStream) {
    let buf_reader = BufReader::new(&mut stream);
    let http_request: Vec<_> = buf_reader
        .lines()
        .map(|result| result.unwrap())
        .take_while(|line| !line.is_empty())
        .collect();

    let status_line = "HTTP/1.1 200 OK";
    let contents = fs::read_to_string("../index.html").unwrap();
    let length = contents.len();

    let response = format!("{status_line}\r\nContent-Length: {length}\r\n\r\n{contents}");

    stream.write_all(response.as_bytes()).unwrap();
}
fn connectDB() -> Result<(), Error> {
    let mut client = Client::connect(
        "postgresql://dboperator:operatorpass123@localhost:5243/postgres",
        NoTls,
    )?;
    Ok(())
}
