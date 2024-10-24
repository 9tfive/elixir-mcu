## Prerequisites

You will need the following installed on your machine

- Ensure you have Elixir 1.14 and Erlang/OTP 25 installed. We recommend using [asdf](https://asdf-vm.com/), in which case you can use the `.tool-versions` 
file in this repository, to setup your development environment.

- PostgreSQL - You will need a local database, either PostgreSQL on your machine, 
or have Docker installed so we can create a PostgreSQL container. If you want to 
use docker, make sure it is installed -- https://docs.docker.com/get-docker/

- Review the docs of the Marvel API https://developer.marvel.com/documentation/generalinfo.

## Up and Running

To start your Phoenix server:

- Install dependencies with `mix deps.get`
- `docker-compose up -d` (If using docker for PostgreSQL)
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix endpoint with `iex -S mix phx.server --open`

This assignment consists of 9 different steps, that are functionally related,and build upon each other.
For this assignment you have to clone this repository,
get the application running locally and then work on the code,
as you would with any other Elixir/Phoenix application.

## Goals
  1. Fetch the characters from the Marvel API. Hint: You will use the URL
  http://gateway.marvel.com/v1/public/characters?[authenticated_params]

  2. Render the characters' names in a list on the UI with LiveView or via a controller and view.

  3. This is slow, every time we load the page, we need to fetch all the data again from the Marvel
  API. Let's implement a cache that stores this API call in memory so we don't need to keep
  fetching it on each page reload.

  4. Upper management really wants to know how often we are making requests to the Marvel API, so
  let's capture the timestamp of each successful API call into a database table.

  5. You will notice that the API is only giving us the first 20 results when we call it. Let's implement a
  pagination system to allow the users to see additional results in the UI. How does this affect our cache? Should we change anything?

  6. Let's add more test coverage. We want to mock the API calls, test the front end results, unit test
  the api authentication code, etc.

  7. What are some ways that we can improve the current code we just wrote? Think through the following:
  - Cache improvements (invalidation, pre-fetching, data optimization, handling api call failures, etc).
  - Improvements to the API interface.

8. Now let's deploy this to fly.io. It is free to make an account and deploy a starter application. Follow their [getting started guide](https://fly.io/docs/elixir/getting-started/existing/).
