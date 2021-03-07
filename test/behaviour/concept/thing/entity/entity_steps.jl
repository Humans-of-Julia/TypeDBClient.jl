# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE



#=
from behave import *
from hamcrest import *

from grakn.common.exception import GraknClientException
from tests.behaviour.context import Context


@step("entity({type_label}) create new instance; throws exception")
def step_impl(context: Context, type_label: str):
    assert_that(calling(context.tx().concepts().get_entity_type(type_label).as_remote(context.tx()).create), raises(GraknClientException))


@step("{var:Var} = entity({type_label}) create new instance")
def step_impl(context: Context, var: str, type_label: str):
    context.put(var, context.tx().concepts().get_entity_type(type_label).as_remote(context.tx()).create())


@step("{var:Var} = entity({type_label}) create new instance with key({key_type}): {key_value}")
def step_impl(context: Context, var: str, type_label: str, key_type: str, key_value: str):
    key = context.tx().concepts().get_attribute_type(key_type).as_string().as_remote(context.tx()).put(key_value)
    entity = context.tx().concepts().get_entity_type(type_label).as_remote(context.tx()).create()
    entity.as_remote(context.tx()).set_has(key)
    context.put(var, entity)


@step("{var:Var} = entity({type_label}) get instance with key({key_type}): {key_value}")
def step_impl(context: Context, var: str, type_label: str, key_type: str, key_value: str):
    context.put(var, next((owner for owner in context.tx().concepts().get_attribute_type(key_type).as_string()
                          .as_remote(context.tx()).get(key_value).as_remote(context.tx()).get_owners()
                           if owner.get_type().get_label() == type_label), None))


@step("entity({type_label}) get instances contain: {var:Var}")
def step_impl(context: Context, type_label: str, var: str):
    assert_that(context.tx().concepts().get_entity_type(type_label).as_remote(context.tx()).get_instances(), has_item(context.get(var)))


@step("entity({type_label}) get instances is empty")
def step_impl(context: Context, type_label: str):
    assert_that(calling(next).with_args(context.tx().concepts().get_entity_type(type_label).as_remote(context.tx()).get_instances()), raises(StopIteration))
=#