use solana_program::{
    account_info::{next_account_info, AccountInfo},
    entrypoint,
    entrypoint::ProgramResult,
    msg,
    program_error::ProgramError,
    program_pack::{IsInitialized, Pack},
    pubkey::Pubkey,
    system_instruction::create_account,
    sysvar::{rent::Rent, Sysvar},
};
use std::str::FromStr;

// Define the state struct for the NFT
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Object {
    pub owner: Pubkey,
    pub data: Vec<u8>,
}

#[derive(Clone, Debug, Default, PartialEq)]
pub struct NftState {
    pub is_initialized: bool,
    pub objects: Vec<Object>,
}

// Define the instruction enum
#[derive(Clone, Debug, PartialEq)]
pub enum NftInstruction {
    InitNft {
        objects: Vec<Object>,
    },
    TransferObject {
        object_index: u32,
        new_owner: Pubkey,
    },
}

// Define the error enum
#[derive(Debug, PartialEq)]
pub enum NftError {
    InvalidInstruction,
    NotNftOwner,
    InvalidObjectIndex,
    NotRentSysvar,
    AccountNotRentExempt,
}

// Define the entry point for the program
entrypoint!(process_instruction);

// Define the process instruction function
fn process_instruction(
    program_id: &Pubkey,
    accounts: &[AccountInfo],
    instruction_data: &[u8],
) -> ProgramResult {
    // Match the instruction data to the appropriate instruction
    let instruction = NftInstruction::unpack(instruction_data)?;
    match instruction {
        // Initialize the NFT
        NftInstruction::InitNft { objects } => {
            msg!("Instruction: InitNft");
            let accounts_iter = &mut accounts.iter();
            let nft_account = next_account_info(accounts_iter)?;
            let owner_account = next_account_info(accounts_iter)?;
            let mut nft_state = NftState::unpack_unchecked(&nft_account.data.borrow())?;
            if nft_state.is_initialized {
                return Err(ProgramError::AccountAlreadyInitialized);
            }
            nft_state.is_initialized = true;
            nft_state.objects = objects;
            NftState::pack(nft_state, &mut nft_account.data.borrow_mut())?;
            Ok(())
        }
        // Transfer an object
        NftInstruction::TransferObject {
            object_index,
            new_owner,
        } => {
            msg!("Instruction: TransferObject");
            let accounts_iter = &mut accounts.iter();
            let nft_account = next_account_info(accounts_iter)?;
            let nft_owner_account = next_account_info(accounts_iter)?;
            let rent_sysvar_account = next_account_info(accounts_iter)?;
            let system_program_info = next_account_info(accounts_iter)?;
            let object_account_info = next_account_info(accounts_iter)?;
            let object_owner_account = next_account_info(accounts_iter)?;
            let mut nft_state = NftState::unpack_unchecked(&nft_account.data.borrow())?;
            if nft_state.objects.len() <= object_index as usize {
                return Err(NftError::InvalidObjectIndex.into());
            }
            let mut object = nft_state.objects[object_index as usize].clone();
            if object.owner != *nft_owner_account.key {
                return Err(NftError::NotNftOwner.into());
            }
            object.owner = new_owner;
            nft_state.objects[object_index as usize] = object.clone();
            NftState::pack(nft_state, &mut nft_account.data.borrow_mut())?;
            Ok(())
        }
    }
}
