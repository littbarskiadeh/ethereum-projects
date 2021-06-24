// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Todo {
    // data structure to represent a routine item
    struct Routine {
        string task;
        string time;
    }
    // log events added
    event LogTaskAdded(uint256 id, string task, string time);
    event LogTaskDeleted(string msg, uint256 id);

    // mapping to hold all the routines created
    mapping(uint256 => Routine) private routines;
    uint256[] private ids;

    function getTaskCount() public view returns (uint256 _taskCount) {
        _taskCount = ids.length;
    }

    // get task id for a specific index
    function getTaskIdAt(uint256 _index) public view returns (uint256 _taskId) {
        _taskId = ids[_index];
    }

    function getTask(uint256 id)
        public
        view
        returns (string memory _task, string memory _time)
    {
        Routine storage foundRoutine = routines[id];
        return (foundRoutine.task, foundRoutine.time);
    }

    function addTask(
        uint256 _id,
        string memory _task,
        string memory _time
    ) public returns (bool _success) {
        routines[_id] = Routine({task: _task, time: _time});
        ids.push(_id);
        emit LogTaskAdded(_id, _task, _time);
        _success = true;
    }


    function deleteTask(uint256 _id) public returns (bool _success) {
        uint256 element = ids[_id];
        delete ids[_id];
        emit LogTaskDeleted("Task deleted, id - ", element);
        return true;
    }

}
