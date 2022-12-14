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
        <li><a href="#configuration">Configuration</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#tests">Tests</a></li>
    <li><a href="#documentation">Documentation</a></li>
    <li><a href="#debugging">Debugging</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>

### Built With

* [Elixir][elixir-url]
* [Phoenix][phoenix-url]
* [SQLite][sqlite-url]
* [Docker][oban-url]
* [Espec][espec-url]
* [ExAWS][exaws-url]

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

### Configuration
In able to communicate with `AWS` servers, you have to define your credentials in a `.env` file.

1. Copy the example file
    ```sh
    cp .env.example .env
    ```

2. Open the `.env` with your favorite text editor and save your credentials
    ```sh
    vim .env
    ```

### Installation
In can either install Elixir's binaries directly on your machine or you can use a docker container that provides an already configured development environment.

#### On your machine

1. Install dependencies
   ```sh
   mix deps.get
   ```

2. Compile the dependencies
    ```sh
    mix deps.compile
    ```
   
3. Create database and lanch migrations
   ```sh
   mix ecto.create
   mix ecto.migrate
   ```
6. Finally, launch the web server
   ```sh
   mix phx.server
   ```

   Or you if want to have a console and execute Elixir code in live (just like Ruby on Rails console/irb):
   
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
   This will open two ports: `4000` and `4369`. The later is used by [the observer](https://elixir-lang.org/getting-started/debugging.html#observer). This tool allows to connect to a remote Elixir Node and watch the running processes (this is one of the reasons why Elixir is a perfect solution for distributed systems). 

6. Finally, launch the web server
   ```sh
   mix phx.server
   ```

   Or you if want to have a console and execute Elixir code in live:
   
   ```sh
   iex -S mix phx.server
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Tests
In order to run all tests type:

```sh
MIX_ENV=test mix espec
```

If you want to run all tests of a file
```sh
MIX_ENV=test mix espec ./spec/<FILE_TEST>.exs
```

Or, if you only want to run a specific test
```sh
MIX_ENV=test mix espec ./spec/<FILE_TEST>.exs:<LINE_NUMBER>
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

## Debugging
Since Elixir has excellent debugging tools (thanks to the Erlang ecosystem), I thought I would be interesting to demonstrate how to use the `observer`. As you might have noticed, in this video, I am running this project inside a docker container.

Due to one of Elixir's core-values (distributed systems), we can easily connect to remote notes and debug them while they are running.

The following demonstration shows how to launch an Elixir `remote session`. Make sure you replace `thynkon` with your username when typing the following command:
```sh
iex --name thynkon@172.40.0.1 --cookie business_intelligence
```

https://user-images.githubusercontent.com/35641748/207707176-2dd2acad-15be-4d5c-94a0-8c6912b9ed16.mp4


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[elixir-url]: https://elixir-lang.org
[phoenix-url]: https://www.phoenixframework.org
[sqlite-url]: https://www.sqlite.org
[postgresql-url]: https://www.postgresql.org
[oban-url]: https://github.com/sorentwo/oban
[bootstrap-url]: https://getbootstrap.com
[exaws-url]: https://github.com/ex-aws/ex_aws
[espec-url]: https://github.com/antonmi/espec
