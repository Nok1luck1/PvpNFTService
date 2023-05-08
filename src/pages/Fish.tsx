import React from "react";
import MyNavbar from "../components/MyNavbar";

declare global {
  interface Window {
    ethereum: any;
  }
}

export default function Fish() {
  return (
    <>
      <MyNavbar />
      FISH PAGE
    </>
  );
}
