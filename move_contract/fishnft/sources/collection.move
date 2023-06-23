// module Collection {

//     use 0x1::Vector;

//     struct Item has store {
//         id: u64,
//         name: string
//     }

//     struct Collection has store {
//         items: vector<Item>
//     }

//     public fun start_collection(): &mut Collection {
//         let collection = Collection {
//             items: Vector::empty<Item>()
//         };
//         move_to_sender(collection);
//         &mut collection
//     }

//     public fun add_item(collection: &mut Collection, id: u64, name: string) {
//         add_item_internal(collection, id, name);
//     }

//     private fun add_item_internal(collection: &mut Collection, id: u64, name: string) {
//         let item = Item {
//             id: id,
//             name: name
//         };
//         collection.items.push(item);
//     }
// }
