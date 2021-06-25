```@meta
CurrentModule = TypeDBClient
```
## Announcements

TypeDB 2.0 has been released, these are the highlights of the new version:

    Replaced Cassandra with RocksDB
    New Graph Storage Engine: replacing JanusGraph
    New TypeDB Type System: our Knowledge Representation
    New Graql: even simpler and more powerful
    New Traversal Engine: replacing TinkerPop/Gremlin
    New Query Planner: an Integer Linear Program
    New Reasoning Engine: based on Event Loop + Actor Model
    New Query Engine: an Asynchronous Producer-Consumer
    New Client-Server Protocol: a Reactive Stream
    New TypeDB Cluster: a Raft based distributed TypeDB
    New TypeDB Console: powered by PicoCLI + JLine
    New Benchmarking System: an Agent-based Simulation
    New Grabl CI/CD: replacing CircleCI

Read about it here in the [forum](https://forum.vaticle.com/t/introducing-typedb-typeql-and-vaticle/2418).


The TypeDB docs can be found here: [docs.typedb.ai](https://docs.vaticle.com/docs/general/quickstart).
## About

This is a community approach to translate a given client interface to the knowledge graph database **TypeDB** made by [Vaticle](https://vaticle.com/) into Julia Language.

Starting out as an educational project and to benefit the **Julia** ecosystem.

Please review the [user guide](http://0.0.0.0/guide.html) or if you'd like to help building the client, check the [contribution guidlines](http://0.0.0.0/contributing.html).

Feel free to join the project channel on the [Discord server](https://discord.gg/C5h9D4j), and take over a part in translating the given client reference into Julia.

> **TypeDB** is the knowledge graph engine to organise complex networks of data and making it queryable, by performing knowledge engineering. 
> Rooted in Knowledge Representation and Automated Reasoning, **TypeDB** provides the knowledge foundation for cognitive and intelligent (e.g. AI) systems, by providing an intelligent language for modelling,
> transactions and analytics. Being a distributed database, **TypeDB** is designed to scale over a network of computers through partitioning and replication.

## Highlights of TypeDB

> ##### Entity-Relationship #####
> - **TypeDB** allows you to model your domain using the well-known **Entity-Relationship model** at its full expressivity. 
> - It is composed of entity types, relationship types, and attribute types.
> - Unlike other modelling languages, **TypeDB** allows you to define type hierarchies, hyper-entities, hyper-relations, and rules to build rich knowledge models.   
>
> ##### Types #####
> - **TypeDB** provides to easily and quickly model type inheritance into the knowledge model. 
> - Following the object-oriented principle, this allows data types to inherit the behaviour and properties of their parent.
> - Like functions in programming, rules can chain themselves to one another, creating abstractions of behaviour at the data level.   
>
> ##### Rules #####
> - **TypeDB** allows you to define rules in your **knowledge schema**, which extends the expressivity of your model. 
> - It enables the system to derive new conclusions when a certain logical form in your dataset is satisfied.
> - Like functions in programming, that rules can chain itself to another, creating abstractions of behaviour at the data level.   
>
> ##### Inference #####
> - **TypeDB's inference facility** translates one query into all of its other interpretations. 
> - This happens through two mechanisms: type-based and rule-based inference.
> - Not only does this derive new conclusions and uncovers relationships that would otherwise be hidden, but it also enables the abstraction of complex patterns into simple queries.   
>
> ##### Analytics #####
> - **Distributed analytics** is a set of scalable algorithms that allows you to perform computation over large amounts of data in a distributed fashion. 
> - They tend to belong to the family of MapReduce or Pregel algorithms (BSP). Often, this requires the implementation of challenging algorithms.
> - In **TypeDB**, these distributed analytics algorithms are built-in as native functionalities of the language.   


## Credits

Credits go to the [Humans of Julia](https://github.com/Humans-of-Julia) organisation and the [TypeDB team](https://vaticle.com/). 

If you like to have a chat, you can find the Humans of Julia on Discord [here](https://discord.gg/NSYrYZQRyv).

Also if you like to join the TypeDB community, you can find them on Discord as well [here](https://discord.gg/HBJXnzRgmx).

## License

TypeDBClient.jl is licensed under the MIT License.

 The MIT License (MIT)

Copyright © 2021 Humans of Julia

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Some more details [here](https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/dev/LICENSE)

```@autodocs
Modules = [TypeDBClient]
```
