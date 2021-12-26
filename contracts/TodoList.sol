///
pragma solidity ^0.5.0;

contract TodoList{

    mapping (address => User) public users;

    event TaskCreated(uint id, string content, bool completed);
    event TaskCompleted(uint id, bool completed);
    
    
    struct User{
        uint8 taskCount;
        mapping(uint8 => Task) tasks;
    }

    struct Task{
        uint8 id;
        string content;
        bool completed;
    }

    function taskCount() external view returns (uint8){
        uint8 _taskCount = users[msg.sender].taskCount;
        return _taskCount;
    }

    function tasks(uint8 _id) external view returns (uint8 id, string memory content, bool completed){
        User storage _user = users[msg.sender];
        Task memory _task = _user.tasks[_id];
        return (_task.id, _task.content, _task.completed);
    }

    function createTask(string memory _content) public{
        users[msg.sender].taskCount++;
        User storage _user = users[msg.sender];
        Task memory _task = _user.tasks[_user.taskCount];
        _task = Task(_user.taskCount, _content, false);
        _user.tasks[_user.taskCount] = _task;
        users[msg.sender] = _user;
        emit TaskCreated(_user.taskCount, _content, false);
    }

    function toggleCompleted(uint8 _id) public{
        User storage _user = users[msg.sender];
        Task memory _task = _user.tasks[_id];
        _task.completed = !_task.completed;
        _user.tasks[_id] = _task;
        users[msg.sender] = _user;
        emit TaskCompleted(_id, _task.completed);
    }
}
