# Command-Line 2048 Example
module CLI2048

using Termbox
using Compat
if VERSION >= v"0.7-"
    using Random
    using Printf
end

const Grid = Matrix

function Base.show(io::IO, g::Grid)
    n = size(g, 1)
    for row in 1:n
        for col in 1:(n-1)
            print(io, g[row, col], '\t')
        end
        print(io, g[row, n], '\n')
    end
end

newGrid(n::Int = 4, T = Int) = zeros(T, n, n)

function randomGrid(n::Int = 4, numNZ::Integer = 2, NonzeroElements::Vector{T} = [2,4]) where {T}
    randomGrid(newGrid(n, T), numNZ, NonzeroElements)
end
function randomGrid(grid::Grid{T}, numNZ::Integer = 2, NonzeroElements::Vector{T} = [2,4]) where {T}
    nGrid = length(grid)
    for ind in randperm(nGrid)[1:numNZ]
        grid[ind] = rand(NonzeroElements)
    end
    grid
end
zeroElements(g::Grid) = findall([gv == 0 for gv in g])
function randomGrid!(grid::Grid{T}, numNZ::Integer = 2, NonzeroElements::Vector{T} = [2,4]) where {T}
    inds = shuffle(zeroElements(grid))[1:numNZ]
    for ind in inds
        grid[ind] = rand(NonzeroElements)
    end
end

#TODO: Move asserts into some kind of test function
v1 = newGrid(4, Int)
@assert length(v1) == 4*4
@assert sum(v1) == 0
v1Rand = randomGrid(v1)
@assert size(v1Rand) == size(v1)
@assert sum(v1Rand) >= 2*2
v2 = randomGrid()
@assert sum(v2) >= 2*2
v3 = randomGrid(4, 3, [2,])
@assert sum(v3) == 3*2


# Functions to complete a single move in one direction
# NOTE: Output from below can be generated ahead of time and cached.
function compactLeft!(v::AbstractVector{T}, n) where {T}
    row = zeros(T, n)
    p = 1
    for (i, vi) in enumerate(v)
        if vi != 0
            row[p] = vi
            p += 1
        end
    end
    for i in eachindex(v)
        v[i] = row[i]
    end
end
function mergeLeft!(v::AbstractVector{T}, diffRef) where {T}
    n = length(v)
    compactLeft!(v, n)
    for i in 1:(n-1)
        vi = v[i]
        vip = v[i + 1]
        if vip == vi
            diffRef[] += vi
            v[i] *= 2
            v[i+1] = 0
        end
    end
    compactLeft!(v, n)
    v
end

function move!(g::Grid, dir::Val{:left}, scoreDiffRef)
    n = size(g, 1)
    for row in 1:n
        mergeLeft!(view(g, row, :), scoreDiffRef)
    end
end
function move!(g::Grid, dir::Val{:right}, scoreDiffRef)
    n = size(g, 1)
    for row in 1:n
        reverse!(mergeLeft!(reverse!(view(g, row, :)), scoreDiffRef))
    end
end
function move!(g::Grid, dir::Val{:up}, scoreDiffRef)
    n = size(g, 1)
    for col in 1:n
        mergeLeft!(view(g, :, col), scoreDiffRef)
    end
end
function move!(g::Grid, dir::Val{:down}, scoreDiffRef)
    n = size(g, 1)
    for col in 1:n
        reverse!(mergeLeft!(reverse!(view(g, :, col)), scoreDiffRef))
    end
end

# Termbox GUI
function putchar(k, i, c)
    tb_change_cell(k, i, c, 0x0001, 0x0000)
end

#TODO: Refactor interface below into boxes
function tb_print(g::Grid, numWidth::Int = 4)
    tb_clear()
    n = size(g, 1)
    rowCounter = 1
    for row in 1:n
        for i in 1:(n*(numWidth+4)+1)
            putchar(i, rowCounter, '#')
        end
        rowCounter += 1
        colCounter = 1
        for col in 1:n
            putchar(colCounter, rowCounter, '#')
            colCounter += 2 + numWidth + 2
            putchar(colCounter, rowCounter, '#')
        end
        rowCounter += 1
        colCounter = 1
        for col in 1:n
            colCounter += 2
            for (i, c) in enumerate(rpad(sprint(show, g[row, col]), numWidth))
                putchar(colCounter, rowCounter, c)
                colCounter += 1
            end
            colCounter += 2
            putchar(colCounter, rowCounter, '#')
        end
        rowCounter += 1
        colCounter = 1
        for col in 1:n
            putchar(colCounter, rowCounter, '#')
            colCounter += 2 + numWidth + 2
            putchar(colCounter, rowCounter, '#')
        end
        rowCounter += 1
    end
    for i in 1:(n*(numWidth+4)+1)
        putchar(i, rowCounter, '#')
    end
end

function handle_char!(c, g)
    if c == Int('r')
        fill!(g, 0)
        randomGrid!(g)
        tb_clear()
    end
end
function handle_key!(k, g)
    scorediff = Ref(0)
    if k == TB_KEY_ARROW_LEFT
        move!(g, Val(:left), scorediff)
    elseif k == TB_KEY_ARROW_RIGHT
        move!(g, Val(:right), scorediff)
    elseif k == TB_KEY_ARROW_UP
        move!(g, Val(:up), scorediff)
    elseif k == TB_KEY_ARROW_DOWN
        move!(g, Val(:down), scorediff)
    end
    if isempty(zeroElements(g))
        return -1
    end
    if scorediff[] >= 0
        randomGrid!(g, 1)
    end
    return scorediff[]
end
function main_interactive_loop(boardSize::Int = 4)
    do_loop = true
    score = 0
    # g = newGrid(4)
    # g[2, 1] = 2
    # g[2, 2] = 2

    g = randomGrid(boardSize)

    tb_print(g)
    tb_present()
    while do_loop
        ev = tb_event()
        while tb_poll_event(ev) != 0
            if ev.etype == TB_EVENT_KEY
                if ev.key == TB_KEY_ESC
                    do_loop = false
                    break
                elseif ev.key == 0
                    handle_char!(ev.ch, g)
                else
                    scorediff = handle_key!(ev.key, g)
                    if scorediff < 0
                        do_loop = false
                        break
                    end
                    score += scorediff
                end
            end #if
            tb_print(g)
            tb_present()
            tb_peek_event(ev, 0)
        end
    end
    score
end

function main_interactive(boardSize::Int = 4)
    ret = tb_init()
    if ret != 0
        @printf stderr "tb_init() failed with error code %d\n" ret
        return 1
    end
    score = 0
    try
        tb_clear()
        tb_select_input_mode(TB_INPUT_ESC)
        tb_select_output_mode(TB_OUTPUT_NORMAL)

        score += main_interactive_loop(boardSize)
    finally
        tb_shutdown()
    end
    @show score
    return 0
end

function main_wargames_loop(boardSize::Int = 4, maxMoves::Integer = 1000)
    score = 0
    moves = 0

    g = randomGrid(boardSize)

    tb_print(g)
    tb_present()
    while (moves < maxMoves)
        scorediff = handle_key!(rand([TB_KEY_ARROW_LEFT, TB_KEY_ARROW_RIGHT, TB_KEY_ARROW_DOWN, TB_KEY_ARROW_UP]), g)
        if scorediff < 0
            break
        end
        score += scorediff
        tb_print(g)
        tb_present()
        sleep(0.05)
        moves += 1
    end
    score
end

function main_wargames(boardSize::Int = 4)
    ret = tb_init()
    if ret != 0
        @printf stderr "tb_init() failed with error code %d\n" ret
        return 1
    end
    score = 0
    try
        tb_clear()
        tb_select_input_mode(TB_INPUT_ESC)
        tb_select_output_mode(TB_OUTPUT_NORMAL)

        score += main_wargames_loop(boardSize)
    finally
        tb_shutdown()
    end
    @show score
    return 0
end
# v2 = newGrid(4)
# v2[2, 1] = 2
# v2[2, 2] = 2
# println(v2)
# println(move!(v2, Val(:left)))
# println(v2)

end # module

# To use this interactively, run
# julia -L 2048Example.jl -e 'CLI2048.main_interactive()'
#
# To see a game played randomly (and quickly), run
# julia -L 2048Example.jl -e 'CLI2048.main_wargames()'
# The latter command is suitable for iteration on the code itself.
