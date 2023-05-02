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
    ReentrancyGuardUpgradeable
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
    struct FistInfo {
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
    mapping(uint => FishTypes) public fishByIds;
    mapping(uint256 => string) private _tokenURIs;
    mapping(uint => uint256) public requestIdToTokenId;

    event Fished(FishTypes fishType, uint256 _tokenId, address _to);

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

    // function mint(
    //     address to,
    //     uint256 id
    // ) public onlyRole(DEFAULT_ADMIN_ROLE) returns (uint) {
    //     _globalCounter.increment();
    //     uint256 newItemId = _globalCounter.current();
    //     string memory link = string(
    //         bytes.concat(bytes(baseURI), bytes(StringsUpgradeable.toString(id)))
    //     );
    //     _mint(to, _globalCounter.current());
    //     _tokenURIs[_globalCounter.current()] = link;
    //     emit Minted(id, newItemId, to, address(0), 0);
    //     return _globalCounter.current();
    // }

    function createCollectible() public returns (uint) {
        uint requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        requestIdToSender[requestId] = msg.sender;
        emit RequestedCollectible(requestId);
        return requestId;
    }

    function fulfillRandomWords(
        uint requestId,
        uint256[] memory _randomWords
    ) internal override {
        _globalCounter.increment();
        uint256 newItemId = _globalCounter.current();
        tokenID = newItemId;
        FistInfo storage fish = fishByIds[tokenID];
        // address dogOwner = requestIdToSender[requestId];
        // uint256 newItemId = tokenCounter;
        // _safeMint(dogOwner, newItemId);
        // Breed breed = Breed(_randomWords[0] % 3);
        // tokenIdToBreed[newItemId] = breed;
        // requestIdToTokenId[requestId] = newItemId;
        // tokenCounter = tokenCounter + 1;
        if (_randomWords[0] % 9) {
            fish.typeFish = FishTypes.Shark;
            fish.weight = _randomWords[1];
        } else if (_randomWords[0] % 8) {
            fish.typeFish = FishTypes.Dolphine;
            fish.weight = _randomWords[1];
        } else if (_randomWords[0] % 7) {
            fish.typeFish = FishTypes.Eel;
            fish.weight = _randomWords[1];
        } else if (_randomWords[0] % 6) {
            fish.typeFish = FishTypes.Skate;
            fish.weight = _randomWords[1];
        } else if (_randomWords[0] % 5) {
            fish.typeFish = FishTypes.Perch;
            fish.weight = _randomWords[1];
        } else if (_randomWords[0] % 4) {
            fish.typeFish = FishTypes.Piranha;
            fish.weight = _randomWords[1];
        } else if (_randomWords[0] % 3) {
            fish.typeFish = FishTypes.Anabas;
            fish.weight = _randomWords[1];
        } else if (_randomWords[0] % 2) {
            fish.typeFish = FishTypes.Flounder;
            fish.weight = _randomWords[1];
        } else if (_randomWords[0] % 1) {
            fish.typeFish = FishTypes.Anabas;
            fish.weight = _randomWords[1];
        }
        string memory link = string(
            bytes.concat(
                bytes(baseURI),
                bytes(StringsUpgradeable.toString(currentFishType))
            )
        );
        emit Fished(currentFishType, requestId, _randomWords);
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
