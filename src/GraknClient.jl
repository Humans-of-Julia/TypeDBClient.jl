module GraknClient

using PyCall
pyimport("pymodule.module")

function _init_()
    py"""
    from grakn.client import GraknClient


        """
end
end


