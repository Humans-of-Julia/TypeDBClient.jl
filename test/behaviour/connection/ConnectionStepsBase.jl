# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE
using Behavior


using GraknClient

@given("connection has been opened") do context
    client = GraknClient.CoreClient("127.0.0.1",1729)
    context[:client] = client
end

@given("connection does not have any database") do context
    all_dbs = GraknClient.get_all_databases(context[:client])
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