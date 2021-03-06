using Termbox
@static if VERSION >= v"0.7-"
    using Test
    using Printf
else
    using Base.Test
end
using Compat

# write your own tests here
include("outputexample.jl")
outputexample.main(1e-1)

@test Termbox.tb_utf8_char_length(Char('r')) == 1

# Misc Tests
with_term() do
    tb_clear()
    tb_select_input_mode(TB_INPUT_ESC)
    tb_select_output_mode(TB_OUTPUT_NORMAL)

    tb_set_cursor(TB_HIDE_CURSOR, TB_HIDE_CURSOR)
    tb_set_clear_attributes(0x0001, 0x0000)

    e = tb_event()
    @test tb_peek_event(e, 1) == 0
    @show e
    c = tb_cell()
    @show c

    return nothing
end

# cellBuffer tests
with_term() do
    c = tb_cell('r', 0x0002, 0x0001)
    tb_select_input_mode(TB_INPUT_ESC)
    tb_select_output_mode(TB_OUTPUT_NORMAL)

    tb_set_clear_attributes(0x0001, 0x0000)
    tb_clear()

    tb_put_cell(3, 3, Ref(c))
    tb_put_cell(3, 4, Ref(c))
    tb_present()
    sleep(0.1)

    w = tb_width()
    h = tb_height()
    # "Native" index set for terminal
    CR = CartesianIndices((1:h, 1:w))

    # Linear version of above
    rs = reshape(LinearIndices(CR), size(CR))

    CB = tb_cell_buffer()
    if w>0 && h>0
        prevcInd = rs[3, 3]
        c1 = unsafe_load(CB, prevcInd)
        print(Char(c1.ch))

        tb_present()
    end
    CB = C_NULL # tb_present invalidates the pointer.
    sleep(0.1)
    # @show c
    return nothing
end

include("2048Example.jl")
CLI2048.main_wargames(5e-3)

include("graphExample.jl")
UpdatingGraph.main(5e-4)

include("sugar.jl")

function test_interactive()
    thisJulia = Base.JLOptions().julia_bin
    CLIFile=joinpath(dirname(@__FILE__), "2048Example.jl")
    @static if VERSION >= v"1.0-"
		p = open(`$(unsafe_string(thisJulia)) --code-coverage=user -L $(CLIFile) -e 'CLI2048.main_interactive()'`)    
    else
		s, p = open(`$(unsafe_string(thisJulia)) --code-coverage=user -L $(CLIFile) -e 'CLI2048.main_interactive()'`)
	end
    sleep(2)
    try
        process_exited(p) || kill(p)
        process_exited(p) || kill(p, 9) # SIGKILL
    finally
        kill(p, 9)
    end
end
test_interactive()
