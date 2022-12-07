# EasyVault
<a name="readme-top"></a>
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
        <a href="#built-with">Built With</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#conventions">Conventions</a></li>
    <li><a href="#current-state">Current state</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

### Built With

* [Elixir - 1.14][elixir-url]
* [Phoenix - 1.6.14][phoenix-url]
* [Oban - 2.13.4][oban-url]
* [SQLite - 3][sqlite-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started
Since this project is written in Elixir, you will need to install the BEAM.
You may also need to launch a container for the PostgreSQL database used to store information about background tasks.

### Prerequisites
#### Erlang + Elixir
- macOS
  ```sh
  brew install erlang elixir
  ```
- ArchLinux
  ```sh
  pacman -S erlang elixir
  ```

### Installation
#### On your machine

1. Elixir dependencies
   ```sh
   mix deps.get
   ```
2. Create database and lanch migrations
   ```sh
   mix ecto.create
   mix ecto.migrate
   ```
6. Finally, launch the web server
   ```sh
   mix phx.server
   ```

   Or you if want to have a console and execute Elixir code in live:
   
   ```sh
   iex -S mix phx.server
   ```

#### Docker

1. Build docker's image
   ```sh
   docker build -t business_intelligence .
   ```
2. Launch the container using `docker-compose`
   ```sh
   docker-compose up -d
   ```
   This will open two ports: `4000` and `4369`
6. Finally, launch the web server
   ```sh
   mix phx.server
   ```

   Or you if want to have a console and execute Elixir code in live:
   
   ```sh
   iex -S mix phx.server
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Tests
In order to run all tests type:

```sh
MIX_ENV=test mix test
```

If you want to run all tests of a file
```sh
MIX_ENV=test mix test ./test/<FILE_TEST>.exs
```

Or, if you only want to run a specific test
```sh
MIX_ENV=test mix test ./test/<FILE_TEST>.exs:<LINE_NUMBER>
```

## Docs
The documentation of this project can be genrated by [ExDoc](https://github.com/elixir-lang/ex_doc).
```sh
mix docs
```

Or, if you want to generate the documentation and open it in your browser, type:
```sh
mix docs --open
```


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[elixir-url]: https://elixir-lang.org
[phoenix-url]: https://www.phoenixframework.org
[sqlite-url]: https://www.sqlite.org
[postgresql-url]: https://www.postgresql.org
[oban-url]: https://github.com/sorentwo/oban
[bootstrap-url]: https://getbootstrap.com
