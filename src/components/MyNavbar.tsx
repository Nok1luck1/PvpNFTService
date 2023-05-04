import React from "react";
import { Link } from "react-router-dom";
import { useEthers } from "@usedapp/core";
import logo from "../images/fish-logo.png";

export default function MyNavbar() {
  const { account, activateBrowserWallet, deactivate } = useEthers();
  const isConnected = account !== undefined;
  return (
    <>
      <nav className="navbar">
        <Link to="/">
          <img className="logo" src={logo} alt="fish-logo" />
        </Link>
        <ul className="nav-ul">
          <Link to="/Fishing">
            <li>fishing</li>
          </Link>
          <Link to="/Fish">
            <li>fish</li>
          </Link>
          <Link to="/Equipment">
            <li>equipment</li>
          </Link>
        </ul>
        {isConnected ? (
          <button className="btn" onClick={deactivate}>
            disconnect
          </button>
        ) : (
          <button className="btn" onClick={() => activateBrowserWallet()}>
            connect
          </button>
        )}
      </nav>
    </>
  );
}
