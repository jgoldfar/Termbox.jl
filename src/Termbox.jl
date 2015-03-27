# Termbox.jl: Wrapper around the Termbox library (https://github.com/nsf/termbox)
module Termbox
if isfile(joinpath(dirname(dirname(@__FILE__)), "deps", "deps.jl"))
  include(joinpath(dirname(dirname(@__FILE__)), "deps", "deps.jl"))
else
  error("Termbox not properly installed. Please run Pkg.build(\"Termbox\")")
end

include("termbox_h.jl")

end # module
