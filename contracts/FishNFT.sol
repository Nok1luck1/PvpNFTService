//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/StringsUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract FishNFT is
    ERC721Upgradeable,
    ERC721BurnableUpgradeable,
    UUPSUpgradeable,
    AccessControlUpgradeable,
    PausableUpgradeable,
    ReentrancyGuardUpgradeable,
    VRFConsumerBaseV2
{
    using StringsUpgradeable for uint256;
    using CountersUpgradeable for CountersUpgradeable.Counter;

    CountersUpgradeable.Counter public _globalCounter;
    enum FishTypes {
        Eel, //
        Skate, //
        Shark, //
        Anabas, //
        Perch, //
        Piranha, //
        Dolphine, //
        Flounder //
    }
    struct FishInfo {
        uint weight;
        FishTypes typeFish;
    }
    uint16 requestConfirmations;
    address private signer;
    bytes32 internal keyHash;
    uint32 callbackGasLimit;
    uint32 numWords;
    uint64 s_subscriptionId;
    uint256 public tokenCounter;
    VRFCoordinatorV2Interface public COORDINATOR;

    string public baseURI;

    mapping(uint => address) public requestIdToSender;
    mapping(uint => FishInfo) public fishByIds;
    mapping(uint256 => string) private _tokenURIs;
    mapping(uint => uint256) public requestIdToTokenId;

    event Fished(FishTypes fishType, uint256 _tokenId, address _to);
    event throwBait(uint requestID);

    function initialize(
        string calldata name_,
        string calldata symbol_,
        string memory _baseURII,
        uint64 _subscriptionId,
        address _VRFCoordinator,
        bytes32 _keyhash
    ) public initializer {
        __ERC721_init(name_, symbol_);
        __AccessControl_init();
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        callbackGasLimit = 300000;
        numWords = 2;
        requestConfirmations = 3;
        __ReentrancyGuard_init();
        __UUPSUpgradeable_init();
        __Pausable_init();
        VRFConsumerBaseV2(_VRFCoordinator);
        COORDINATOR = VRFCoordinatorV2Interface(_VRFCoordinator);
        baseURI = _baseURII;
    }

    receive() external payable {}

    fallback() external payable {}

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
            fishy.typeFish = FishTypes.Anabas;
            fishy.weight = _randomWords[1];
        }
        string memory link = string(
            bytes.concat(
                bytes(baseURI),
                bytes(StringsUpgradeable.toString(uint(fishy.typeFish)))
            )
        );
        _safeMint(receiver, newItemId);
        _tokenURIs[_globalCounter.current()] = link;
        emit Fished(fishy.typeFish, requestId, receiver);
    }

    function setPause(
        bool _newPauseState
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _newPauseState ? _pause() : _unpause();
    }

    function supportsInterface(
        bytes4 interfaceId
    )
        public
        view
        override(ERC721Upgradeable, AccessControlUpgradeable)
        returns (bool)
    {}

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyRole(DEFAULT_ADMIN_ROLE) {}
}
