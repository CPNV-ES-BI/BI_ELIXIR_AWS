# BI_AWS_ELIXIR
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
* [Docker][docker-url]
* [Espec][espec-url]
* [ExAWS][exaws-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started
This is microservice written in Elixir whose purpose is to `AWS S3` as a data source to perform some techniques related to `Business Intelligence`.

Since this project is written in Elixir, you will need to install the BEAM.

### Prerequisites

#### Erlang + Elixir 1.14.2 / OTP 25

* macOS

  ```sh
  brew install erlang elixir
  ```

* ArchLinux

  ```sh
  pacman -S erlang elixir
  ```

* Windows

  Checkout [Elixir's documentation](https://elixir-lang.org/install.html#windows)

Note that by installing Elixir's runtime, you will be able to use both `mix` (package management/build tool) and `iex` (interactive Elixir shell).

They both have the same version as the Elixir's compiler since they are part of Elixir's core. `Unlike Python, Javascript` or other programming languages, the package management tool **is not a external tool that can be updaded individually**.

`mix` are to Elixir what `cargo` is to `Rust` and `go` is to `Go`.

### Configuration

In able to communicate with `AWS` servers, you have to store your credentials in environment variables.

Make sure the following environment variables are set:

* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`
* `AWS_BUCKET`

If you intend to run this project in a docker container, you have to define those credentials in the `docker-compose.yml` file.

```sh
cp docker-compose.yml.example docker-compose.yml
```

Then, assign your credentials to these variables:

```yml
environment:
  - AWS_ACCESS_KEY_ID=
  - AWS_SECRET_ACCESS_KEY=
  - AWS_BUCKET=
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

4. Finally, launch the web server

   ```sh
   mix phx.server
   ```

   Or you if want to have a console and execute Elixir code in live (just like Ruby on Rails console/irb):

   ```sh
   iex -S mix phx.server
   ```

#### Docker

##### Development

1. Build docker's image

   ```sh
   docker-compose build
   ```

2. Launch the container using `docker-compose`

   ```sh
   docker-compose up -d
   ```

   This will open two ports: `4000` and `4369`. The later is used by [the observer](https://elixir-lang.org/getting-started/debugging.html#observer). This tool allows to connect to a remote Elixir Node and watch the running processes (this is one of the reasons why Elixir is a perfect solution for distributed systems).

##### Production

Production docker image can be found under `container/`.

Rename `docker-compose.yml.example` to `docker-compose.yml` and set the environment variables.

**NOTE**: `SECRET_KEY_BASE` should have the string returned from `mix phx.gen.secret`.

1. Build docker's image

   ```sh
   docker-compose build
   ```

2. Launch the container using `docker-compose`

   ```sh
   docker-compose up -d
   ```

Just like the development container, the production one exposes both `4000` and `4369` ports.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Tests

### On your machine

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

If you want to generate a `test coverage` report, type the following:

```sh
MIX_ENV=test mix coveralls.html
```

### On the container

In order to run all tests type:

```sh
docker-compose exec -e MIX_ENV=test app mix espec
```

If you want to run all tests of a file

```sh
docker-compose exec -e MIX_ENV=test app mix espec ./spec/<FILE_TEST>.exs
```

Or, if you only want to run a specific test

```sh
docker-compose exec -e MIX_ENV=test app mix espec ./spec/<FILE_TEST>.exs:<LINE_NUMBER>
```

If you want to generate a `test coverage` report, type the following:

```sh
docker-compose exec -e MIX_ENV=test app mix coveralls.html
```

## Documentation

The documentation of this project can be genrated by [ExDoc](https://github.com/elixir-lang/ex_doc).

```sh
mix docs
```

Or, if you want to generate the documentation and open it in your browser, type:

```sh
mix docs --open
```

## Directory structure

Just like most web applications written in Elixir, this project follows the `directory structure` defined for [Phoenix][phoenix-url]. [The excellent official documentation](https://hexdocs.pm/phoenix/directory_structure.html) explains in great detail the purpose of each directory.

The unit tests (BDD) can be found under the `spec/` directory.

And, both class (even though Elixir is a functional language and does not have classes) and sequence diagrams can be found under the `docs/`.

## Debugging

Since Elixir has excellent debugging tools (thanks to the Erlang ecosystem), I thought I would be interesting to demonstrate how to use the `observer`. As you might have noticed, in this video, I am running this project inside a docker container.

Due to one of Elixir's core-values (distributed systems), we can easily connect to remote notes and debug them while they are running.

The following demonstration shows how to launch an Elixir `remote session`. Make sure you replace `thynkon` with your username when typing the following command:

```sh
iex --name thynkon@172.40.0.1 --cookie business_intelligence
```

<https://user-images.githubusercontent.com/35641748/207707176-2dd2acad-15be-4d5c-94a0-8c6912b9ed16.mp4>

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

To give you a better idea of what this project looks like, here the output of `tree -f`.

<pre>
.
├── ./config
│   ├── ./config/config.exs       // Define application variables before compilation
│   ├── ./config/dev.exs          // Development configuration
│   ├── ./config/prod.exs         // Prod configuration
│   ├── ./config/runtime.exs      // Define application variables after compilation (load environment variables)
│   └── ./config/test.exs         // Test configuration
├── ./containers                  // Production containers
├── ./docker-compose.yml.example
├── ./Dockerfile
├── ./docs                        // UML diagrams
│   ├── ./docs/class_diagrams
│   └── ./docs/sequence_diagrams
├── ./entrypoint.sh
├── ./lib
│   ├── ./lib/business_intelligence      // Files related to business logic (models)
│   ├── ./lib/business_intelligence_web  // Files related to the web application (controllers, views)
│   │   ├── ./lib/business_intelligence_web/controllers
│   │   └── ./lib/business_intelligence_web/views
├── ./LICENSE
├── ./mix.exs
├── ./mix.lock
├── ./priv
│   ├── ./priv/gettext               // Translation
│   └── ./priv/repo                  // Migrations, seeders
│       ├── ./priv/repo/migrations
│       └── ./priv/repo/seeds.exs
├── ./README.md
└── ./spec                           // BDD test
</pre>

If you want to better understand the difference between `config.exs` and `runtime.exs`, take a look at [Elixir's documentation](https://elixir-lang.org/getting-started/mix-otp/config-and-releases.html#configuration).


<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

* [Thynkon](https://github.com/Thynkon)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[elixir-url]: https://elixir-lang.org
[phoenix-url]: https://www.phoenixframework.org
[sqlite-url]: https://www.sqlite.org
[docker-url]: https://www.docker.com
[exaws-url]: https://github.com/ex-aws/ex_aws
[espec-url]: https://github.com/antonmi/espec
