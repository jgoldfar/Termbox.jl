using Termbox

with_term() do
    for N in 1:4
        for row in 1:N
            for col in 1:N
                tb_change_cell(col, row, '#')
            end
        end
        tb_present()
        sleep(0.2)
    end
end
