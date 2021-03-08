# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE


using GraknClient
using ConceptMap
using ConceptMapGroup
using Numeric
using NumericGroup
using Concept
using Attribute, BooleanAttribute, LongAttribute, DoubleAttribute, StringAttribute, \
    DateTimeAttribute
using EntityType
using RelationType
using RoleType
using ThingType
using Type
using Session
using Transaction

using Test




#=
from concurrent.futures._base import Future
from typing import List, Union, Optional

import behave.runner
from behave.model import Table

from grakn.client import GraknClient
from grakn.concept.answer.concept_map import ConceptMap
from grakn.concept.answer.concept_map_group import ConceptMapGroup
from grakn.concept.answer.numeric import Numeric
from grakn.concept.answer.numeric_group import NumericGroup
from grakn.concept.concept import Concept
from grakn.concept.thing.attribute import Attribute, BooleanAttribute, LongAttribute, DoubleAttribute, StringAttribute, \
    DateTimeAttribute
from grakn.concept.thing.entity import Entity
from grakn.concept.thing.relation import Relation
from grakn.concept.thing.thing import Thing
from grakn.concept.type.attribute_type import AttributeType, BooleanAttributeType, LongAttributeType, \
    DoubleAttributeType, StringAttributeType, DateTimeAttributeType
from grakn.concept.type.entity_type import EntityType
from grakn.concept.type.relation_type import RelationType
from grakn.concept.type.role_type import RoleType
from grakn.concept.type.thing_type import ThingType
from grakn.concept.type.type import Type
from grakn.rpc.session import Session
from grakn.rpc.transaction import Transaction


AttributeSubtype: Attribute = Union[BooleanAttribute, LongAttribute, DoubleAttribute, StringAttribute, DateTimeAttribute]
ThingSubtype: Thing = Union[Entity, Relation, AttributeSubtype]
TypeSubtype: Type = Union[ThingType, EntityType, RelationType, RoleType, AttributeType, BooleanAttributeType, LongAttributeType, DoubleAttributeType, StringAttributeType, DateTimeAttributeType]
ConceptSubtype: Concept = Union[ThingSubtype, TypeSubtype]


class Config:
    """
    Type definitions for Config.

    This class should not be instantiated. The initialisation of the actual Config object occurs in environment.py.
    """
    def __init__(self):
        self.userdata = {}


class Context(behave.runner.Context):
    """
    Type definitions for Context.

    This class should not be instantiated. The initialisation of the actual Context object occurs in environment.py.
    """
    def __init__(self):
        self.table: Optional[Table] = None
        self.THREAD_POOL_SIZE = 0
        self.client: Optional[GraknClient] = None
        self.sessions: List[Session] = []
        self.sessions_to_transactions: dict[Session, List[Transaction]] = {}
        self.sessions_parallel: List[Future[Session]] = []
        self.sessions_parallel_to_transactions_parallel: dict[Future[Session], List[Transaction]] = {}
        self.things: dict[str, ThingSubtype] = {}
        self.answers: Optional[List[ConceptMap]] = None
        self.numeric_answer: Optional[Numeric] = None
        self.answer_groups: Optional[List[ConceptMapGroup]] = None
        self.numeric_answer_groups: Optional[List[NumericGroup]] = None
        self.config = Config()

    def tx(self) -> Transaction:
        return self.sessions_to_transactions[self.sessions[0]][0]

    def put(self, var: str, thing: ThingSubtype) -> None:
        pass

    def get(self, var: str) -> ThingSubtype:
        pass

    def clear_answers(self) -> None:
        pass

=#