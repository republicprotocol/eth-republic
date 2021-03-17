pragma solidity 0.5.17;

import "@openzeppelin/contracts-ethereum-package/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20Detailed.sol";

/// @notice A test ERC20 token that can destroy itself.
contract SelfDestructingToken is ERC20, ERC20Detailed, Ownable {
    string private constant _name = "Self Destructing Token";
    string private constant _symbol = "SDT";
    uint8 private constant _decimals = 18;

    uint256 public constant INITIAL_SUPPLY =
        1000000000 * 10**uint256(_decimals);

    /// @notice The SelfDestructingToken Constructor.
    constructor() public {
        ERC20Detailed.initialize(_name, _symbol, _decimals);
        Ownable.initialize(msg.sender);
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function destruct() public onlyOwner {
        selfdestruct(msg.sender);
    }
}
