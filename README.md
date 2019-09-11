# Gotham

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install assets package with `cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development`
  * Install client module with `cd client && npm install`
  * Run the client module in client/ folder with `npm run serve`
  * Start Phoenix endpoint at the root of your project with `mix phx.server`

Please use a postgreSql database with user = postgres and password = password.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Endpoints / Controller / Functions

## User routes
    user_path  GET     /api/users                                GothamWeb.UserController :show_by_attr
    user_path  GET     /api/users/:userID                        GothamWeb.UserController :show
    user_path  POST    /api/users                                GothamWeb.UserController :create
    user_path  PUT     /api/users/:userID                        GothamWeb.UserController :update
    user_path  DELETE  /api/users/:userID                        GothamWeb.UserController :delete

## Working Time routes
    working_time_path  GET     /api/workingtimes/:userID                 GothamWeb.WorkingTimeController :show_by_attr
    working_time_path  GET     /api/workingtimes/:userID/:workingtimeID  GothamWeb.WorkingTimeController :show
    working_time_path  POST    /api/workingtimes/:userID                 GothamWeb.WorkingTimeController :create
    working_time_path  PUT     /api/workingtimes/:id                     GothamWeb.WorkingTimeController :update
    working_time_path  DELETE  /api/workingtimes/:id                     GothamWeb.WorkingTimeController :delete

## Clocking routes 
    clock_path  GET     /api/clocks/:userID                       GothamWeb.ClockController :show
    clock_path  POST    /api/clocks/:userID                       GothamWeb.ClockController :score

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
