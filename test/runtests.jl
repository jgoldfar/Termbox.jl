using Termbox
@static if VERSION >= v"0.7-"
    using Test
else
    using Base.Test
end

# write your own tests here
include("outputexample.jl")
outputexample.main()

include("2048Example.jl")
CLI2048.main_wargames()

include("graphExample.jl")
UpdatingGraph.main()