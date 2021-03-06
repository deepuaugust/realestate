pragma solidity^0.4.13;

/// @title Contract to manage real estate dealings in blockchain
contract RealEstate {
    
    // declares owner of the contract
    address _owner;
    
    // declares a state varible that stores property details.
    mapping (int => string) public properties;
    
    // modifier to restrict contract usage
    modifier onlyOwner() {
        require(msg.sender == _owner);
        _;
    }
    
    event propertyEvent(int _id, string _data, string _status, uint256 _time);
    
    // ADD, DELETE, EDIT
    
    // constructor that saves owner details.
    function RealEstate() public {
        _owner = msg.sender;
    }
    
    // function to add property details
    function addProperty(int _id, string _data) onlyOwner public {
        properties[_id] = _data;
        propertyEvent(_id, _data, "ADD", now);
    }
    
    // function to edit property details
    function editProperty(int _id, string _data) onlyOwner public {
        properties[_id] = _data;
        propertyEvent(_id, _data, "EDIT", now);
    }
    
    // function to delete a certain property
    function deleteProperty(int _id) onlyOwner public {
        properties[_id] = "";
        propertyEvent(_id, "", "DELETE", now);
    }
    
    // change the owner of the contract
    function changeOwner(address newOwner) onlyOwner public {
        _owner = newOwner;
    }
    
    // destroy the current contract, sending its funds to the given address
    function kill() onlyOwner public { 
        selfdestruct(_owner);
    }
    
    // fallback function to prevent sending ethers to the contract
    function () payable public {
        revert();
    }
}