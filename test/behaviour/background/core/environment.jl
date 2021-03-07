# This file is a part of GraknClient.  License is MIT: https://github.com/Humans-of-Julia/GraknClient.jl/blob/main/LICENSE



#=
from tests.behaviour.background import environment_base
from grakn.client import GraknClient
from tests.behaviour.context import Context


IGNORE_TAGS = ["ignore", "ignore-client-python", "ignore-core"]


def before_all(context: Context):
    environment_base.before_all(context)
    context.client = GraknClient.core(address="localhost:%d" % int(context.config.userdata["port"]))


def before_scenario(context: Context, scenario):
    for tag in IGNORE_TAGS:
        if tag in scenario.effective_tags:
            scenario.skip("tagged with @" + tag)
            return
    environment_base.before_scenario(context, scenario)


def after_scenario(context: Context, scenario):
    environment_base.after_scenario(context, scenario)


def after_all(context: Context):
    environment_base.after_all(context)
=#