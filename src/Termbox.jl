# Termbox.jl: Wrapper around the Termbox library (https://github.com/nsf/termbox)
VERSION >= v"0.4.0-dev+6521" && __precompile__()
module Termbox
const depsfile = joinpath(dirname(dirname(@__FILE__)), "deps", "deps.jl")
if isfile(depsfile)
  include(depsfile)
else
  error("Termbox not properly installed. Please run Pkg.build(\"Termbox\")")
end

using Compat: Nothing
include("termbox_h.jl")

@static if VERSION >= v"0.7-"
    using Printf
end

export with_term
function with_term(f, args...)
    ret = tb_init()
    if ret != 0
        @printf stderr "tb_init() failed with error code %d\n" ret
        return 1
    end
    try
        f(args...)
    finally
        tb_shutdown()
    end
    return 0
end

end # module
