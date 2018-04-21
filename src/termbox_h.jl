@static if VERSION >= v"0.6-"
  include("termbox_structs_v0.6.jl")
else
  include("termbox_structs_v0.5.jl")
end
#=  Key constants. See also struct tb_event's key field.
 *
 * These are a safe subset of terminfo keys, which exist on all popular
 * terminals. Termbox uses only them to stay truly portable.
  =#
export TB_KEY_F1, TB_KEY_F2, TB_KEY_F3, TB_KEY_F4, TB_KEY_F5, TB_KEY_F6, TB_KEY_F7, TB_KEY_F8, TB_KEY_F9, TB_KEY_F10, TB_KEY_F11, TB_KEY_F12
export TB_KEY_INSERT, TB_KEY_DELETE, TB_KEY_HOME, TB_KEY_END, TB_KEY_PGUP, TB_KEY_PGDN
export TB_KEY_ARROW_UP, TB_KEY_ARROW_DOWN, TB_KEY_ARROW_LEFT, TB_KEY_ARROW_RIGHT
export TB_KEY_MOUSE_LEFT, TB_KEY_MOUSE_RIGHT, TB_KEY_MOUSE_MIDDLE
const TB_KEY_F1 =            (0xFFFF-0)
const TB_KEY_F2 =            (0xFFFF-1)
const TB_KEY_F3 =            (0xFFFF-2)
const TB_KEY_F4 =            (0xFFFF-3)
const TB_KEY_F5 =            (0xFFFF-4)
const TB_KEY_F6 =            (0xFFFF-5)
const TB_KEY_F7 =            (0xFFFF-6)
const TB_KEY_F8 =            (0xFFFF-7)
const TB_KEY_F9 =            (0xFFFF-8)
const TB_KEY_F10 =           (0xFFFF-9)
const TB_KEY_F11 =           (0xFFFF-10)
const TB_KEY_F12 =           (0xFFFF-11)
const TB_KEY_INSERT =        (0xFFFF-12)
const TB_KEY_DELETE =        (0xFFFF-13)
const TB_KEY_HOME =          (0xFFFF-14)
const TB_KEY_END =           (0xFFFF-15)
const TB_KEY_PGUP =          (0xFFFF-16)
const TB_KEY_PGDN =          (0xFFFF-17)
const TB_KEY_ARROW_UP =      (0xFFFF-18)
const TB_KEY_ARROW_DOWN =    (0xFFFF-19)
const TB_KEY_ARROW_LEFT =    (0xFFFF-20)
const TB_KEY_ARROW_RIGHT =   (0xFFFF-21)
const TB_KEY_MOUSE_LEFT =    (0xFFFF-22)
const TB_KEY_MOUSE_RIGHT =   (0xFFFF-23)
const TB_KEY_MOUSE_MIDDLE =  (0xFFFF-24)

#=  These are all ASCII code points below SPACE character and a BACKSPACE key.  =#
export TB_KEY_CTRL_TILDE, TB_KEY_CTRL_2, TB_KEY_CTRL_A, TB_KEY_CTRL_B, TB_KEY_CTRL_C, TB_KEY_CTRL_D, TB_KEY_CTRL_E, TB_KEY_CTRL_F, TB_KEY_CTRL_G, TB_KEY_BACKSPACE, TB_KEY_CTRL_H, TB_KEY_TAB
const TB_KEY_CTRL_TILDE =        0x00
const TB_KEY_CTRL_2 =            0x00 #=  clash with 'CTRL_TILDE'  =#
const TB_KEY_CTRL_A =            0x01
const TB_KEY_CTRL_B =            0x02
const TB_KEY_CTRL_C =            0x03
const TB_KEY_CTRL_D =            0x04
const TB_KEY_CTRL_E =            0x05
const TB_KEY_CTRL_F =            0x06
const TB_KEY_CTRL_G =            0x07
const TB_KEY_BACKSPACE =         0x08
const TB_KEY_CTRL_H =            0x08 #=  clash with 'CTRL_BACKSPACE'  =#
const TB_KEY_TAB =               0x09
export TB_KEY_CTRL_I, TB_KEY_CTRL_J, TB_KEY_CTRL_K, TB_KEY_CTRL_L, TB_KEY_ENTER, TB_KEY_CTRL_M, TB_KEY_CTRL_N, TB_KEY_CTRL_O, TB_KEY_CTRL_P, TB_KEY_CTRL_Q, TB_KEY_CTRL_R, TB_KEY_CTRL_S, TB_KEY_CTRL_T, TB_KEY_CTRL_U, TB_KEY_CTRL_V, TB_KEY_CTRL_W, TB_KEY_CTRL_X, TB_KEY_CTRL_Y, TB_KEY_CTRL_Z
const TB_KEY_CTRL_I =            0x09 #=  clash with 'TAB'  =#
const TB_KEY_CTRL_J =            0x0A
const TB_KEY_CTRL_K =            0x0B
const TB_KEY_CTRL_L =            0x0C
const TB_KEY_ENTER =             0x0D
const TB_KEY_CTRL_M =            0x0D #=  clash with 'ENTER'  =#
const TB_KEY_CTRL_N =            0x0E
const TB_KEY_CTRL_O =            0x0F
const TB_KEY_CTRL_P =            0x10
const TB_KEY_CTRL_Q =            0x11
const TB_KEY_CTRL_R =            0x12
const TB_KEY_CTRL_S =            0x13
const TB_KEY_CTRL_T =            0x14
const TB_KEY_CTRL_U =            0x15
const TB_KEY_CTRL_V =            0x16
const TB_KEY_CTRL_W =            0x17
const TB_KEY_CTRL_X =            0x18
const TB_KEY_CTRL_Y =            0x19
const TB_KEY_CTRL_Z =            0x1A
export TB_KEY_ESC, TB_KEY_CTRL_LSQ_BRACKET, TB_KEY_CTRL_3, TB_KEY_CTRL_4, TB_KEY_CTRL_BACKSLASH, TB_KEY_CTRL_5, TB_KEY_CTRL_RSQ_BRACKET, TB_KEY_CTRL_6, TB_KEY_CTRL_7, TB_KEY_CTRL_SLASH, TB_KEY_CTRL_UNDERSCORE, TB_KEY_SPACE, TB_KEY_BACKSPACE2, TB_KEY_CTRL_8
const TB_KEY_ESC =               0x1B
const TB_KEY_CTRL_LSQ_BRACKET =  0x1B #=  clash with 'ESC'  =#
const TB_KEY_CTRL_3 =            0x1B #=  clash with 'ESC'  =#
const TB_KEY_CTRL_4 =            0x1C
const TB_KEY_CTRL_BACKSLASH =    0x1C #=  clash with 'CTRL_4'  =#
const TB_KEY_CTRL_5 =            0x1D
const TB_KEY_CTRL_RSQ_BRACKET =  0x1D #=  clash with 'CTRL_5'  =#
const TB_KEY_CTRL_6 =            0x1E
const TB_KEY_CTRL_7 =            0x1F
const TB_KEY_CTRL_SLASH =        0x1F #=  clash with 'CTRL_7'  =#
const TB_KEY_CTRL_UNDERSCORE =   0x1F #=  clash with 'CTRL_7'  =#
const TB_KEY_SPACE =             0x20
const TB_KEY_BACKSPACE2 =        0x7F
const TB_KEY_CTRL_8 =            0x7F #=  clash with 'DELETE'  =#

#=  These are non-existing ones.
 *
 * const TB_KEY_CTRL_1 clash with '1'
 * const TB_KEY_CTRL_9 clash with '9'
 * const TB_KEY_CTRL_0 clash with '0'
  =#

#=  Currently there is only one modifier. See also struct tb_event's mod
 * field.
  =#
const TB_MOD_ALT =  0x01

#=  Colors (see struct tb_cell's fg and bg fields).  =#
export TB_DEFAULT, TB_BLACK, TB_RED, TB_GREEN, TB_YELLOW, TB_BLUE, TB_MAGENTA, TB_CYAN, TB_WHITE
const TB_DEFAULT =  0x00
const TB_BLACK =    0x01
const TB_RED =      0x02
const TB_GREEN =    0x03
const TB_YELLOW =   0x04
const TB_BLUE =     0x05
const TB_MAGENTA =  0x06
const TB_CYAN =     0x07
const TB_WHITE =    0x08
export TB_COLORS
const TB_COLORS = [TB_DEFAULT,
                   TB_BLACK,
                   TB_RED,
                   TB_GREEN,
                   TB_YELLOW,
                   TB_BLUE,
                   TB_MAGENTA,
                   TB_CYAN,
                   TB_WHITE
                   ]
#=  Attributes, it is possible to use multiple attributes by combining them
 * using bitwise OR ('|'). Although, colors cannot be combined. But you can
 * combine attributes and a single color. See also struct tb_cell's fg and bg
 * fields.
  =#
export TB_BOLD, TB_UNDERLINE, TB_REVERSE
const TB_BOLD =       0x0100
const TB_UNDERLINE =  0x0200
const TB_REVERSE =    0x0400
const TB_ATTR = [0x0, TB_BOLD, TB_UNDERLINE, TB_REVERSE, TB_BOLD | TB_UNDERLINE]

export TB_EVENT_KEY, TB_EVENT_RESIZE, TB_EVENT_MOUSE
const TB_EVENT_KEY =     1
const TB_EVENT_RESIZE =  2
const TB_EVENT_MOUSE =   3

#=  Error codes returned by tb_init(). All of them are self-explanatory, except
 * the pipe trap error. Termbox uses unix pipes in order to deliver a message
 * from a signal handler (SIGWINCH) to the main event reading loop. Honestly in
 * most cases you should just check the returned code as < 0.
  =#
const TB_EUNSUPPORTED_TERMINAL = -1
const TB_EFAILED_TO_OPEN_TTY =   -2
const TB_EPIPE_TRAP_ERROR =      -3

#=  Initializes the termbox library. This function should be called before any
 * other functions. After successful initialization, the library must be
 * finalized using the tb_shutdown() function.
  =#
export tb_init, tb_shutdown
tb_init() = ccall((:tb_init, libtermbox), Cint,(),)
tb_shutdown() = ccall((:tb_shutdown, libtermbox), Void,(),)

#=  Returns the size of the internal back buffer (which is the same as
 * terminal's window size in characters). The internal buffer can be resized
 * after tb_clear() or tb_present() function calls. Both dimensions have an
 * unspecified negative value when called before tb_init() or after
 * tb_shutdown().
  =#
export tb_width, tb_height
tb_width() = ccall((:tb_width, libtermbox), Cint,(),)
tb_height() = ccall((:tb_height, libtermbox), Cint,(),)

#=  Clears the internal back buffer using TB_DEFAULT color or the
 * color/attributes set by tb_set_clear_attributes() function.
  =#
export tb_clear, tb_set_clear_attributes
tb_clear() = ccall((:tb_clear, libtermbox), Void,(),)
tb_set_clear_attributes(fg, bg) = ccall((:tb_set_clear_attributes, libtermbox), Void,(Cushort, Cushort), fg, bg)

#=  Synchronizes the internal back buffer with the terminal.  =#
export tb_present
tb_present() = ccall((:tb_present, libtermbox), Void,(),)

export TB_HIDE_CURSOR
const TB_HIDE_CURSOR =  -1

#=  Sets the position of the cursor. Upper-left character is (0, 0). If you pass
 * TB_HIDE_CURSOR as both coordinates, then the cursor will be hidden. Cursor
 * is hidden by default.
  =#
export tb_set_cursor
tb_set_cursor(cx, cy) = ccall((:tb_set_cursor, libtermbox), Void,(Cint, Cint), cx, cy)

#=  Changes cell's parameters in the internal back buffer at the specified
 * position.
  =#
export tb_put_cell, tb_change_cell
tb_put_cell(x, y, cell) = ccall((:tb_put_cell, libtermbox), Void,(Cint, Cint, Ptr{tb_cell}), x, y, cell)
tb_change_cell(x, y, ch, fg, bg) = ccall((:tb_change_cell, libtermbox), Void,(Cint, Cint, Cuint, Cushort, Cushort), x, y, ch, fg, bg)


#=  Copies the buffer from 'cells' at the specified position, assuming the
 * buffer is a two-dimensional array of size ('w' x 'h'), represented as a
 * one-dimensional buffer containing lines of cells starting from the top.
 *
 * (DEPRECATED: use tb_cell_buffer() instead and copy memory on your own)
  =#
export tb_blit
tb_blit(x, y, w, h, cell) = ccall((:tb_blit, libtermbox), Void,(Cint, Cint, Cint, Cint, Ptr{tb_cell}), x, y, w, h, cells)

#=  Returns a pointer to internal cell back buffer. You can get its dimensions
 * using tb_width() and tb_height() functions. The pointer stays valid as long
 * as no tb_clear() and tb_present() calls are made. The buffer is
 * one-dimensional buffer containing lines of cells starting from the top.
  =#
export tb_cell_buffer
tb_cell_buffer() = ccall((:tb_cell_buffer, libtermbox), Ptr{tb_cell}, ())

export TB_INPUT_CURRENT, TB_INPUT_ESC, TB_INPUT_ALT, TB_INPUT_MOUSE
const TB_INPUT_CURRENT =  0 #=  000  =#
const TB_INPUT_ESC =      1 #=  001  =#
const TB_INPUT_ALT =      2 #=  010  =#
const TB_INPUT_MOUSE =    4 #=  100  =#

#=  Sets the termbox input mode. Termbox has two input modes:
 * 1. Esc input mode.
 *    When ESC sequence is in the buffer and it doesn't match any known
 *    ESC sequence  = > ESC means TB_KEY_ESC.
 * 2. Alt input mode.
 *    When ESC sequence is in the buffer and it doesn't match any known
 *    sequence  = > ESC enables TB_MOD_ALT modifier for the next keyboard event.
 *
 * If 'mode' is TB_INPUT_CURRENT, it returns the current input mode.
  =#
export tb_select_input_mode
tb_select_input_mode(mode) = ccall((:tb_select_input_mode, libtermbox), Cint,(Cint,), mode)

export TB_OUTPUT_CURRENT, TB_OUTPUT_NORMAL, TB_OUTPUT_256, TB_OUTPUT_216, TB_OUTPUT_GRAYSCALE
const TB_OUTPUT_CURRENT =    0
const TB_OUTPUT_NORMAL =     1
const TB_OUTPUT_256 =        2
const TB_OUTPUT_216 =        3
const TB_OUTPUT_GRAYSCALE =  4

#=  Sets the termbox output mode. Termbox has three output options:
 * 1. TB_OUTPUT_NORMAL      = > [1..8]
 *    This mode provides 8 different colors:
 *      black, red, green, yellow, blue, magenta, cyan, white
 *    Shortcut: TB_BLACK, TB_RED, ...
 *    Attributes: TB_BOLD, TB_UNDERLINE, TB_REVERSE
 *
 *    Example usage:
 *        tb_change_cell(x, y, '@', TB_BLACK | TB_BOLD, TB_RED);
 *
 * 2. TB_OUTPUT_256         = > [0..256]
 *    In this mode you can leverage the 256 terminal mode:
 *    0x00 - 0x07: the 8 colors as in TB_OUTPUT_NORMAL
 *    0x08 - 0x0f: TB_* | TB_BOLD
 *    0x10 - 0xe7: 216 different colors
 *    0xe8 - 0xff: 24 different shades of grey
 *
 *    Example usage:
 *        tb_change_cell(x, y, '@', 184, 240);
 *        tb_change_cell(x, y, '@', 0xb8, 0xf0);
 *
 * 2. TB_OUTPUT_216         = > [0..216]
 *    This mode supports the 3rd range of the 256 mode only.
 *    But you don't need to provide an offset.
 *
 * 3. TB_OUTPUT_GRAYSCALE   = > [0..23]
 *    This mode supports the 4th range of the 256 mode only.
 *    But you dont need to provide an offset.
 *
 * Execute build/src/demo/output to see its impact on your terminal.
 *
 * If 'mode' is TB_OUTPUT_CURRENT, it returns the current output mode.
  =#
export tb_select_output_mode
tb_select_output_mode(mode) = ccall((:tb_select_output_mode, libtermbox), Cint,(Cint,), mode)

#=  Wait for an event up to 'timeout' milliseconds and fill the 'event'
 * structure with it, when the event is available. Returns the type of the
 * event (one of TB_EVENT_* constants) or -1 if there was an error or 0 in case
 * there were no event during 'timeout' period.
  =#
export tb_peek_event
tb_peek_event(event, timeout = 0) = ccall((:tb_peek_event, libtermbox), Cint,(Ref{tb_event},Cint), event, timeout)

#=  Wait for an event forever and fill the 'event' structure with it, when the
 * event is available. Returns the type of the event (one of TB_EVENT_*
 * constants) or -1 if there was an error.
  =#
export tb_poll_event
tb_poll_event(event) = ccall((:tb_poll_event, libtermbox), Cint,(Ref{tb_event},), event)

#=  Utility utf8 functions.  =#
const TB_EOF =  -1
tb_utf8_char_length(c) = ccall((:tb_utf8_char_length, libtermbox), Cint,(Cchar,), c)
# SO_IMPORT int tb_utf8_char_length(char c);
tb_utf8_char_to_unicode(out, c) = ccall((:tb_utf8_char_to_unicode, libtermbox), Cint,(Ptr{Cuint}, Ptr{Cchar}), out, c)
# SO_IMPORT int tb_utf8_char_to_unicode(uint32_t *out, const char *c);
tb_utf8_unicode_to_char(out, c) = ccall((:tb_utf8_unicode_to_char, libtermbox), Cint,(Ptr{Cchar}, Cuint), out, c)
# SO_IMPORT int tb_utf8_unicode_to_char(char *out, uint32_t c);
