import React from "react";
import "./styles.css";
import { DAppProvider, ChainId } from "@usedapp/core";
import MyNavbar from "./components/MyNavbar";

function App() {
  return (
    <>
      <DAppProvider
        config={{
          supportedChains: [ChainId.Sepolia],
        }}
      >
        <body>
          <MyNavbar />
        </body>
      </DAppProvider>
    </>
  );
}

export default App;
