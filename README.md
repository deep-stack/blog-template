# blog-template

## Setup

```
# Give permission for `direnv` to use the env config defined in the `.envrc` file in the current directory.
direnv allow .
```

## Usage

- Modify the `index.md` file content

- Generate the corresponding `index.html` file

    ```
    yarn generate
    ```

- Start the server

    ```
    serve public
    ```
