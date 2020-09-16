# Datomic [![Docker Repository on Quay](https://quay.io/repository/nedap/datomic/status?token=544ebbd3-26d2-496b-9c2a-d054f14950f6 "Docker Repository on Quay")](https://quay.io/repository/nedap/datomic)
This Dockerfile defines an image
for [Datomic Pro Starter Edition](http://www.datomic.com/). It requires
the datomic credentials as arguments for the build so that a complete
and immediately usable image can be built.

# Building
0. Tag commit with current transactor version.
1. push commit / tag
2. CircleCI will build a release and deploy it to `quay.io/nedap/datomic`

# Usage

You can run this as standalone docker container, or in a docker-compose configuration.

The Dockerfile **EXPOSES** ports 4334-4336 and establises a **VOLUME** at `/opt/datomic-pro-<DATOMIC_VERSION>/data`.

To start datomic, execute the following command in the container:
`./bin/transactor <path_to_transactor.properties>`

### `docker-compose.yml`
```yml
services:
  datomic:
    image: quay.io/nedap/datomic:1.0.6202.0
    command: ["./bin/transactor", "transactor.properties"]
    environment:
      DATABASES: "example,another"
    volumes:
      - datomic-data:/opt/datomic-pro-1.0.6202.0/data
    ports:
      - 4334-4336

volumes:
  datomic-data:
```
Starts with `docker-compose up datomic`, will create 2 databases (iff non-existant) `example` and `antoher`

connect to `<DBNAME>,datomic:dev://datomic:4334/<DBNAME>?password=123`.

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
