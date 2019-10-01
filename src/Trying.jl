module Trying

export @try

"""
    @try expression

Evaluate `expression` and return the result.  If it throws an error,
record the exception and backtrace in `Trying.ERRORS`.
"""
:(@try)

using Parameters

struct ErrorRecord
    expression
    exception
    backtrace
end

function Base.show(io::IO, rec::ErrorRecord)
    if get(io, :limit, false)
        printstyled(io, rec.expression; color=:blue)
        print(io, " threw ")
        err = sprint(
            summary,
            rec.exception,
            context = IOContext(io, :module => parentmodule(typeof(rec.exception))),
        )
        printstyled(io, err; color=:red)
    else
        invoke(show, Tuple{IO, Any}, io, rec)
    end
    return
end

function Base.show(io::IO, ::MIME"text/plain", rec::ErrorRecord)
    println(io, "ErrorRecord")
    printstyled(io, "Trying to evaluate expression:"; color=:blue)
    println(io)
    println(io, rec.expression)
    println(io)
    printstyled(io, "Error thrown:"; color=:blue)
    println(io)
    showerror(io, rec.exception, rec.backtrace)
end

"""
    Trying.ERRORS :: Vector{ErrorRecord}

Record of last `Trying.CONFIG.max_errors` errors.
"""
const ERRORS = ErrorRecord[]

@with_kw mutable struct TryingConfig
    max_errors::Int = 10
end

"""
    Trying.CONFIG

# Properties
- `max_errors::Int = $(TryingConfig().max_errors)`:
  Number of errors to be stored in `Trying.ERRORS`.
"""
const CONFIG = TryingConfig()

function resize_errors()
    inds = 1:length(ERRORS) - CONFIG.max_errors - 1
    if !isempty(inds)
        deleteat!(ERRORS, inds)
    end
    return
end

record_error(args...) = push!(ERRORS, ErrorRecord(args...))

function try_impl(ex)
    quote
        resize_errors()
        try
            $(esc(ex))
        catch exception
            record_error($(QuoteNode(ex)), exception, catch_backtrace())
            @info "Error thrown is available at `Trying.ERRORS[end]`."
            rethrow()
        end
    end
end

@eval macro $(:try)(ex)
    try_impl(ex)
end

end # module
