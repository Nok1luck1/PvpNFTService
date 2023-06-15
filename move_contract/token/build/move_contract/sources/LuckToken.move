module token::LuckToken{
    use std::option;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::object::{Self, ID, UID};
    use sui::balance::{Self, Supply, Balance};

    /// The type identifier of coin. The coin will have a type
    /// tag of kind: `Coin<package_object::mycoin::MYCOIN>`
    /// Make sure that the name of the type matches the module's name.
    struct LuckToken has drop {}
    //using for transfer
    struct Transfer has key {
        id: UID,
        balance: Balance<LuckToken>,
        to: address,
    }


    /// Module initializer is called once on module publish. A treasury
    /// cap is sent to the publisher, who then controls minting and burning
    fun init(witness: LuckToken, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(witness, 6, b"LuckToken", b"", b"", option::none(), ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx))
    }
    fun mint(amount:u64,receiver:address){

    }
}