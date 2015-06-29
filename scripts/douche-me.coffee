# Description:
#   None
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot douche me
#
# Author:
#  Steve Ayers

douches = [
  ":gabo:"
]

module.exports = (robot) ->
  robot.hear /.*(douche me).*/i, (msg) ->
    msg.send msg.random douches
