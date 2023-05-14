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
    uint32 callbackGasLimit;
    uint32 numWords;
    uint64 s_subscriptionId;
    uint256 public tokenCounter;
    VRFCoordinatorV2Interface public COORDINATOR;

    string public baseURI;

    mapping(uint => address) public requestIdToSender;

    mapping(uint256 => string) private _tokenURIs;
    mapping(uint => FishInfo) public fishByIds;
    mapping(uint => uint256) public requestIdToTokenId;

    event Fished(FishTypes fishType, uint256 _tokenId, address _to);
    event Minted(address receiver, uint fishID);
    event throwBait(uint requestID);

    constructor(
        uint64 _subscriptionId,
        address _VRFCoordinator,
        bytes32 _keyhash
    ) VRFConsumerBaseV2(_VRFCoordinator) ERC721("ZXalupa", "ZLP") {
        COORDINATOR = VRFCoordinatorV2Interface(_VRFCoordinator);
        baseURI = "Https.192.168.01.01/";
        callbackGasLimit = 300000;
        numWords = 2;
        requestConfirmations = 3;
        s_subscriptionId = _subscriptionId;
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
        _globalCounter.increment();
        uint256 newItemId = _globalCounter.current();
        address receiver = requestIdToSender[requestId];
        FishInfo storage fishy = fishByIds[newItemId];
        if (_randomWords[0] % 9 == 0) {
            fishy.typeFish = FishTypes.Shark;
            fishy.weight = _randomWords[1];
        } else if (_randomWords[0] % 8 == 0) {
            fishy.typeFish = FishTypes.Dolphine;
            fishy.weight = _randomWords[1];
        } else if (_randomWords[0] % 7 == 0) {
            fishy.typeFish = FishTypes.Eel;
            fishy.weight = _randomWords[1];
        } else if (_randomWords[0] % 6 == 0) {
            fishy.typeFish = FishTypes.Skate;
            fishy.weight = _randomWords[1];
        } else if (_randomWords[0] % 5 == 0) {
            fishy.typeFish = FishTypes.Perch;
            fishy.weight = _randomWords[1];
        } else if (_randomWords[0] % 4 == 0) {
            fishy.typeFish = FishTypes.Piranha;
            fishy.weight = _randomWords[1];
        } else if (_randomWords[0] % 3 == 0) {
            fishy.typeFish = FishTypes.Anabas;
            fishy.weight = _randomWords[1];
        } else if (_randomWords[0] % 2 == 0) {
            fishy.typeFish = FishTypes.Flounder;
            fishy.weight = _randomWords[1];
        } else if (_randomWords[0] % 1 == 0) {
            fishy.typeFish = FishTypes.Laskir;
            fishy.weight = _randomWords[1];
        }
        string memory link = string(
            bytes.concat(
                bytes(baseURI),
                bytes(Strings.toString(uint(fishy.typeFish)))
            )
        );
        _safeMint(receiver, newItemId);
        _tokenURIs[_globalCounter.current()] = link;
        emit Fished(fishy.typeFish, requestId, receiver);
    }

    function mint(address to, uint typeF) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _globalCounter.increment();
        uint256 newItemId = _globalCounter.current();
        string memory link = string(
            bytes.concat(bytes(baseURI), bytes(Strings.toString(typeF)))
        );
        _safeMint(to, newItemId);
        _tokenURIs[_globalCounter.current()] = link;
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
