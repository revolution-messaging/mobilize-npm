#coffee auth.coffee to execute
#automated coffee conversion of auth.js

login = ->
  credentials =
    username: user
    password: pass

  request
    method: "POST"
    url: "http://revolutionmsg.com/api/v1/authenticate"
    body: credentials
  , (error, response, body) ->
    console.log response.statusCode
    return

  return
request = require("request")
defaultHeaders = "Content-Type": "application/json"
request = request.defaults(
  jar: true
  headers: defaultHeaders
  json: true
)
user = "XXX"
pass = "XXX"

login()