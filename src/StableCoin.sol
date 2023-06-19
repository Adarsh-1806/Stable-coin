//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzepplin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzepplin/contracts/access/Ownable.sol";
contract StableCoin is ERC20Burnable, Ownable{
    error StableCoin_BurnAmountExceedsBalance();
    error StableCoin_MustBeMoreThanZero();
    error StableCoin_NOtZeroAddress();
    constructor()ERC20("AdarshStableCoin","AST") {}

    function mint(address _to, uint256 _amount) public onlyOwner returns(bool){
        if(_to == address(0)){
            revert StableCoin_NOtZeroAddress();
        }
         if(_amount <= 0){
            revert StableCoin_MustBeMoreThanZero();
        }

        _mint(_to, _amount);
        return true;
    }

    function burn(uint256 _amount) override public onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if(_amount <= 0){
            revert StableCoin_MustBeMoreThanZero();
        }
        if(balance <= _amount){
            revert StableCoin_BurnAmountExceedsBalance();
        }
        super.burn(_amount);
    }
}