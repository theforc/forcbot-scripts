# Description:
#   Robot is very threatening
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot threaten me
#   hubot threaten name
#   hubot threaten all
#
# Author:
#	Steve Ayers

remarks = [
  "STFU, %.",
  "GFY, %.",
  "Fight me, %"
]
allinclusive = [
  "I will kick your collective asses"
]

module.exports = (robot) ->
  robot.respond /(threaten )(.*)/i, (msg) ->
    threaten = msg.random remarks

    threateningme = () -> msg.send threaten.replace "%", msg.message.user.name
    threateningyou = () -> msg.send threaten.replace "%", msg.match[2]

    if msg.match[2] == 'me'
      threateningme()
    else if msg.match[2] == 'all'
      msg.send msg.random allinclusive
    else
      threateningyou()
