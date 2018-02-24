pragma solidity ^0.4.20;
contract XRegistry {
    mapping (address => string) _addressToEmail;
    mapping (address => uint) _addressToNumber;
    mapping (string => address) _emailToAddress;
    mapping (uint => address) _NumberToAddress;
    
    uint _numberOfAccounts;
    
    // if a newer version of this registry is available, force users to use it
	bool _registrationDisabled;
	
	function XRegistry() public {
		_numberOfAccounts = 0;
		_registrationDisabled = false;
	}
	
	function register(string email, uint number) public returns (int result) {
		if (_emailToAddress[email] > 0 || _NumberToAddress[number] > 0)  {
			// email or number are already taken
			result = -1;
		} else if (bytes(_addressToEmail[msg.sender]).length > 0 || 
		           _addressToNumber[msg.sender] > 0) {
			// Address is already associated with the email or number
			result = -2;
		} else if (_registrationDisabled){
			// registry is disabled because a newer version is available
			result = -3;
		} else {
			_NumberToAddress[number] = msg.sender;
			_emailToAddress[email] = msg.sender;
			_addressToEmail[msg.sender] = email;
			_addressToNumber[msg.sender] = number;
			_numberOfAccounts++;
			result = 0; // success
		}
	}
	
	function get_info(string email, uint number, address addr) 
	    external
	    view 
	    returns (string r_email, uint r_number, address r_addr)
	{
	    if (bytes(email).length != 0) {
	        r_email = email;
	        r_addr = _emailToAddress[email];
	        r_number = _addressToNumber[addr];
	    } else if (number != 0) {
	        r_number = number;
	        r_addr = _NumberToAddress[number];
	        r_email = _addressToEmail[addr];
	    } else if (addr != 0) {
	        r_addr = addr;
	        r_email = _addressToEmail[addr];
	        r_number = _addressToNumber[addr];
	    } else {
	        r_email = '';
	        r_number = 0;
	        r_addr = 0;
	    }
	}   
}
