using GraknClient
using Documenter

makedocs(;
    modules=[GraknClient],
    authors="Humas-of-Julia",
    repo="https://github.com/Humans-of-Julia/GraknClient.jl/blob/{commit}{path}#L{line}",
    sitename="GraknClient.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Humans-of-Julia.github.io/GraknClient.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Humans-of-Julia/GraknClient.jl",
)
