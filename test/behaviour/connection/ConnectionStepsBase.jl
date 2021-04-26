# This file is a part of TypeDBClient.  License is MIT: https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/main/LICENSE
using Behavior


using TypeDBClient

@given("connection has been opened") do context
    client = TypeDBClient.CoreClient("127.0.0.1",1729)
    context[:client] = client
end

@given("connection does not have any database") do context
    all_dbs = TypeDBClient.get_all_databases(context[:client])
    @expect length(all_dbs) != 0
end

#=

#from behave import *

from tests.behaviour.context import Context


@step("connection has been opened")
def step_impl(context: Context):
    assert context.client and context.client.is_open()


@step("connection does not have any database")
def step_impl(context: Context):
    assert len(context.client.databases().all()) == 0

=#