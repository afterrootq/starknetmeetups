use starknet::ContractAddress;

#[starknet::interface]
trait IEventStore<T> {
    fn attend(ref self: T) -> ByteArray;
    fn not_attend(ref self: T) -> ByteArray;
    fn get_detail(self: @T) -> (felt252, felt252, ByteArray, ByteArray);
}

#[starknet::contract]
mod ZkMeetupEvent {
    use super::IEventStore;
    use serde::Serde;
    use traits::Into;
    use traits::TryInto;
    use array::ArrayTrait;
    use zeroable::Zeroable;
    use option::OptionTrait;
    use starknet::ClassHash;
    use starknet::ContractAddress;
    use starknet::get_caller_address;
    use starknet::event::EventEmitter;
    use starknet::storage::Map;
    use starknet::storage_access::StorageBaseAddress;

    #[storage]
    struct Storage {
        name: felt252,
        eventAt: felt252,
        description: ByteArray,
        owner: ByteArray,
        attendees: Map::<ContractAddress, bool>,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        name: felt252,
        eventAt: felt252,
        description: ByteArray,
        owner: ByteArray,
    ) {
        self.name.write(name);
        self.eventAt.write(eventAt);
        self.description.write(description);
        self.owner.write(owner);
    }

    #[event]
    fn rsvpAttempt(from: ContractAddress) {}

    #[event]
    fn rsvped(from: ContractAddress) {}

    #[event]
    fn unrsvped(from: ContractAddress) {}

    #[abi(embed_v0)]
    impl IEventStoreImpl of super::IEventStore<ContractState> {
        fn attend(ref self: ContractState) -> ByteArray {
            let address = get_caller_address();
            let rsvped = self.attendees.read(address);
            rsvpAttempt(address);

            if (rsvped) {
                return "Event already rsvped";
            }

            self.attendees.write(address, true);
            rsvped(address);

            "Event rsvped successful"
        }

        fn not_attend(ref self: ContractState) -> ByteArray {
            let address = get_caller_address();
            let rsvped = self.attendees.read(address);
            rsvpAttempt(address);

            if (!rsvped) {
                return "Event already unrsvped";
            }

            self.attendees.write(address, false);
            unrsvped(address);

            "Event unrsvped successful"
        }

        fn get_detail(self: @ContractState) -> (felt252, felt252, ByteArray, ByteArray) {
            let name = self.name.read();
            let eventAt = self.eventAt.read();
            let description = self.description.read();
            let owner = self.owner.read();

            (name, eventAt, description, owner)
        }
    }
}
