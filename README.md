

## Task Tracker Web Application

* Technologies: ReactJS, Elixir, Phoenix Framework, postgres

***

## Design choices:
1. Users can __register__ and __login__ by their usernames. Username should be unique while registering a user.
 * No passwords yet.
2. __Features:__ 
    - Feed, which includes all the tasks present.
    - Assigned Tasks, which includes the tasks assigned to the user logged in.
    - Create task, which allows to users to create a task entering title, description, and a assignee.
    - Tracking time for each task assigned to a user(In 15 minute intervals).
    - Marking a task as complete.
3. __Privileges:__
 * Users can only edit a task content if they created that task or are assigned
  to that task.
    - Edit privilege enables access to edit Title, Description, time taken, and status fields
 * Users who did not create or are assigned to a task, can only view that task.
 * Creator and Assigned User of a task can mark that task as complete
    via __change task__ button.
    - Dedicated button to easily mark a task as complete.
 * Creator of a task can assign that task to any user
       via __change Assignee__ button.
    - Dedicated button to easily assign a task.
4. Users can track the time on a task by inserting number of minutes taken in 15 minute time intervals.  
5. If a User is deleted, all the tasks owned by that user becomes Anonymous.
  and all the tasks assigned to that users becomes unassigned tasks.
  
***

## To start your Phoenix server:

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.create && mix ecto.migrate`
* Install Node.js dependencies with `cd assets && npm install`
* Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

* Docs: https://hexdocs.pm/phoenix
* Official website: http://www.phoenixframework.org/
* Guides: http://phoenixframework.org/docs/overview
* Mailing list: http://groups.google.com/group/phoenix-talk
* Source: https://github.com/phoenixframework/phoenix
