# TileDB-REST

This repository documents the TileDB Rest interface. A
[openapi definition file](swagger.yml) is provided.

A [cap'n proto schema](tiledb-rest.capnp) is also provided for
high performance serialization.

The openapi (formally called swagger) and the cap'n proto definitions should
be equivalent. Currently they are being hand maintained, but plans are
to automatically produce the capnp file from the openapi specification.

## Using Openapi Definition

[Openapi](http://swagger.io/) is a specification for defining API endpoints.
The openapi file can be used for visualizing the api via
[online swagger editor](https://editor.swagger.io/) . There also is a large
number of tools which can take the swagger file and produce
working client code (code gen).
