/**
 *Submitted for verification at Etherscan.io on 2017-11-28
*/

pragma solidity ^0.4.17;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
    address public owner;

    /**
      * @dev The Ownable constructor sets the original `owner` of the contract to the sender
      * account.
      */
    function Ownable() public {
        owner = msg.sender;
    }

    /**
      * @dev Throws if called by any account other than the owner.
      */
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    /**
    * @dev Allows the current owner to transfer control of the contract to a newOwner.
    * @param newOwner The address to transfer ownership to.
    */
    function transferOwnership(address newOwner) public onlyOwner {
        if (newOwner != address(0)) {
            owner = newOwner;
        }
    }

}

/**
 * @title ERC20Basic
 * @dev Simpler version of ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20Basic {
    uint public _totalSupply;
    function totalSupply() public constant returns (uint);
    function balanceOf(address who) public constant returns (uint);
    function transfer(address to, uint value) public;
    event Transfer(address indexed from, address indexed to, uint value);
}

/**
 * @title ERC20 interface
 * @dev see https://github.com/ethereum/EIPs/issues/20
 */
contract ERC20 is ERC20Basic {
    function allowance(address owner, address spender) public constant returns (uint);
    function transferFrom(address from, address to, uint value) public;
    function approve(address spender, uint value) public;
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract BatchTransfer {
    using SafeMath for uint256;

    function transferTRX(address[] memory _tos, uint256[] memory _values) payable public returns(bool) {
        require(_tos.length == _values.length, "_tos.length and _values.length not equal");
        require(msg.value >= _sumOf(_values), "not enough");     
        for (uint i = 0; i < _tos.length; i++) {
            address to = _tos[i];
            uint value = _values[i];
            to.transfer(value);
        }
        return true;
    }

    function transferTRC20(ERC20 _token, address[] memory _tos, uint256[] memory _values) public returns(bool) {
        require(_tos.length == _values.length, "_tos.length and _values.length not equal");
        require(_token.balanceOf(msg.sender) >= _sumOf(_values), "not enough");     
        for (uint i = 0; i < _tos.length; i++) {
            _token.transferFrom(msg.sender, _tos[i], _values[i]);
        }
        return true;
    }

    function _sumOf(uint256[] memory _values) private view returns(uint256) {
        uint256 sum = 0;
        for (uint i = 0; i < _values.length; i++) {
            sum = sum.add( _values[i]);
        }
        return sum;
    }
}