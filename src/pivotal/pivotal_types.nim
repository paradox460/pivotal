import json
type
  Story* = ref object
    ## Type for a pviotal story
    ## See `pivotal documentation <https://www.pivotaltracker.com/help/api/rest/v5#story_resource>_` for type descriptions
    ## Currently only a subset of fields are implemented, expand this as you need
    id*: int
    name*: string

proc toStory*(json: JsonNode): Story =
  json.to(Story)
