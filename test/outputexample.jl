# outputexample.jl
module outputexample
using Termbox
using Compat
@static if VERSION >= v"0.7-"
    using Printf
end

const chars = "nnnnnnnnnbbbbbbbbbuuuuuuuuuBBBBBBBBB"
const all_attrs = [0, TB_BOLD, TB_UNDERLINE, TB_BOLD | TB_UNDERLINE,]
function next_char(current::Int)
  current += 1
  if current >= length(chars) || current < 1
    current = 1
  end
  return current
end

function draw_line(x, y, bg)
  current_char = 1
  for a in all_attrs
    for c in TB_COLORS
      fg = a | c
      tb_change_cell(x, y, chars[current_char], fg, bg)
      current_char = next_char(current_char)
      x += 1
    end
  end
end
function print_combinations_table(sx, sy, attr)
  for c in TB_COLORS
    bg = attr | c
    draw_line(sx, sy, bg)
    sy += 1
  end
end
function draw_all()
  tb_clear()
  tb_select_output_mode(TB_OUTPUT_NORMAL)

  print_combinations_table(1, 1, 0x0)
  print_combinations_table(2 + length(chars), 1, TB_BOLD)

  print_combinations_table(1, 2 + length(TB_COLORS), TB_REVERSE)

  tb_present()

  tb_select_output_mode(TB_OUTPUT_GRAYSCALE)
  y = 3 + 2 * length(TB_COLORS)
  for x in 0:23
    tb_change_cell(x, y, '@', x, 0);
    tb_change_cell(x + 25, y, ' ', 0, x);
  end
  tb_present()

  tb_select_output_mode(TB_OUTPUT_216)
  y += 1
  x = 1
  for c in 0:215
      tb_change_cell(x, y, '@', c, 0);
      tb_change_cell(x + 26, y, ' ', 0, c);
    x += 1
    if mod(x, 24) == 0
      x = 0
      y += 1
    end
  end
  tb_present()

  tb_select_output_mode(TB_OUTPUT_256)
  y += 1
  x = 1
  for c in 0:255
      (mod(y, 2) == 0) && (c = c | TB_UNDERLINE)
      tb_change_cell(x, y, '+', c, 0)
      tb_change_cell(x + 26, y, ' ', 0, c)
    x += 1
    if mod(x, 24) == 0
      x = 0
      y += 1
    end
  end
  tb_present()
end
function main()
  ret = tb_init()
  if ret != 0
    @printf stderr "tb_init() failed with error code %d\n" ret
    return 1
  end

  draw_all()

  sleep(1)
  # ev = tb_event()
  # while tb_poll_event(ev) != 0
  #   (ev.etype == TB_EVENT_KEY && ev.key == TB_KEY_ESC) && break
  #   if ev.etype == TB_EVENT_RESIZE
  #     draw_all()
  #   end #if
  # end #while
  tb_present()
  tb_shutdown()
  return 0
end # main

function demo_takeover()
  tb_init()
  if ret != 0
    @printf stderr "tb_init() failed with error code %d\n" ret
    return 1
  end
  println("Taking over terminal...")
  println("Height: ", tb_height())
  println("Width: ", tb_width())
  sleep(2)
  tb_shutdown()
end
end # module
