using BinDeps

@BinDeps.setup

libtermbox = library_dependency("libtermbox", aliases=["termbox"])

provides(Sources,
         URI("https://bitbucket.org/jgoldfar/termbox-jl/downloads/termbox-master.tar.gz"),
         libtermbox)

# println(BinDeps.depsdir(libtermbox))
prefix = joinpath(BinDeps.depsdir(libtermbox), "usr")
srcdir = joinpath(BinDeps.depsdir(libtermbox), "src", "termbox-master")
# println("Installing TermBox source to ", srcdir)

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

@BinDeps.install [:libtermbox => :libtermbox]
