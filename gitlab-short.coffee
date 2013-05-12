# Description:
#   Post gitlab related events using gitlab web hooks
#
# Dependencies:
#   "url" : ""
#   "querystring" : ""
#
# Configuration:
#   GITLAB_CHANNEL
#   GITLAB_DEBUG
#
#   Put http://<HUBOT_URL>:<PORT>/gitlab/web-short as your web hook (per repository)
#   You can also append "?targets=#room1,#room2" to the URL to control the
#   message destination.
#
# Commands:
#   None
#
# URLS:
#   /gitlab/short-web
#
# Author:
#   Rafał 'afterdesign' Malinowski

url = require 'url'
querystring = require 'querystring'

gitlabChannel = process.env.GITLAB_CHANNEL
debug = process.env.GITLAB_DEBUG?

module.exports = (robot) ->
    robot.router.post "/gitlab/short-web", (req, res) ->
        handler robot, req, res
        res.end ""

handler = (robot, req, res) ->
    query = querystring.parse(url.parse(req.url).query)
    hook = req.body

    if debug
      console.log('query', query)
      console.log('hook', hook)

    user = {}
    user.room = if query.targets then query.targets else gitlabChannel
    user.type = query.type if query.type

    message = ""
    branch = hook.ref.split("/")[2..].join("/")
    # if the ref before the commit is 00000, this is a new branch
    if /^0+$/.test(hook.before)
        message = "#{hook.user_name} pushed a new branch: [#{branch}]"
    else
        message = "#{hook.user_name} pushed #{hook.total_commits_count} commits to [#{branch}]"

    robot.send user, message