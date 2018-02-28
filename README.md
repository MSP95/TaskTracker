

## Modified Task Tracker Web Application

* Technologies: ReactJS, Elixir, Phoenix Framework, postgres

***

## Design choices:
1. Users can __register__ and __login__ by their usernames. Username should be unique while registering a user.
 * No passwords yet.
2. __Features:__ 
    - Feed page, which includes all the tasks present.
    - Assignments page, which includes the tasks assigned to the user who is logged in.
    - Create task, which allows to users to create a task entering title, description, and a assignee.
    - Tracking time for each task assigned:
        * A user who is assigned to a task can add time sessions for that task.
          He can start and stop a work-session whenever required by using the start/stop button.
        * A user can also manually input the time required for the work-session.
        * A user can view all his previous history of work-sessions and can edit those sessions individually.
        * A user can also see the work sesssions of previous asignees of the task.
    - Profile page, which includes the current manager of that user and a list of all the people who are managed by the current logged in user.
    - Task report page, which includes all the tasks which are assigned to the current user's umderlings.
    This page only includes title , status, creator, assignee of the tasks, as this is just a report.
    - All user page, this includes a list of all the users, and gives the ability to current user to manage those users which are unmanaged currently. Those who are already managed can't be managed, hence the manage button does nothing for such users.
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
4. Only assigned Users can track the time on a task by clicking on add time session button.  
5. Users can't be deleted, as this was not a requirement for this assignment.
  

