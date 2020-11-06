using GraknClient
using Documenter

makedocs(;
    modules=[GraknClient],
    authors="Human of Julia",
    repo="https://github.com/azzaare/GraknClient.jl/blob/{commit}{path}#L{line}",
    sitename="GraknClient.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://azzaare.github.io/GraknClient.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/azzaare/GraknClient.jl",
)
