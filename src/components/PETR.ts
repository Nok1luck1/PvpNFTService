import { ethers } from "ethers"
import abi from "./abi"
import axios from "axios"

declare global {
  interface Window {
    ethereum: any
  }
}

const contractAddress = "0x4490310Be14F77781f009049182D5bc8fA8bE2bD"

export function getContract() {
    const provider = new ethers.providers.Web3Provider(window.ethereum)
    const signer = provider.getSigner()
    const contract = new ethers.Contract(contractAddress, abi, signer)
    return { contract, provider, signer }
  }