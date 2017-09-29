using BinDeps
using Compat

@BinDeps.setup

const libtermbox = library_dependency("libtermbox", aliases=["termbox"])

provides(Sources,
         URI("https://github.com/nsf/termbox/archive/v1.1.0.tar.gz"),
         libtermbox,
         unpacked_dir = "termbox-1.1.0")

const prefix = joinpath(BinDeps.depsdir(libtermbox), "usr")
const srcdir = joinpath(BinDeps.depsdir(libtermbox), "src", "termbox-1.1.0")

provides(SimpleBuild, (@build_steps begin
                         GetSources(libtermbox)
                         CreateDirectory(srcdir)
                         @build_steps begin
                           ChangeDirectory(srcdir)
                           `./waf configure --prefix=$prefix`
                           `./waf`
                           `./waf install`
                         end
                       end),
         libtermbox,
         os = :Unix)

@BinDeps.install @compat Dict(:libtermbox => :libtermbox)
