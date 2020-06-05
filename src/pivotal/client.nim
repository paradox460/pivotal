import httpclient, json, strformat
import ./pivotal_types, ./pivotal_config

proc getStory*(id: int, config: PivotalConfig): Story =
  let client = newHttpClient()
  client.headers = newHttpHeaders({"X-TrackerToken": config.pivotal_token})
  var response = client.get(url = &"{config.root}/stories/{id}")
  if response.code != Http200:
    raise newException(HttpRequestError, &"Story fetch returned code {response.code}")
  return response.body.parseJson().toStory()
