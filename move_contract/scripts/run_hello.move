
module Storage{
    struct Box<T>{
        value:T
    }
    public fun create_box(value:T):Box<T>{
        Box<T>{value}
    }
    public fun value<T:copy>(box:&Box<T>):T{
        *&box.value
    }
}
script{
    use {{sender}}::Storage;
    use 0x1::Debug;

    fun main(){
        let bool_box = Storage::create_box<bool>(true);
        let bool_val = Storage::value(&bool_box);
        assert(bool_val,0);
        let u64_box = Storage::create_box<u64>(10000);
        let _ = Storage::value(&u64_box);

        let u64_boxinbox = Storage::create_box<Storage::Box<u64>>(u64_box);

        let value:u64 = Storage::value<u64>(&Storage::value<Storage::Box<u64>>(&u64_boxinbox));
        Debug::print<u64>(&value);
    }
}