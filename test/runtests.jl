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
outputexample.main()

function misc_TB_tests()
    ret = tb_init()
    if ret != 0
        @printf stderr "tb_init() failed with error code %d\n" ret
        return 1
    end
    try
        tb_clear()
        tb_select_input_mode(TB_INPUT_ESC)
        tb_select_output_mode(TB_OUTPUT_NORMAL)

        tb_set_cursor(TB_HIDE_CURSOR, TB_HIDE_CURSOR)
        tb_set_clear_attributes(0x0001, 0x0000)

        e=tb_event()
        @test tb_peek_event(e, 1) == 0
        @show e
    finally
        tb_shutdown()
    end
    return nothing
end
misc_TB_tests()

#TODO: add tests for tb_put_cell and tb_cell_buffer; tb_poll_event() may not be testable.

if VERSION >= v"0.6-"
    include("2048Example.jl")
    CLI2048.main_wargames()

    include("graphExample.jl")
    UpdatingGraph.main()
end
