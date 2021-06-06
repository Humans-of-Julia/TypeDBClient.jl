# TODO - should we just rename the Core* structs?
const Client = CoreClient
const Session = CoreSession
const Transaction = CoreTransaction
const Database = CoreDatabase
const DatabaseManager = CoreDatabaseManager

# general
export Client, Session, Transaction, Database, DatabaseManager
export TypeDBOptions

# concepts
export EntityType, RoleType, AttributeType, ThingType, RelationType
export Entity, Relation, Attribute, Thing
export ConceptManager
export as_remote, execute, instantiate
export get_instances, get_owns, get_owners, get_plays, get_rule, get_rules,
    get_subtypes, get_supertype, get_supertypes
export set_abstract, set_label, set_owns, set_plays, set_supertype
export unset_abstract
export VALUE_TYPE



