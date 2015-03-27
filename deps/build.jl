using BinDeps

@BinDeps.setup

libtermbox = library_dependency("libtermbox", aliases=["termbox"])

println(BinDeps.depsdir(libtermbox))
prefix = joinpath(BinDeps.depsdir(libtermbox), "usr")
srcdir = joinpath(BinDeps.depsdir(libtermbox), "src")
println("Installing TermBox source to ", srcdir)

provides(SimpleBuild, (@build_steps begin
                         `rm -rf $srcdir`
                         `git clone git@github.com:nsf/termbox.git $srcdir`
                         CreateDirectory(srcdir)
                         @build_steps begin
                           ChangeDirectory(srcdir)
                           `./waf configure --prefix=$prefix`
                           `./waf`
                           `./waf install`
                         end
                       end), libtermbox, os=:Darwin)

provides(SimpleBuild, (@build_steps begin
                         `rm -rf $srcdir`
                         `git clone git@github.com:nsf/termbox.git $srcdir`
                         CreateDirectory(srcdir)
                         @build_steps begin
                           ChangeDirectory(srcdir)
                           `./waf configure --prefix=$prefix`
                           `./waf`
                           `./waf install`
                         end
                       end), libtermbox, os=:Linux)

@BinDeps.install [:libtermbox => :libtermbox]
