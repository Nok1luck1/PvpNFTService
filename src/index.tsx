import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";
import reportWebVitals from "./reportWebVitals";
import { DAppProvider, ChainId } from "@usedapp/core";
import { HashRouter as Router, Routes, Route } from "react-router-dom";
import FishingEl from "./pages/Fishing";
import FishInfo from "./pages/FishInfo";
import MyFish from "./pages/MyFish";
import MyEquipment from "./pages/MyEquipment";
import Store from "./pages/Store";
import { ApolloClient, ApolloProvider, InMemoryCache } from "@apollo/client";

const client = new ApolloClient({
  uri: "https://api.studio.thegraph.com/query/33865/fishing/v0.0.1",
  cache: new InMemoryCache(),
});

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);
root.render(
  <ApolloProvider client={client}>
    <DAppProvider
      config={{
        supportedChains: [ChainId.Sepolia],
      }}
    >
      <Router>
        <Routes>
          <Route path="/" element={<App />} />
          <Route path="/Fishing" element={<FishingEl />} />
          <Route path="/FishInfo" element={<FishInfo />} />
          <Route path="/MyFish" element={<MyFish />} />
          <Route path="/MyEquipment" element={<MyEquipment />} />
          <Route path="/Store" element={<Store />} />
        </Routes>
      </Router>
    </DAppProvider>
  </ApolloProvider>
);

reportWebVitals();
