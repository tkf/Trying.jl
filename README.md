# Trying

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://tkf.github.io/Trying.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://tkf.github.io/Trying.jl/dev)
[![Build Status](https://travis-ci.com/tkf/Trying.jl.svg?branch=master)](https://travis-ci.com/tkf/Trying.jl)
[![Codecov](https://codecov.io/gh/tkf/Trying.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/tkf/Trying.jl)
[![Coveralls](https://coveralls.io/repos/github/tkf/Trying.jl/badge.svg?branch=master)](https://coveralls.io/github/tkf/Trying.jl?branch=master)

## Example

```julia
julia> using Trying

julia> @try ones(1, 1) / zeros(1, 1)
[ Info: Error thrown is available at `Trying.ERRORS[end]`.
ERROR: LinearAlgebra.SingularException(1)
Stacktrace:
 [1] ldiv!(::LinearAlgebra.Diagonal{Float64,Array{Float64,1}}, ::Array{Float64,2}) at /.../LinearAlgebra/src/diagonal.jl:569
 [2] ...

julia> Trying.ERRORS
1-element Array{Trying.ErrorRecord,1}:
 ones(1, 1) / zeros(1, 1) threw SingularException

julia> Trying.ERRORS[end]
ErrorRecord
Trying to evaluate expression:
ones(1, 1) / zeros(1, 1)

Error thrown:
LinearAlgebra.SingularException(1)
Stacktrace:
 [1] ldiv!(::LinearAlgebra.Diagonal{Float64,Array{Float64,1}}, ::Array{Float64,2}) at /.../LinearAlgebra/src/diagonal.jl:569
 [2] ...
```
