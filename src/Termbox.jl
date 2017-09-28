# Termbox.jl: Wrapper around the Termbox library (https://github.com/nsf/termbox)
module Termbox
const depsfile = joinpath(dirname(dirname(@__FILE__)), "deps", "deps.jl")
if isfile(depsfile)
  include(depsfile)
else
  error("Termbox not properly installed. Please run Pkg.build(\"Termbox\")")
end

using Compat
include("termbox_h.jl")

end # module
