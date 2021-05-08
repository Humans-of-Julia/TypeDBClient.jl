# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE
g = TypeDBClient


# Scenario: create one database
@when("connection create database: alice") do context
    client = context[:client]
    db = g.create_database(client, "alice")
    @expect db === true
end

@then("connection has database: alice") do context
    result = g.contains_database(context[:client], "alice")
    @expect result === true
    #until beforescenario works for me :-) the following
    delete_all_databases(context[:client])
end

# Scenario: create many databases
@when("connection create databases:") do context
    db_names = context.datatable
    all_db = Bool[]
    for db in db_names
        push!(all_db, g.create_database(context[:client], db[1]))
    end
    @expect all(all_db) === true
end

@then("connection has databases:") do context
    db_names = [db[1] for db in context.datatable]
    server_dbs = [item.name for item in g.get_all_databases(context[:client])]

    @expect (Set(db_names) == Set(server_dbs))

    delete_all_databases(context[:client])
end

# Scenario: create many databases in parallel
@when("connection create databases in parallel:") do context
    db_names = context.datatable
    @sync @async for db in db_names
        g.create_database(context[:client], db[1])
    end
end

# Scenario: delete one database
@when("connection delete database: alice") do context
    g.delete_database(context[:client],"alice")
end

@then("connection does not have database: alice") do context
    @expect g.contains_database(context[:client], "alice") == false
end

# Scenario: connection can delete many databases
@when("connection delete databases:") do context
    db_names = [db[1] for db in context.datatable]
    for db in db_names
        g.delete_database(context[:client], db)
    end
end

@then("connection does not have databases:") do context
    db_names = [db[1] for db in context.datatable]
    db_there = Bool[]
    for db in db_names
        push!(db_there, g.contains_database(context[:client], db))
    end
    @expect all(db_there) !== true
end

# Scenario: delete many databases in parallel
@when("connection delete databases in parallel:") do context
    db_names = [db[1] for db in context.datatable]
    @sync @async for db in db_names
        g.delete_database(context[:client], db)
    end
    @expect isempty(g.get_all_databases(context[:client])) === true
end

# Scenario: delete a database causes open sessions to fail
@when("connection create database: typedb") do context
    g.create_database(context[:client], "typedb")
end

@when("connection open session for database: typedb") do context
    context[:session] = g.CoreSession(context[:client], "typedb" , g.Proto.Session_Type.SCHEMA, request_timout=Inf)
end

@when("connection delete database: typedb") do context
    g.delete_database(context[:client], "typedb")
end

@then("connection does not have database: typedb") do context
    @expect g.contains_database(context[:client], "typedb") === false
end

@then("session open transaction of type; throws exception: write") do context
    try
        transaction(context[:session], g.Proto.Transaction_Type[:READ])
    catch ex
        @info "if a database isn't there a transaction can't be open"
    end
end

##############  utility functions ########################
function delete_all_databases(client::TypeDBClient.CoreClient)
    all_db = g.get_all_databases(client)
    for db in all_db
        g.delete_database(client, db.name)
    end
end

#=
@when("connection create databases:") do context
    @fail "Implement me"
end


@then("connection has databases:") do context
    @fail "Implement me"
end


@when("connection create databases in parallel:") do context
    @fail "Implement me"
end


@when("connection delete database: alice") do context
    @fail "Implement me"
end


@then("connection does not have database: alice") do context
    @fail "Implement me"
end


@then("connection does not have any database") do context
    @fail "Implement me"
end


@when("connection delete databases:") do context
    @fail "Implement me"
end


@then("connection does not have databases:") do context
    @fail "Implement me"
end


@when("connection delete databases in parallel:") do context
    @fail "Implement me"
end


@when("connection create database: typedb") do context
    @fail "Implement me"
end


@when("connection open session for database: typedb") do context
    @fail "Implement me"
end


@when("connection delete database: typedb") do context
    @fail "Implement me"
end


@then("connection does not have database: typedb") do context
    @fail "Implement me"
end


@then("session open transaction of type; throws exception: write") do context
    @fail "Implement me"
end


@when("session opens transaction of type: write") do context
    @fail "Implement me"
end


@then("graql define; throws exception containing \"transaction has been closed\"") do context
    @fail "Implement me"
end


@when("connection delete database; throws exception: typedb") do context
    @fail "Implement me"
end


@given("connection has been opened") do context
    @fail "Implement me"
end

=#

#=

#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

from concurrent.futures.thread import ThreadPoolExecutor
from functools import partial
from typing import List

from behave import *
from hamcrest import *

from typedb.common.exception import TypeDBClientException
from tests.behaviour.config.parameters import parse_list
from tests.behaviour.context import Context
from tests.behaviour.util import assert_collections_equal


def create_databases(context: Context, names: List[str]):
    for name in names:
        context.client.databases().create(name)


@step("connection create database: {database_name}")
def step_impl(context: Context, database_name: str):
    create_databases(context, [database_name])


# TODO: connection create database(s) in other implementations, simplify
@step("connection create databases")
def step_impl(context: Context):
    names = parse_list(context.table)
    create_databases(context, names)


@step("connection create databases in parallel")
def step_impl(context: Context):
    names = parse_list(context.table)
    assert_that(len(names), is_(less_than_or_equal_to(context.THREAD_POOL_SIZE)))
    with ThreadPoolExecutor(max_workers=context.THREAD_POOL_SIZE) as executor:
        for name in names:
            executor.submit(partial(context.client.databases().create, name))


def delete_databases(context: Context, names: List[str]):
    for name in names:
        context.client.databases().get(name).delete()


@step("connection delete database: {name}")
def step_impl(context: Context, name: str):
    delete_databases(context, [name])


@step("connection delete databases")
def step_impl(context: Context):
    delete_databases(context, names=parse_list(context.table))


def delete_databases_throws_exception(context: Context, names: List[str]):
    for name in names:
        try:
            context.client.databases().get(name).delete()
            assert False
        except TypeDBClientException as e:
            pass


@step("connection delete database; throws exception: {name}")
def step_impl(context: Context, name: str):
    delete_databases_throws_exception(context, [name])


@step("connection delete databases; throws exception")
def step_impl(context: Context):
    delete_databases_throws_exception(context, names=parse_list(context.table))


@step("connection delete databases in parallel")
def step_impl(context: Context):
    names = parse_list(context.table)
    assert_that(len(names), is_(less_than_or_equal_to(context.THREAD_POOL_SIZE)))
    with ThreadPoolExecutor(max_workers=context.THREAD_POOL_SIZE) as executor:
        for name in names:
            executor.submit(partial(context.client.databases().get(name).delete))


def has_databases(context: Context, names: List[str]):
    assert_collections_equal([db.name() for db in context.client.databases().all()], names)


@step("connection has database: {name}")
def step_impl(context: Context, name: str):
    has_databases(context, [name])


@step("connection has databases")
def step_impl(context: Context):
    has_databases(context, names=parse_list(context.table))


def does_not_have_databases(context: Context, names: List[str]):
    databases = [db.name() for db in context.client.databases().all()]
    for name in names:
        assert_that(name, not_(is_in(databases)))


@step("connection does not have database: {name}")
def step_impl(context: Context, name: str):
    does_not_have_databases(context, [name])


@step("connection does not have databases")
def step_impl(context: Context):
    does_not_have_databases(context, names=parse_list(context.table))
=#
