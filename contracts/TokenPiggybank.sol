pragma solidity ^0.4.2;

import "./tokens/MZToken.sol";

contract TokenPiggybank {
    uint256 public constant DURATION = 5 minutes;

    MZToken private token;
    mapping(address => uint256) public balances;
    mapping(address => uint256) public creations;

    function TokenPiggybank(address tokenAddress) public {
        token = MZToken(tokenAddress);
    }

    function deposit(uint256 amount) public {
        require(token.transferFrom(msg.sender, address(this), amount));
        if (creations[msg.sender] == 0) {
            creations[msg.sender] = block.timestamp;
        }
        balances[msg.sender] += amount;
    }

    function romperTime(address owner) public view returns (uint256) {
        return creations[owner] + DURATION;
    }

    function romper() public returns (bool) {
        if (now >= romperTime(msg.sender)) {
            token.transfer(msg.sender, balances[msg.sender]);
            balances[msg.sender] = 0;
            return true;
        }
        return false;
    }
}
