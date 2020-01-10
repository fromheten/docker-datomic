# Datomic [![Docker Repository on Quay](https://quay.io/repository/nedap/datomic/status?token=544ebbd3-26d2-496b-9c2a-d054f14950f6 "Docker Repository on Quay")](https://quay.io/repository/nedap/datomic)
This Dockerfile defines an image
for [Datomic Pro Starter Edition](http://www.datomic.com/). It requires
the datomic credentials as arguments for the build so that a complete
and immediately usable image can be built.

# Building
1. Clone this repository and cd into it.
2. Make sure that `DATOMIC_REPO_USER`, `DATOMIC_REPO_PASS`and `DATOMIC_LICENSE` are correctly defined in your environment.
3. Execute `make`.

For pushing the image to quay refer to the documentation of quay: https://docs.quay.io/solution/getting-started.html

# Usage

You can run this as standalone docker container, or in a docker-compose configuration.

The Dockerfile **EXPOSES** ports 4334-4336 and establises a **VOLUME** at `/opt/datomic-pro-<DATOMIC_VERSION>/data`.

To start datomic, execute the following command in the container:
`./bin/transactor <path_to_transactor.properties>`

### `docker-compose.yml`
```yml
datomic:
    image: quay.io/nedap/datomic:latest
    command: ["./bin/transactor", "transactor.properties"]
    environment:
      DATABASES: "example,another"
    ports:
      - 4334-4336
```
Starts with `docker-compose up datomic`, will create 2 databases (iff non-existant) `example` and `antoher`

## License

The MIT License (MIT)

Copyright (c) 2014-2017 Point Slope, LLC.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
