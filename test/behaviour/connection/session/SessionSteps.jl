@given("connection open schema session for database: typedb") do context
    @fail "Implement me"
end

@given("connection close all sessions") do context
    @fail "Implement me"
end


@given("connection open data session for database: typedb") do context
    @fail "Implement me"
end

#=

from concurrent.futures.thread import ThreadPoolExecutor
from functools import partial
from typing import List

from behave import *
from hamcrest import *

from typedb.api.session import SessionType
from tests.behaviour.config.parameters import parse_bool, parse_list
from tests.behaviour.context import Context


SCHEMA = SessionType.SCHEMA
DATA = SessionType.DATA


def open_sessions_for_databases(context: Context, names: list, session_type=DATA):
    for name in names:
        context.sessions.append(context.client.session(name, session_type))


@step("connection open schema session for database: {database_name}")
def step_impl(context: Context, database_name):
    open_sessions_for_databases(context, [database_name], SCHEMA)


@step("connection open data session for database: {database_name}")
@step("connection open session for database: {database_name}")
def step_impl(context: Context, database_name: str):
    open_sessions_for_databases(context, [database_name], DATA)


@step("connection open schema session for database")
@step("connection open schema session for databases")
@step("connection open schema sessions for database")
@step("connection open schema sessions for databases")
def step_impl(context: Context):
    names = parse_list(context.table)
    open_sessions_for_databases(context, names, SCHEMA)


@step("connection open data session for database")
@step("connection open data session for databases")
@step("connection open data sessions for database")
@step("connection open data sessions for databases")
@step("connection open session for database")
@step("connection open session for databases")
@step("connection open sessions for database")
@step("connection open sessions for databases")
def step_impl(context: Context):
    names = parse_list(context.table)
    open_sessions_for_databases(context, names, DATA)


@step("connection open data sessions in parallel for databases")
@step("connection open sessions in parallel for databases")
def step_impl(context: Context):
    names = parse_list(context.table)
    assert_that(len(names), is_(less_than_or_equal_to(context.THREAD_POOL_SIZE)))
    with ThreadPoolExecutor(max_workers=context.THREAD_POOL_SIZE) as executor:
        for name in names:
            context.sessions_parallel.append(executor.submit(partial(context.client.session, name, DATA)))


@step("connection close all sessions")
def step_impl(context: Context):
    for session in context.sessions:
        session.close()
    context.sessions = []


@step("session is null: {is_null}")
@step("sessions are null: {is_null}")
def step_impl(context: Context, is_null):
    is_null = parse_bool(is_null)
    for session in context.sessions:
        assert_that(session is None, is_(is_null))


@step("session is open: {is_open}")
@step("sessions are open: {is_open}")
def step_impl(context: Context, is_open):
    is_open = parse_bool(is_open)
    for session in context.sessions:
        assert_that(session.is_open(), is_(is_open))


@step("sessions in parallel are null: {is_null}")
def step_impl(context: Context, is_null):
    is_null = parse_bool(is_null)
    for future_session in context.sessions_parallel:
        assert_that(future_session.result() is None, is_(is_null))


@step("sessions in parallel are open: {is_open}")
def step_impl(context: Context, is_open):
    is_open = parse_bool(is_open)
    for future_session in context.sessions_parallel:
        assert_that(future_session.result().is_open(), is_(is_open))


def sessions_have_databases(context: Context, names: List[str]):
    assert_that(context.sessions, has_length(equal_to(len(names))))
    session_iter = iter(context.sessions)
    for name in names:
        assert_that(next(session_iter).database().name(), is_(name))


@step("session has database: {database_name}")
@step("sessions have database: {database_name}")
def step_impl(context: Context, database_name: str):
    sessions_have_databases(context, [database_name])


# TODO: session(s) has/have databases in other implementations, simplify
@step("sessions have databases")
def step_impl(context: Context):
    database_names = parse_list(context.table)
    sessions_have_databases(context, database_names)


@step("sessions in parallel have databases")
def step_impl(context: Context):
    database_names = parse_list(context.table)
    assert_that(context.sessions_parallel, has_length(equal_to(len(database_names))))
    future_session_iter = iter(context.sessions_parallel)
    for name in database_names:
        assert_that(next(future_session_iter).result().database().name(), is_(name))
=#
