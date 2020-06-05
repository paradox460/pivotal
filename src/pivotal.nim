import cligen, osproc, sequtils, strformat, strutils, unicode
import pivotal/client, pivotal/pivotal_config

const NimblePkgVersion* {.strdefine.} = ""

proc pivotal(token: string, api_root: string = "https://www.pivotaltracker.com/services/v5", id: int, prefix: string) =
  let config = PivotalConfig(pivotal_token: token, root: api_root)
  let story = client.getStory(id, config)

  let branchTitle = unicode.toLower(story.name).replace(" ", "_")

  let branchName = @[prefix, &"#{story.id}", branchTitle].join("/")

  execCmd(&"git checkout -b {branchName}").quit()



when isMainModule:
  include cligen/mergeCfgEnv
  clCfg.version = NimblePkgVersion
  dispatch(pivotal, short = {"api_root" : '\0'}, help = {
    "token": "Pivotal tracker API token. Get it at https://www.pivotaltracker.com/profile",
    "api-root": "Change the pivotal tracker API root",
    "id": "Pivotal story you wish to use",
    "prefix": "Git branch name prefix"
  })
