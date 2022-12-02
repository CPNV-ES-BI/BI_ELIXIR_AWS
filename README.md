# BusinessIntelligence

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

* [Elixir - 1.14.2][elixir-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started
Since this project is written in Elixir, you will need to install the BEAM.

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

1. Elixir dependencies
   ```sh
   mix deps.get
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Documentation
The documentation of this project can be genrated by [ExDoc](https://github.com/elixir-lang/ex_doc).
```sh
mix docs
```
If you only want to generate
```sh
mix docs
```

Or, if you want to generate the documentation and open it in your browser, type:
```sh
mix docs --open
```

## Tests
If you want to run all tests, type:
```sh
mix test
```

Or if you want to run all tests of a file:
```sh
mix test test/<YOUR_TEST_FILE>.exs
```

Finally, to run a specific test:
```sh
mix test test/<YOUR_TEST_FILE>.exs:<LINE_NUMBER_OF_THE_REST>
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[elixir-url]: https://elixir-lang.org
[phoenix-url]: https://www.phoenixframework.org
[sqlite-url]: https://www.sqlite.org
[postgresql-url]: https://www.postgresql.org
[oban-url]: https://github.com/sorentwo/oban
[bootstrap-url]: https://getbootstrap.com
