module fishnft::FishNFT {
    use sui::url::{Self, Url};
    use std::string;
    use sui::object::{Self, ID, UID};
    use sui::event;
    use sui::clock::{Self, Clock};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};


    /// Capability that grants an owner the right to collect profits.
    struct Owner has key { id: UID }
    

    /// An example NFT that can be minted by anybody
    struct FishNFT has key, store {
        id: UID,
        /// Name for the token
        name: string::String,

        /// Description of the token
        description: string::String,
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
        description: vector<u8>,
        ctx: &mut TxContext
    ) {
        let counter = getCounter();
        counter.currentCounter +=1;
        setCounter(counter)    
        let number: u64 = generateNumber();
        let (type,url) = typeForNumber(number);
        let nft = FishNFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
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
    public fun getFishNFTByKey(key: UID): &FishNFT {
        let nft: &FishNFT = object::get(key);
        nft
    }

   
    /// Update the `description` of `nft` to `new_description`
    public entry fun update_description(
        nft: &mut FishNFT,
        new_description: vector<u8>,
    ) {
        nft.description = string::utf8(new_description);
    }

    /// Permanently delete `nft`
    public entry fun burn(nft: FishNFT) {
        let FishNFT { id, name: _, description: _, url: _, token_type: _,weigtht:_ } = nft;
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

    /// Get the NFT's `description`
    public fun getDescription(nft: &FishNFT): &string::String {
        &nft.description
    }

    /// Get the NFT's `url`
    public fun getUrl(nft: &FishNFT): &Url {
        &nft.url
    }
    ///internal counter for displaing how much nfts get minted 
    public fun getCounter(): Counter {
        if let Some(counter) = object::get(UID("counter")) {
            counter
        } else {
            Counter { count: 0 }
        }
    }
    /// Set the value of the counter
    fun setCounter(counter: Counter) {
        object::set(UID("counter"), counter);
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


