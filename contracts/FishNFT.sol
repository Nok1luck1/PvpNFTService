//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

// import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract FishNFT is
    ERC721,
    ERC721Burnable,
    AccessControl,
    Pausable,
    ReentrancyGuard,
    VRFConsumerBaseV2
{
    using Strings for uint256;
    using Counters for Counters.Counter;

    Counters.Counter public _globalCounter;
    enum FishTypes {
        Eel, //
        Skate, //
        Shark, //
        Anabas, //
        Perch, //
        Piranha, //
        Dolphine, //
        Flounder, //
        Laskir
    }
    struct FishInfo {
        uint weight;
        FishTypes typeFish;
    }
    uint16 requestConfirmations;
    bytes32 internal keyHash;
    uint32 public callbackGasLimit;
    uint32 public numWords;
    uint64 public s_subscriptionId;
    uint256 public tokenCounter;
    VRFCoordinatorV2Interface public COORDINATOR;

    string public baseURI;

    mapping(uint => address) public requestIdToSender;

    mapping(uint256 => string) private _tokenURIs;
    mapping(uint => FishInfo) public fishByIds;
    mapping(uint => uint256) public requestIdToTokenId;

    event Fished(FishTypes fishType, uint256 _requestId, address _to);
    event Minted(address receiver, uint fishID);
    event throwBait(uint requestID);

    constructor()
        VRFConsumerBaseV2(0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625)
        ERC721("ZXalupa", "ZLP")
    {
        COORDINATOR = VRFCoordinatorV2Interface(
            0x8103B0A8A00be2DDC778e6e7eaa21791Cd364625
        );
        baseURI = "https://bafybeihvdqo4h52ckg2u55tjz3tthbirpntfjw2smjspqmjt5iel4af5za.ipfs.nftstorage.link/";
        callbackGasLimit = 300000;
        numWords = 2;
        keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c;
        requestConfirmations = 3;
        s_subscriptionId = 2148;
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    receive() external payable {}

    fallback() external payable {}

    function setNewSubcription(
        uint64 newsubcription
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        s_subscriptionId = newsubcription;
    }

    function newKeyHash(
        bytes32 newkeyHash
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        keyHash = newkeyHash;
    }

    function tokenURI(
        uint tokenID
    ) public view override returns (string memory) {
        return _tokenURIs[tokenID];
    }

    function setBaseURI(
        string memory newBaseURI
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {
        baseURI = newBaseURI;
    }

    function throwABait() public returns (uint) {
        uint requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        requestIdToSender[requestId] = msg.sender;
        emit throwBait(requestId);
        return requestId;
    }

    function fulfillRandomWords(
        uint requestId,
        uint256[] memory _randomWords
    ) internal override {
        uint256 newItemId = _globalCounter.current();
        address receiver = requestIdToSender[requestId];
        FishInfo storage fishy = fishByIds[newItemId];
        if (_randomWords[0] % 9 == 0) {
            fishy.typeFish = FishTypes.Shark;
            fishy.weight = uint16(_randomWords[1]);
        } else if (_randomWords[0] % 8 == 0) {
            fishy.typeFish = FishTypes.Dolphine;
            fishy.weight = uint16(_randomWords[1]);
        } else if (_randomWords[0] % 7 == 0) {
            fishy.typeFish = FishTypes.Eel;
            fishy.weight = uint16(_randomWords[1]);
        } else if (_randomWords[0] % 6 == 0) {
            fishy.typeFish = FishTypes.Skate;
            fishy.weight = uint16(_randomWords[1]);
        } else if (_randomWords[0] % 5 == 0) {
            fishy.typeFish = FishTypes.Perch;
            fishy.weight = uint16(_randomWords[1]);
        } else if (_randomWords[0] % 4 == 0) {
            fishy.typeFish = FishTypes.Piranha;
            fishy.weight = uint16(_randomWords[1]);
        } else if (_randomWords[0] % 3 == 0) {
            fishy.typeFish = FishTypes.Anabas;
            fishy.weight = uint16(_randomWords[1]);
        } else if (_randomWords[0] % 2 == 0) {
            fishy.typeFish = FishTypes.Flounder;
            fishy.weight = uint16(_randomWords[1]);
        } else if (_randomWords[0] % 1 == 0) {
            fishy.typeFish = FishTypes.Laskir;
            fishy.weight = uint16(_randomWords[1]);
        }
        string memory link = string(
            bytes.concat(
                bytes(baseURI),
                bytes(Strings.toString(uint(fishy.typeFish))),
                ".jpg"
            )
        );
        _safeMint(receiver, newItemId);
        _tokenURIs[_globalCounter.current()] = link;
        requestIdToTokenId[requestId] = newItemId;
        _globalCounter.increment();
        tokenCounter++;
        emit Fished(fishy.typeFish, requestId, receiver);
    }

    function mint(address to, uint typeF) public onlyRole(DEFAULT_ADMIN_ROLE) {
        uint256 newItemId = _globalCounter.current();
        string memory link = string(
            bytes.concat(bytes(baseURI), bytes(Strings.toString(typeF)), ".jpg")
        );
        _safeMint(to, newItemId);
        _tokenURIs[_globalCounter.current()] = link;
        tokenCounter++;
        _globalCounter.increment();
        emit Minted(to, newItemId);
    }

    function setPause(
        bool _newPauseState
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _newPauseState ? _pause() : _unpause();
    }

    function emergencyWithdraw(
        address too
    ) public onlyRole(DEFAULT_ADMIN_ROLE) {}

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, AccessControl) returns (bool) {}
}
