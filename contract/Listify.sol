// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TodoManager {
    struct Todo {
        string task;
        bool completed;
    }

    // Array to store all todos
    Todo[] private todos;

    // Add a new task
    function addTask(string memory _task) public {
        todos.push(Todo({task: _task, completed: false}));
    }

    // Mark a task as completed
    function completeTask(uint _index) public {
        require(_index < todos.length, "Task does not exist");
        todos[_index].completed = true;
    }

    // Get total number of tasks
    function getTodoCount() public view returns (uint) {
        return todos.length;
    }

    // Get a task by index
    function getTask(uint _index) public view returns (string memory task, bool completed) {
        require(_index < todos.length, "Task does not exist");
        Todo storage todo = todos[_index];
        return (todo.task, todo.completed);
    }

    // Get all tasks (optional, for convenience)
    function getAllTasks() public view returns (Todo[] memory) {
        return todos;
    }
}
