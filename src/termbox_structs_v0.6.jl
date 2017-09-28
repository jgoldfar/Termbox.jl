#=  A cell, single conceptual entity on the terminal screen. The terminal screen
 * is basically a 2d array of cells. It has the following fields:
 *  - 'ch' is a unicode character
 *  - 'fg' foreground color and attributes
 *  - 'bg' background color and attributes
  =#
#=struct tb_cell {
	uint32_t ch;
	uint16_t fg;
	uint16_t bg;
};=#
export tb_cell
struct tb_cell
  ch::Cuint
  fg::Cushort
  bg::Cushort
  tb_cell() = new()
end

#=  This struct represents a termbox event. The 'mod', 'key' and 'ch' fields are
 * valid if 'type' is TB_EVENT_KEY. The 'w' and 'h' fields are valid if 'type'
 * is TB_EVENT_RESIZE. The 'x' and 'y' fields are valid if 'type' is
 * TB_EVENT_MOUSE.
  =#
#=struct tb_event {
  uint8_t type;
  uint8_t mod;
  uint16_t key;
  uint32_t ch;
  int32_t w;
  int32_t h;
  int32_t x;
  int32_t y;
  };=#
export tb_event
struct tb_event
  etype::Cuchar
  mod::Cuchar
  key::Cushort
  ch::Cuint
  w::Cint
  h::Cint
  x::Cint
  y::Cint
  tb_event() = new()
end