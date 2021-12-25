///
pragma solidity ^0.5.0;

contract TodoList{
    uint8 public taskCount = 0;

    event TaskCreated(uint id, string content, bool completed);
    event TaskCompleted(uint id, bool completed);


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
        emit TaskCreated(taskCount, _content, false);
    }

    function toggleCompleted(uint8 _id) public{
        Task memory _task = tasks[_id];
        _task.completed = !_task.completed;
        tasks[_id] = _task;
        emit TaskCompleted(_id, _task.completed);
    }
}
