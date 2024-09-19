# blog-template

## Setup

- Clone the repository

  ```
  git clone git@github.com:deep-stack/blog-template.git

  cd blog-template
  ```

- Install dependencies

  ```
  yarn
  ```

- Install `pandoc`

  - Download the latest release of Pandoc from the [official site](https://github.com/jgm/pandoc/releases)

  - Unpack the tarball

    ```
    tar -xvzf path/to/downloaded/release
    ```

  - Move Pandoc to `/usr/local/bin`:

    ```
    sudo mv pandoc-<version>/bin/pandoc /usr/local/bin/
    ```

  - Verify installation

    ```
    pandoc --version
    ```

  - For installation on other platforms follow the [official docs](https://pandoc.org/installing.html)

## Deploy

- Modify the content in [index.md](./index.md)

- Generate the corresponding `index.html` file

  ```
  yarn generate
  ```

- Deploy the app

  ```
  yarn serve public
  ```
