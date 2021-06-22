import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

// import drizzle functions and contract artifact
import { Drizzle, generateStore } from "@drizzle/store";
import HCoin from "./contracts/HCoin.json";
import admined from "./contracts/admined.json";

// let drizzle know what contracts we want and how to access our test blockchain
const options = {
  contracts: [HCoin],
  web3: {
    fallback: {
      type: "ws",
      url: "ws://127.0.0.1:8545",
    },
  },
};

// setup the drizzle store and drizzle
const drizzle = new Drizzle(options);

ReactDOM.render(<App drizzle={drizzle} />, document.getElementById('root'));