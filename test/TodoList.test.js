const { assert } = require("chai")

const TodoList = artifacts.require('./TodoList.sol')

contract('TodoList', (accounts) => {

    before(async () => {
        this.todoList = await TodoList.deployed();
        console.log(this.address);
        await this.todoList.createTask('Complete the first task');
    })

    it('deploys successfully', async () => {
        const address = await this.todoList.address;
        assert.notEqual(address, 0x0);
        assert.notEqual(address, '');
        assert.notEqual(address, null);
        assert.notEqual(address, undefined);
    })

    it('lists tasks', async () => {
        const taskCount = await this.todoList.taskCount()
        const task = await this.todoList.tasks(taskCount)
        console.log(taskCount);
        assert.equal(task.id.toNumber(), taskCount.toNumber())
        assert.equal(task.content, 'Complete the first task')
        assert.equal(task.completed, false)
        assert.equal(taskCount.toNumber(), 1)
    })

    it('creates tasks', async () => {
        const result  = await this.todoList.createTask('A new task');
        const taskCount = await this.todoList.taskCount();
        assert.equal(taskCount, 2);
        const event = result.logs[0].args;
        assert.equal(event.id.toNumber(), 2);
        assert.equal(event.content, 'A new task');
        assert.equal(event.completed, false);
    })

    it('completes tasks', async () => {
        const completed = await this.todoList.tasks(1).completed;
        const result = await this.todoList.toggleCompleted(1);
        const task = await this.todoList.tasks(1);
        const event = result.logs[0].args;
        assert.equal(task.completed, !completed)
        assert.equal(task.id.toNumber(), 1);
    })
})