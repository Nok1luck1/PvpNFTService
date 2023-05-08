import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import reportWebVitals from "./reportWebVitals";
import { DAppProvider, ChainId } from "@usedapp/core";
import { HashRouter as Router, Routes, Route } from "react-router-dom";
import FishingEl from "./pages/Fishing";
import Fish from "./pages/Fish";
import Equipment from "./pages/Equipment";

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);
root.render(
  <DAppProvider
    config={{
      supportedChains: [ChainId.Sepolia],
    }}
  >
    <Router>
      <Routes>
        <Route path="/" element={<App />} />
        <Route path="/Fishing" element={<FishingEl />} />
        <Route path="/Fish" element={<Fish />} />
        <Route path="/Equipment" element={<Equipment />} />
      </Routes>
    </Router>
  </DAppProvider>
);

reportWebVitals();
