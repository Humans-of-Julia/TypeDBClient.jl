# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE

using ExecutableSpecifications

@then "connection has been opened" do context
    @expect context[:cllient] !== nothing && is_open(context[:client])
end

@then "connection does not have any database" do context
    @expect length(get_all(databases(context[:client]))) == 0
end


#=
from behave import *

from tests.behaviour.context import Context


@step("connection has been opened")
def step_impl(context: Context):
    assert context.client and context.client.is_open()


@step("connection does not have any database")
def step_impl(context: Context):
    assert len(context.client.databases().all()) == 0

=#