// SPDX-Licence-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ElectionToken is ERC20 {
    using SafeMath for uint256;
    // uint8 public constant decimals = 18;

    // mapping(address => uint256) balances;
    // mapping(address => mapping (address => uint256)) allowed;

    // uint256 totalSupply;

    constructor(uint256 initialSupply) ERC20("ElectionToken", "ELCT") {
        _mint(msg.sender, initialSupply);
    }

    // function totalSupply() public override view returns (uint256) {
    //     return totalSupply_;
    // }

    // function balanceOf(address tokenOwner) public override view returns (uint256) {
    //     return balances[tokenOwner];
    // }
}
