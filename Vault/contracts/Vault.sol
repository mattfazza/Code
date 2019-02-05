pragma solidity ^0.4.15;


contract Vault {

    address public mainAddr1; //all its gonna do is take out the money when you want it
    address public recoveryAddr; //switch out the first address when you need to
    address public deadhandAddr; //will be used to destroy the addresses and send the money to another address

    uint public withdrawalAllowance; //amount that can be taken out at a time
    uint public withdrawalInterval;  //how far apart you can take ehtereum out
    uint public nextAllowedWithdrawal;

    //when a function calls an event, they get logged in the blockchain (data that goes into the log's bloom header)
    event Deposit(address indexed _from, uint indexed _value);
    event Withdrawal(address indexed _to, uint indexed _value);
    event Recovery(address _newMainAddr);



    function Vault(

        address _mainAddr, //it will be assignned to the mainAddr variable in the mainAddr;
        address _recoveryAddr,
        address _deadhandAddr,
        uint _withdrawalAllowance,
        uint _withdrawalInterval
    ){
        mainAddr = _mainAddr;
        recoveryAddr = _recoveryAddr;
        deadhandAddr = _deadhandAddr;
        withdrawalAllowance = _withdrawalAllowance;
        withdrawalInterval = _withdrawalInterval;
        nextAllowedWithdrawal = now;
    }


    function deposit() payable returns (uint _newBalance){
        Deposit(msg.sender, msg.value);
        return this.balance;
    }

    function withdrawal(uint _value) returns (uint _newBalance){
        require(msg.sender == mainAddr && _value <= withdrawalAllowance && nextAllowedWithdrawal <= now);
            mainAddr.transfer(_value);
            nextAllowedWithdrawal = (now + withdrawalInterval);
            Withdrawal(msg.sender, _value);
            return this.balance;
    }

    function recover(address _newMainAddr) returns (address _newMain) {
        require(msg.sender == recoveryAddr);
        mainAddr = _newMainAddr;
        Recovery(_newMainAddr);
        return (_newMainAddr);
    }

    function burnVault() returns (bool success) {
        require(msg.sender == deadhandAddr);
        selfdestruct(deadhandAddr); //destroys contract
        return true;
    }


}
