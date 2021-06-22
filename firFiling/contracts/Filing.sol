// SPDX-License-Identifier: MIT;
pragma solidity ^0.8.0;

// Decentralized Investigation Reporting contract
contract Filing {

    address reporter;
    string name;
    string report_type;
    string description;
    uint256 report_status;

    // event for the new report filed
    event createReportEvent(
        address indexed _reporter,
        string _name,
        string _report_type,
        string _description
    );

    // function to create a report with initialized variableNames
    constructor(
        string memory _name,
        string memory _report_type,
        string memory _description
    ) {
        reporter = msg.sender;
        name = _name;
        report_type = _report_type;
        description = _description;
        report_status = 1;
        emit createReportEvent(reporter, name, report_type, description);
    }

    // GetReport function will return details of report filed
    function getReport() public view returns(address _reporter,
        string memory _name,
        string memory _report_type,
        string memory _description,
        uint _report_status){
            return (reporter,name,report_type,description, report_status);
        }
    
    // setStatus function updates the status of the report
    function setStatus(uint _report_status) public {
        report_status = _report_status;
    }

}
