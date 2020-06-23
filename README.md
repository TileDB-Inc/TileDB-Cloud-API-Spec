# TileDB Cloud API Specification

This repository documents the [TileDB Cloud REST API](https://console.tiledb.com/).

Two openapi specification files exists, one for v1 routes and one for v2 routes.

[openapi v1](openapi-v1.yml)
[openapi v2](openapi-v2.yml)


## TileDB Cloud Client APIs

If you are looking for existing clients, see the
[TileDB Cloud Documentation](https://docs.tiledb.com/cloud/).
This repository is most useful when looking to create a new client.


## Releases and Feature Maturity

This repository is a living specification, which might reference
features which are in beta testing, and are subject to change. Routes and
models which are not considered stable will have a beta label added.


## Usage of Openapi Definition

[Openapi](http://swagger.io/) is a specification for defining API endpoints.
The openapi file can be used for visualizing the api via
[online swagger editor](https://editor.swagger.io/) . There is a large
number of tools which can take the swagger file and produce
working client code (code generation).

For example [TileDB-Cloud-Py](https://github.com/TileDB-Inc/TileDB-Cloud-Py/)
uses [openapi generator](https://github.com/OpenAPITools/openapi-generator)
to code generate the python REST client.
