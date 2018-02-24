pragma solidity ^0.4.20;

contract xpressr {

    event NewXpression(uint xId, string message, string url);

    struct Xpression {
        string message;
        string url;
        uint timestamp;
    }

    address _xpressr;
    address[] senders;

    mapping(address => Xpression[]) myXpressions;
    mapping(uint => address) public xpressionSender;

    modifier canSee(address[] addresses) {
        for (uint i = 0; i < addresses.length; i++) {
            msg.sender == addresses[i];
        }
        _;
    }

    function xpress(string message, string url) external {
        uint id = myXpressions[msg.sender].push(Xpression(message, url, now));
        xpressionSender[id] = msg.sender;
        NewXpression(id, message, url);
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

    function getMyXpressions(address sender) external view returns(Xpression[]) {
        return myXpressions[sender];
    }
}
