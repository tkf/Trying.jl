using Documenter, Trying

makedocs(;
    modules=[Trying],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/tkf/Trying.jl/blob/{commit}{path}#L{line}",
    sitename="Trying.jl",
    authors="Takafumi Arakaki <aka.tkf@gmail.com>",
    assets=String[],
)

deploydocs(;
    repo="github.com/tkf/Trying.jl",
)
