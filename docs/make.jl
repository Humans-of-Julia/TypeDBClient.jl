using TypeDBClient
using Documenter


@info "Makeing documentation..."
makedocs(;
    modules=[TypeDBClient],
    authors="Humas-of-Julia",
    repo="https://github.com/Humans-of-Julia/TypeDBClient.jl/blob/{commit}{path}#L{line}",
    sitename="TypeDBClient.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Humans-of-Julia.github.io/TypeDBClient.jl",
        assets = ["assets/favicon.ico"; "assets/github_buttons.js"; "assets/custom.css"],
    ),
    pages=[
        "Home" => "index.md",
        "User Guide" => "guide.md",
        "Contributing" => "contributing.md",
        "Changelog" => "changelog.md",
        "API Reference" => "api.md"
    ],
)

deploydocs(;
    repo="github.com/Humans-of-Julia/TypeDBClient.jl.git",
    devbranch="main",
)
