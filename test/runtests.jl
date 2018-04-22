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

        e = tb_event()
        @test tb_peek_event(e, 1) == 0
        @show e
        c = tb_cell()
        @show c
    finally
        tb_shutdown()
    end
    return nothing
end
misc_TB_tests()

function cellBuffer_test()
    ret = tb_init()
    if ret != 0
        @printf stderr "tb_init() failed with error code %d\n" ret
        return 1
    end
    c = tb_cell('r', 0x0002, 0x0001)
    try
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
        rs = reshape(linearindices(CR), size(CR))

        CB = tb_cell_buffer()
        if w>0 && h>0
            prevcInd = rs[3, 3]
            c1 = unsafe_load(CB, prevcInd)
            print(Char(c1.ch))

            tb_present()
        end
        CB = C_NULL # tb_present invalidates the pointer.
        sleep(0.1)
    finally
        tb_shutdown()
    end
    # @show c
    return nothing
end
cellBuffer_test()

include("2048Example.jl")
CLI2048.main_wargames()

include("graphExample.jl")
UpdatingGraph.main()

function test_interactive()
    thisJulia = Base.JLOptions().julia_bin
    CLIFile=joinpath(dirname(@__FILE__), "2048Example.jl")
    p = open(`$(unsafe_string(thisJulia)) --code-coverage=user -L $(CLIFile) -e 'CLI2048.main_interactive()'`)
    sleep(2)
    try
        process_exited(p) || kill(p)
        @show process_exited(p)
    end
end
test_interactive()