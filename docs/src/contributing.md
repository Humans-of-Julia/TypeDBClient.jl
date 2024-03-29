```@meta
CurrentModule = TypeDBClient
```

# Contributing

## Introduction

So, TypeDB itself provides various ways how to communicate (read from & write to) the database.

There is the [Workbase] (https://docs.vaticle.com/docs/workbase/overview) the [TypeDB Console] (https://docs.vaticle.com/docs/console/console#what-is-the-typedb-console) and the different [Clients] (https://docs.vaticle.com/docs/client-api/overview) to be used in an application.

There are clients for the following languages: Java, Node.js and Python.

This is the community driven Julia client.

## Workflow guidance & roadmap

Our reference client is the [Java version](https://docs.vaticle.com/docs/client-api/java).

The roadmap for TypeDBClient.jl (2021-10-01):

- completing the client with the cluster functionality (commercial product by Vaticle)
- improving speed
- making multithreading possible and threadsafe

The roadmap for TypeDBClient.jl (24.01.2021):

- writing a HTTP/2 and gRPC implementation in Julia (done)
- building the client architecture in Julia based on the protocol (done)
- building up BDD infrastructure (done)

The roadmap for TypeDB 2.0 (25.06.2021):

- TypeDB 2.3.1 has been released, [check here](https://github.com/vaticle/typedb/releases/tag/2.3.1)
- all client libraries have been released

## Dependencies

We aim for a Julia native solution.

- [gRPCClient.jl](https://github.com/JuliaComputing/gRPCClient.jl)
- [Protobuf](https://github.com/JuliaIO/ProtoBuf.jl)
- [gRPC](https://grpc.io/)

## How to start

Check for open issues [here](https://github.com/Humans-of-Julia/TypeDBClient.jl/issues).

For further questions about how to start, ideally find us on [Discord](https://discord.gg/NSYrYZQRyv).

## Project status

The current project status can be seen on the [GitHub Project Kanban](https://github.com/Humans-of-Julia/TypeDBClient.jl/projects/1)

## Useful sources

- [Protobuf](https://github.com/protocolbuffers/protobuf)
- [gRPC](https://grpc.io/)
- [gRPC implementation introduction](https://scotch.io/tutorials/implementing-remote-procedure-calls-with-grpc-and-protocol-buffers)
