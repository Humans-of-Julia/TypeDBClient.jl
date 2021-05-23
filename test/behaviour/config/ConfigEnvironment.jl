@afterscenario() do context, scenario
    delete_all_databases(context[:client])
end
