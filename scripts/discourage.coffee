# Description:
#   Robot is very discouraging
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot discourage me
#   hubot discourage name
#   hubot discourage all
#
# Author:
#	Steve Ayers

remarks = [
  "You could do much better, %.  :(",
  "I'm shocked at how bad that was, %.",
  "Really, %?",
  "Maybe a change of careers would help, %?",
]
allinclusive = [
  "You guys are awful"
]

module.exports = (robot) ->
  robot.respond /(discourage )(.*)/i, (msg) ->
    discourage = msg.random remarks

    discouragingme = () -> msg.send discourage.replace "%", msg.message.user.name
    discouragingyou = () -> msg.send discourage.replace "%", msg.match[2]

    if msg.match[2] == 'me'
      discouragingme()
    else if msg.match[2] == 'all'
      msg.send msg.random allinclusive
    else
      discouragingyou()
