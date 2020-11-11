using GraknClient
using Documenter


@info "Makeing documentation..."
makedocs(;
    modules=[GraknClient],
    authors="Humas-of-Julia",
    repo="https://github.com/Humans-of-Julia/GraknClient.jl/blob/{commit}{path}#L{line}",
    sitename="GraknClient.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Humans-of-Julia.github.io/GraknClient.jl",
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
    repo="github.com/Humans-of-Julia/GraknClient.jl.git",
    devbranch="main",
)
