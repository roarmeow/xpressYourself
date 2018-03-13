pragma solidity ^0.4.18;

contract xpressr {

    struct Xpression {
        string message;
        string url;
        uint timestamp;
    }

    address public _xpressr;
    address[] senders;

    mapping(address => Xpression[]) myXpressions;

    modifier onlyOwner {
        require(msg.sender == _xpressr);
        _;
    }

    function xpressr() public {
        _xpressr = msg.sender;
    }

    function xpress(string message, string url) external {
        myXpressions[msg.sender].push(Xpression(message, url, now));
        bool alreadySent = false;
        for(uint i = 0; i < senders.length; i++) {
            if(msg.sender == senders[i]) {
                alreadySent = true;
            }
        }
        if(!alreadySent) { senders.push(msg.sender); }
    }

    function fromXpressions() external view returns(Xpression[]) {
        return myXpressions[msg.sender];
    }

    function getMyXpressions(address sender) external view onlyOwner returns(Xpression[]) {
        return myXpressions[sender];
    }
}
