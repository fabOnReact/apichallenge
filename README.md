# Code challenge

## Description

As a code challenge, let's consider the following **RoR** apps:

1. The first one (**app1**) lets a user *register* and then post comments. Each user can *write*, *read*, *update*, *list* and *destroy* **its own posts** (including texts, images or whatever);
2. **app1**: the user is able to *filter* posts by their `description`;
3. **app1**: exposes the user authentication via an `API`;
4. The second app (**app2**) shares the login w/ the first app, via the aforementioned `API` (that is, an user A registered to **app1** can also log into **app2**; user data remains in **app1**’s DB).
5. **app2** just shows posts by any registered user to logged in users.

## Instruction for the candidate

* We’d like you to provide a small implementation of one or more parts (no matter how small) of the apps described above, the choice is yours, the better you can in your available time. 
* Automated testing for the implemented parts is a **strict requirement**.
* When done, please create a branch inside the repository (you should have the permission to do so) and make a MR (Merge request/Pull request) to master with the install and run instructions.

Fell free to use whatever gem you want, no need to reinvent the wheel 🙂

If something is not clear, please ask.

# app1
## Instructions to install app1 

1. Clone the branch with `git clone -b feature/app-1 https://gitlab.com/iubenda/test-fabrizio-bertoglio/test-dev-rails.git`
2. enter your git project `cd test-dev-rails` and then the rails project `cd app1`
3. set the ruby version to 2.2.5 `rbenv local 2.2.5`
4. install the gems with `bundle`
5. set the database with `rake db:setup`
6. seed the database with `rake db:seed`
7. run the specs with `rspec`
8. start the server with `rails s`
9. visit the webapplication at `localhost:3000`

## Json Endpoints app1
1. Create new user with json request 
`curl -X POST -d '{"user":{"email":"test@gmail.com","password":"tester"}}' -H "Accept: application/json" --header "Content-Type: application/json" http://0.0.0.0:3000/users`
2. Create via json request a session - User the token received in the previous response
`curl -X POST -H "X-User-Email: tester@gmail.com" -H "X-User-Token:YourToken" -H "Accept: application/json" -H "Content-Type: application/json; charset=UTF-8" http://0.0.0.0:3000/users/sign_in`
3. Post or update a comment via json api
`curl -X POST -H "X-User-Email: tester@gmail.com" -H "X-User-Token:xNJJiePfhbeSnWxfv6rD" -H "Accept: application/json" -H "Content-Type: application/json; charset=UTF-8" -d '{"comment":{"message":"a test message","description":"a description"}}' http://0.0.0.0:3000/comments`
