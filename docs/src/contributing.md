```@meta
CurrentModule = GraknClient
```

# Contributing

## Introduction

So, Grakn itself provides various ways how to communicate (read from & write to) the database.

There is the [Workbase] (https://dev.grakn.ai/docs/workbase/overview) the [Grakn Console] (https://dev.grakn.ai/docs/running-grakn/console) and the different [Clients] (https://dev.grakn.ai/docs/client-api/overview) to be used in an application. 

There are clients for the following languages: Java, Node.js and Python. But there is no Julia client yet.

We are going to build the Julia client here.

## Workflow guidance & roadmap

```@index
```
As there will be a major change in the underlying technology of Grakn with the Version 2.0 in a not too far future, we cannot directly start to translate anything we find in the other Clients.

For now our reference client is the [Python version](https://dev.grakn.ai/docs/client-api/python), which can be found also in the GitHub repo of this project.

However, there are some design guidelines on how to roll an own client [here](https://dev.grakn.ai/docs/client-api/python) and an introductiory write up on how to start [here](https://blog.grakn.ai/grakn-python-driver-how-to-roll-your-own-b010bbd73023).

Both of these sources will be updated once Grakn 2.0 will be out, so they can currently only serve as a first introduction to get an idea.

As we will receive updates about the project status of Grakn 2.0, we can move on with the translation.

The roadmap for 2.0 compatible clients is as follows (08.11.2020):

- client-java (soon to be released) 
- client-nodejs (next couple of weeks)
- client python (early december)

With a stable client as a reference, we can then start implementing things.

## Dependencies

The Python client itself does not depend on a lot of external libraries:

- [Protobuf](https://github.com/protocolbuffers/protobuf)
- [gRPC](https://grpc.io/)
- [six](https://github.com/benjaminp/six)

All other logic is inside the client itself and protobuf and gRPC are used for the connection to the Grakn Server.

That's why these [.proto files](https://github.com/graknlabs/protocol) need to be translated into Julia to make the connection work.

## How to start

Grakn suggested to start translating the Concept API.

You can read about it in the Grakn documentation [here](https://dev.grakn.ai/docs/concept-api/overview) 

It is about these files [in the repo](https://github.com/Humans-of-Julia/GraknClient.jl/tree/main/src/service/Session/Concept)

After we got that, it is adviced to wait for the Python Client 2.0, so we can plan things out.

For further questions about how to start, find us on [Discord](https://discord.gg/NSYrYZQRyv).

Feel free to create branches, pull requests, issues and all that is required.

Have Fun!

## Project status

The current project status can be seen on the [GitHub Project Kanban](https://github.com/Humans-of-Julia/GraknClient.jl/projects/1)

You can hopefully soon find open issues that need help as well.

## Useful sources

- [How I translate Python code into Julia code](https://stackoverflow.com/questions/59356818/how-i-translate-python-code-into-julia-code)

- [Python to Julia Quick translation / conversion reference Guide](https://gist.github.com/cuckookernel/9777067)

- [Client-Python tests](https://github.com/Humans-of-Julia/GraknClient.jl/tree/dev/client-python-reference/tests/integration)
- [Protobuf](https://github.com/protocolbuffers/protobuf)
- [gRPC](https://grpc.io/)
- [gRPC implementation introduction](https://scotch.io/tutorials/implementing-remote-procedure-calls-with-grpc-and-protocol-buffers)
- [OOPMacro.jl](https://github.com/ipod825/OOPMacro.jl)


```@autodocs
Modules = [GraknClient]
```