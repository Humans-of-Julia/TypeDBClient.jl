module GraknClient



end

ENV["PYTHON"] = "/Users/mks/.pyenv/shims/python"



Conda.pip_interop(true, "/Users/mks/.pyenv/versions/miniconda3-4.6.14")


Conda.pip("install", "grakn-client")



ENV["PYTHON"] = "/Users/mks/.pyenv/versions/3.7.8/bin/python3.7"



# /Users/mks/.pyenv/versions/miniconda3-4.6.14

# pyenv install --list


ENV["CONDA_JL_HOME"] = "/Users/mks/.pyenv/versions/miniconda3-4.6.14" 

Conda.pip_interop(true, "/Users/mks/.pyenv/versions/miniconda3-4.6.14")

pyimport_conda("grakn-client", "/Users/mks/.pyenv/versions/miniconda3-4.6.14")


/Users/mks/dev/GraknClient.jl/.venv/bin/python


ENV["PYCALL_JL_RUNTIME_PYTHONHOME"] = "/Users/mks/.pyenv/shims/python"


/Users/mks/.pyenv/versions/3.7.9

env VIRTUALENV_PYTHON=/Users/mks/.pyenv/shims/python virtualenv

virtualenv --python=/Users/mks/.pyenv/versions/3.7.9/Python.framework/Versions/3.7/Python --python=python3.7
virtualenv --extra-search-dir=/Users/mks/.pyenv/versions/3.7.9/