## Task Management Application
# Project Overview
This project is a task management system that allows users to create, modify, and assign tasks, as well as manage task completion with tokens. It includes various rules for task creation, modification, and tracking. The application supports functionalities like task deadlines, tagging, and restrictions on task modifications.

The project is divided into two versions, with additional features being added progressively.

## Features
Version 1.1.0
Prevent task creation in the past: A task cannot be created if the date is in the past.
Require multiple tags for tasks: Users must enter more than one tag when creating tasks.
Restrict task scheduling to 3 days in advance: Users can only schedule tasks for the next 3 days.
Marking tasks as completed: A task can only be marked as completed if it is done before its deadline.
Assign tasks to yourself only: Users can assign tasks to themselves, but not to others.
Token system for task replacement:
Each user has 2 tokens per day for replacing tasks assigned by their manager.
Users have 1 token per month for task deletion.
Token-free task deletion: Deleting a task created by the same user does not affect the token count.
Version 1.2.0
Manager replaces tasks: When a manager replaces a task, they must assign it to another user, and this new task cannot be modified or deleted by tokens.
Delayed manager response: If the manager does not respond to a task change request within 12 hours, the user will receive a double token balance for task modifications the following day.
Task deadline tracking: Every 24 hours, tasks not marked as completed and exceeding their deadline will be marked as not done.
Manager overview: Managers can view an overview of all tasks assigned to their employees, including completion percentages by tags (filtered by week, month, and year), and the number of tokens used.
Technical Details
Tech Stack
Backend: Java
Database: PostgreSQL
Repository: Git
Deployment: JAR file (Executable)
Version Control: GitHub or any other Git repository hosting
Database
The database uses PostgreSQL for task storage and user management. Below are the necessary scripts to set up the database.

## Database Initialization Script
sql
Copier le code
-- Create tables for users and tasks
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);

CREATE TABLE tasks (
    task_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    deadline TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT REFERENCES users(user_id),
    status VARCHAR(50) NOT NULL,
    tags TEXT[],
    is_completed BOOLEAN DEFAULT FALSE
);

-- Create tokens table for users
CREATE TABLE tokens (
    token_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    daily_tokens INT DEFAULT 2,
    monthly_tokens INT DEFAULT 1
);
## UML Class Diagram
The project uses a simple class structure to represent users, tasks, and tokens. You can find the UML diagram here.

JIRA Project Link
The project is managed using JIRA for task tracking and progress management. You can find the project here.

Getting Started
Prerequisites
Java 11 or higher
PostgreSQL 12 or higher
Maven for building the project
Installation
Clone the repository:

bash
Copier le code
git clone https://github.com/your-username/task-management-app.git
cd task-management-app
Set up the database:

Create a new PostgreSQL database and run the provided SQL scripts to initialize the database.
Build the project:

bash
Copier le code
mvn clean install
Run the application:

You can run the application using the following command:
bash
Copier le code
mvn exec:java
Run the JAR executable (Optional):

After building, you can create the executable JAR file and run it with:
bash
Copier le code
mvn package
java -jar target/task-management-app-1.1.0.jar
Usage
Login: Log in with your user credentials.
Create a Task: You can create a task by specifying its title, deadline, and tags. Ensure that the deadline is not in the past and that you have tagged the task appropriately.
Modify/Replace Task: You can modify or replace your tasks using tokens, keeping track of your available tokens.
Manager Overview: If you are a manager, you can view the status of all tasks assigned to your team, including completion percentages.
