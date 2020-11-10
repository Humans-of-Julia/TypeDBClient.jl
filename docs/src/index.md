```@meta
CurrentModule = GraknClient
```

# Documentation

## About

This is a community approach to translate a given client interface to the knowledge graph database **Grakn** made by [Grakn.ai](https://grakn.ai/) into Julia Language.

Starting out as an educational project and to benefit the **Julia** ecosystem.

Please review the [user guide](http://0.0.0.0/guide.html) or if you'd like to help building this the [contribution guidlines](http://0.0.0.0/contributing.html).

Feel free to join the project channel on the [Discord server](https://discord.gg/NSYrYZQRyv), and take over a part in translating the given client reference into Julia.

> **Grakn** is the knowledge graph engine to organise complex networks of data and making it queryable, by performing knowledge engineering. 
> Rooted in Knowledge Representation and Automated Reasoning, **Grakn** provides the knowledge foundation for cognitive and intelligent (e.g. AI) systems, by providing an intelligent language for modelling,
> transactions and analytics. Being a distributed database, **Grakn** is designed to scale over a network of computers through partitioning and replication.

## Highlights of Grakn

> ##### Entity-Relationship #####
> - **Grakn** allows you to model your domain using the well-known **Entity-Relationship model** at its full expressivity. 
> - It is composed of entity types, relationship types, and attribute types.
> - Unlike other modelling languages, **Grakn** allows you to define type hierarchies, hyper-entities, hyper-relations, and rules to build rich knowledge models.   
>
> ##### Types #####
> - **Grakn** provides to easily and quickly model type inheritance into the knowledge model. 
> - Following the object-oriented principle, this allows data types to inherit the behaviour and properties of their parent.
> - Like functions in programming, rules can chain themselves to one another, creating abstractions of behaviour at the data level.   
>
> ##### Rules #####
> - **Grakn** allows you to define rules in your **knowledge schema**, which extends the expressivity of your model. 
> - It enables the system to derive new conclusions when a certain logical form in your dataset is satisfied.
> - Like functions in programming, that rules can chain itself to another, creating abstractions of behaviour at the data level.   
>
> ##### Inference #####
> - **Grakn's inference facility** translates one query into all of its other interpretations. 
> - This happens through two mechanisms: type-based and rule-based inference.
> - Not only does this derive new conclusions and uncovers relationships that would otherwise be hidden, but it also enables the abstraction of complex patterns into simple queries.   
>
> ##### Analytics #####
> - **Distributed analytics** is a set of scalable algorithms that allows you to perform computation over large amounts of data in a distributed fashion. 
> - They tend to belong to the family of MapReduce or Pregel algorithms (BSP). Often, this requires the implementation of challenging algorithms.
> - In **Grakn**, these distributed analytics algorithms are built-in as native functionalities of the language.   


## Credits

Credits go to the [Humans of Julia](https://github.com/Humans-of-Julia) organisation and the [Grakn team](https://grakn.ai/). 

If you like to have a chat, you can find the Humans of Julia on Discord [here](https://discord.gg/NSYrYZQRyv).

Also if you like to join the Grakn community, you can find them on Discord as well [here](https://discord.gg/HBJXnzRgmx).

## Licence

```@index
```
GraknClient.jl is licensed under the MIT. 
For more details click [here](https://github.com/Humans-of-Julia/GraknClient.jl/blob/dev/LICENSE)

```@autodocs
Modules = [GraknClient]
```
