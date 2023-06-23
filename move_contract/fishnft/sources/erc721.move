// module erc721 {

//     use sui::address::{Address, address_equal};
//     use sui::vector::Vector;

//     // NFT Token

//     struct NFTToken {
//         token_id: u64,
//         owner: Address,
//     }

//     struct NFT {
//         tokens: Vector<NFTToken>,
//         token_count: u64,
//         token_id_counter: u64,
//     }

//     // Events

//     struct TransferEvent {
//         from: Address,
//         to: Address,
//         token_id: u64,
//     }

//     struct ApprovalEvent {
//         owner: Address,
//         approved: Address,
//         token_id: u64,
//     }

//     struct ApprovalForAllEvent {
//         owner: Address,
//         operator: Address,
//         approved: bool,
//     }

//     // Public Functions

//     // public fun initialize() {
//     //     NFT {
//     //         tokens: Vector<NFTToken>::new(),
//     //         token_count: 0,
//     //         token_id_counter: 1,
//     //     };
//     // }

//     public fun mint(to: &Address) {
//         let nft = NFT::get();
//         let token = NFTToken {
//             token_id: nft.token_id_counter,
//             owner: *to,
//         };
//         nft.tokens.push_back(token);
//         nft.token_count += 1;
//         nft.token_id_counter += 1;
//         NFT::set(nft);

//         emit TransferEvent {
//             from: 0x0,
//             to: *to,
//             token_id: token.token_id,
//         };
//     }

//     public fun transfer(from: &Address, to: &Address, token_id: u64) {
//         assert(address_equal(from, to) == false, "Transfer to self is not allowed");

//         let nft = NFT::get();
//         let token = get_token(&nft, token_id);
//         assert(address_equal(&token.owner, from), "Sender does not own the token");

//         token.owner = *to;
//         set_token(&nft, token);

//         emit TransferEvent {
//             from: *from,
//             to: *to,
//             token_id: token_id,
//         };
//     }

//     public fun approve(from: &Address, to: &Address, token_id: u64) {
//         let nft = NFT::get();
//         let token = get_token(&nft, token_id);
//         assert(address_equal(from, &token.owner), "Sender does not own the token");

//         token.approved = *to;
//         set_token(&nft, token);

//         emit ApprovalEvent {
//             owner: *from,
//             approved: *to,
//             token_id: token_id,
//         };
//     }

//     public fun set_approval_for_all(owner: &Address, operator: &Address, approved: bool) {
//         assert(address_equal(owner, operator) == false, "Setting approval for self is not allowed");

//         let nft = NFT::get();
//         let exists = has_approval_for_all(&nft, owner, operator);

//         if approved {
//             if exists == false {
//                 nft.approval_for_all.push_back((owner, operator));
//                 NFT::set(nft);
//             }
//         } else {
//             if exists {
//                 remove_approval_for_all(&nft, owner, operator);
//                 NFT::set(nft);
//             }
//         }

//         emit ApprovalForAllEvent {
//             owner: *owner,
//             operator: *operator,
//             approved: approved,
//         };
//     }

//     // Internal Functions

//     fun get_token(nft: &NFT, token_id: u64): &mut NFTToken {
//         let tokens = &mut nft.tokens;
//         let index = tokens.iter().position(|token| token.token_id == token_id);
//         assert(index.is_some(), "Token does not exist");
//         &mut tokens[index.unwrap()]
//     }

//     fun set_token(nft: &NFT, token: NFTToken) {
//         let tokens = &mut nft.tokens;
//         let index = tokens.iter().position(|t| t.token_id == token.token_id).unwrap();
//         tokens[index] = token;
//         NFT::set(nft);
//     }

//     fun has_approval_for_all(nft: &NFT, owner: &Address, operator: &Address): bool {
//         nft.approval_for_all.iter().any(|(o, op)| address_equal(o, owner) && address_equal(op, operator))
//     }

//     fun remove_approval_for_all(nft: &NFT, owner: &Address, operator: &Address) {
//         let index = nft.approval_for_all.iter().position(|(o, op)| address_equal(o, owner) && address_equal(op, operator));
//         assert(index.is_some(), "Approval does not exist");
//         nft.approval_for_all.remove(index.unwrap());
//     }
// }
