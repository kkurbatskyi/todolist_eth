///
pragma solidity ^0.5.0;

contract TodoList{
    uint8 public taskCount = 0;

    struct Task{
        uint8 id;
        string content;
        bool completed;
    }

    mapping(uint8 => Task) public tasks;

    constructor() public{
        createTask("Complete the first task");
    }

    function createTask(string memory _content) public{
        taskCount++;
        tasks[taskCount] = Task(taskCount, _content, false);
    }


}
