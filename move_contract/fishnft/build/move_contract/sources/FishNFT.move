module fishnft::FishNFT {
    use sui::url::{Self, Url};
    use std::string;
    use sui::object::{Self, ID, UID};
    use sui::event;
    //use sui::clock::{Self, Clock};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};


    /// Capability that grants an owner the right to collect profits.
    struct Owner has key { id: UID }
    

    /// An example NFT that can be minted by anybody
    struct FishNFT has key, store {
        id: UID,
        /// Name for the token
        name: string::String,
        /// URL for the token
        url: Url,
        // TODO: allow custom attributes
        token_type: string::String,
        weigtht: u16, // Fixed the missing comma here
    }

    struct MintNFTEvent has copy, drop {
        // The Object ID of the NFT
        object_id: ID,
        // The creator of the NFT
        creator: address,
        // The name of the NFT
        name: string::String,
    }
    struct TransferNFTEvent has copy, drop {
        sender: address,
        receiver: address,
        typeNFT: string::String,
    }
    struct Counter{
        currentCounter:u64
    }

    

    /// Create a new devnet_nft
    public entry fun mint(
        name: vector<u8>,
        magicNumber:u64,
        ctx: &mut TxContext
    ) {
          
        let number: u64 = generateNumber();
        let (type,url) = typeForNumber(number + magicNumber);
        let nft = FishNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            url: url::new_unsafe_from_bytes(url),
            token_type: string::utf8(type),
            weigtht: (number as u16),
        };

        //let sender = tx_context::sender(ctx);
        event::emit(MintNFTEvent {
            object_id: object::uid_to_inner(&nft.id),
            creator: tx_context::sender(ctx),
            name: nft.name,
        });
        transfer::public_transfer(nft, tx_context::sender(ctx));
    }

    fun generateNumber(): u64 {
        let numberGiv = (1103512332 + 12345) % (2 ^ 31);
        numberGiv
    }
    fun typeForNumber(number:u64): (vector<u8>,vector<u8>){
       if (number % 9 ==0){
        let type:vector<u8> = b"Eel";
        let url:vector<u8> = b"https://bafybeihvdqo4h52ckg2u55tjz3tthbirpntfjw2smjspqmjt5iel4af5za.ipfs.nftstorage.link/0.jpg";
        (type,url)
       } else if (number % 8 ==0) {
        let type:vector<u8> = b"Skate";
        let url:vector<u8> = b"https://bafybeihvdqo4h52ckg2u55tjz3tthbirpntfjw2smjspqmjt5iel4af5za.ipfs.nftstorage.link/1.jpg";
        (type,url)
       }
       else if (number % 7 ==0) {
        let type:vector<u8> = b"Anabas";
        let url:vector<u8> = b"https://bafybeihvdqo4h52ckg2u55tjz3tthbirpntfjw2smjspqmjt5iel4af5za.ipfs.nftstorage.link/2.jpg";
        (type,url)
       }
       else if (number % 6 ==0) {
        let type:vector<u8> = b"Shark";
        let url:vector<u8> = b"https://bafybeihvdqo4h52ckg2u55tjz3tthbirpntfjw2smjspqmjt5iel4af5za.ipfs.nftstorage.link/3.jpg";
        (type,url)
       }
       else if (number % 5 ==0) {
        let type:vector<u8> = b"Perch";
        let url:vector<u8> = b"https://bafybeihvdqo4h52ckg2u55tjz3tthbirpntfjw2smjspqmjt5iel4af5za.ipfs.nftstorage.link/4.jpg";
       (type,url)
       }
       else if (number % 4 ==0) {
        let type:vector<u8> = b"Piranha";
        let url:vector<u8> = b"https://bafybeihvdqo4h52ckg2u55tjz3tthbirpntfjw2smjspqmjt5iel4af5za.ipfs.nftstorage.link/5.jpg";
        (type,url)
       }
       else if (number % 3 ==0) {
        let type:vector<u8> = b"Dolphine";
        let url:vector<u8> = b"https://bafybeihvdqo4h52ckg2u55tjz3tthbirpntfjw2smjspqmjt5iel4af5za.ipfs.nftstorage.link/6.jpg";
       (type,url)
       }
       else if (number % 3 ==0) {
        let type:vector<u8> = b"Flounder";
        let url:vector<u8> = b"https://bafybeihvdqo4h52ckg2u55tjz3tthbirpntfjw2smjspqmjt5iel4af5za.ipfs.nftstorage.link/7.jpg";
        (type,url)
       }else {
        let type:vector<u8> = b"Laskir";
        let url:vector<u8> = b"https://bafybeihvdqo4h52ckg2u55tjz3tthbirpntfjw2smjspqmjt5iel4af5za.ipfs.nftstorage.link/8.jpg";
        (type,url)
       }
    }
     /// Read a FishNFT instance by key
    // public fun getFishNFTByKey(key: UID): &FishNFT {
    //     &borrow_global<FishNFT>(key)
    // }

    /// Permanently delete `nft`
    public entry fun burn(nft: FishNFT) {
        let FishNFT { id, name: _,  url: _, token_type: _,weigtht:_ } = nft;
        object::delete(id);
    }

    /// Get the NFT's `name`
    public fun getName(nft: &FishNFT): &string::String {
        &nft.name
    }

    /// Get the NFT's `type`
    public fun getType(nft: &FishNFT): &string::String {
        &nft.token_type
    }


    /// Get the NFT's `url`
    public fun getUrl(nft: &FishNFT): &Url {
        &nft.url
    }
    

   public entry fun transfer(
    nft: FishNFT,
    recipient: address,
    ctx: &mut TxContext
) {
    event::emit(TransferNFTEvent {
        sender: tx_context::sender(ctx),
        receiver: recipient,
        typeNFT: nft.token_type,
    });
    transfer::public_transfer(nft, recipient);
}

}
#[test_only]
module fishnft::FishNFTTest{
    use fishnft::FishNFT::{Self,FishNFT};
    use sui::test_scenario as ts;
    use sui::transfer;
    use std::debug;

    #[test]
    fun mint_transfer(){
        let addr1 = @0xA;
        let addr2 = @0xB;
        let scenario = ts::begin(addr1);
        let scenario2 = ts::begin(addr2);
        {
            FishNFT::mint(b"Zalupa2",123, ts::ctx(&mut scenario2))
        };
        {
            FishNFT::mint(b"Zalupa" ,23523, ts::ctx(&mut scenario))
        };
        ts::next_tx(&mut scenario,addr1);
        {   
            let nft = ts::take_from_sender<FishNFT>(&mut scenario);
            debug::print(&nft);
            transfer::public_transfer(nft,addr2);
            
        };
        ts::next_tx(&mut scenario2,addr2);
        {   
            let nft1 = ts::take_from_sender<FishNFT>(&mut scenario2);
            debug::print(&nft1);
            transfer::public_transfer(nft1,addr1);
            
        };
        
        ts::end(scenario);
        ts::end(scenario2);
    }
}


