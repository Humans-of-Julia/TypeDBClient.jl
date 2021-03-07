# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE


#=
from behave import *
from behave.model_core import Status

from tests.behaviour.config.parameters import RootLabel
from tests.behaviour.context import Context, ThingSubtype

import time


def before_all(context: Context):
    context.THREAD_POOL_SIZE = 32


def before_scenario(context: Context, scenario):
    for database in context.client.databases().all():
        database.delete()
    context.sessions = []
    context.sessions_to_transactions = {}
    context.sessions_parallel = []
    context.sessions_to_transactions_parallel = {}
    context.sessions_parallel_to_transactions_parallel = {}
    context.tx = lambda: context.sessions_to_transactions[context.sessions[0]][0]
    context.things = {}
    context.get = lambda var: context.things[var]
    context.put = lambda var, thing: _put_impl(context, var, thing)
    context.get_thing_type = lambda root_label, type_label: _get_thing_type_impl(context, root_label, type_label)
    context.clear_answers = lambda: _clear_answers_impl(context)


def _put_impl(context: Context, variable: str, thing: ThingSubtype):
    context.things[variable] = thing


def _get_thing_type_impl(context: Context, root_label: RootLabel, type_label: str):
    if root_label == RootLabel.ENTITY:
        return context.tx().concepts().get_entity_type(type_label)
    elif root_label == RootLabel.ATTRIBUTE:
        return context.tx().concepts().get_attribute_type(type_label)
    elif root_label == RootLabel.RELATION:
        return context.tx().concepts().get_relation_type(type_label)
    else:
        raise ValueError("Unrecognised value")


def _clear_answers_impl(context: Context):
    context.answers = None
    context.numeric_answer = None
    context.answer_groups = None
    context.numeric_answer_groups = None


def after_scenario(context: Context, scenario):
    if scenario.status == Status.skipped:
        return

    #TODO: REMOVE THIS ONCE THE CRASHES ARE FIXED
    time.sleep(0.01)

    for session in context.sessions:
        session.close()
    for future_session in context.sessions_parallel:
        future_session.result().close()
    for database in context.client.databases().all():
        database.delete()


def after_all(context: Context):
    #TODO: REMOVE THIS ONCE THE CRASHES ARE FIXED
    time.sleep(0.01)

    context.client.close()

=#