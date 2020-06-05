# Package

version       = "0.1.0"
author        = "Jeff Sandberg"
description   = "Commandline pivotal tracker tools"
license       = "MIT"
srcDir        = "src"
bin           = @["pivotal"]
binDir        = "bin/"



# Dependencies

requires "nim >= 1.0.6, cligen >= 1.0.0 & < 1.1.0"

task upx, "Build minified binary":
  let args = "nimble build -d:release -y"
  exec args

  if findExe("upx") != "":
    echo "Running `upx --best`"
    exec "upx --best bin/pivotal"

  if findExe("sha256sum") != "":
    echo "Running `sha256sum`"
    exec "sha256sum bin/pivotal"
