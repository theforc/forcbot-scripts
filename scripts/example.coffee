# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.hear /badger/i, (res) ->
     res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"

   robot.respond /open the (.*) doors/i, (res) ->
     doorType = res.match[1]
     if doorType is "pod bay"
       res.reply "I'm afraid I can't let you do that."
     else
       res.reply "Opening #{doorType} doors"

   robot.hear /I like pie/i, (res) ->
     res.emote "makes a freshly baked pie"

   lulz = ['lol', 'rofl', 'lmao']

   robot.respond /lulz/i, (res) ->
     res.send res.random lulz

   robot.topic (res) ->
     res.send "#{res.message.text}? That's a Paddlin'"


   enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
   leaveReplies = ['Are you still there?', 'Target lost', 'Searching']

   robot.enter (res) ->
     res.send res.random enterReplies
   robot.leave (res) ->
     res.send res.random leaveReplies

   answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING

   robot.respond /what is the answer to the ultimate question of life/, (res) ->
     unless answer?
       res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
       return
     res.send "#{answer}, but what is the question?"

   robot.respond /you are a little slow/, (res) ->
     setTimeout () ->
       res.send "Who you calling 'slow'?"
     , 60 * 1000

   annoyIntervalId = null

   robot.respond /annoy (.*)/, (res) ->
     name = res.match[1]

     if annoyIntervalId
       res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
       return

     res.send "Hey, #{name} want to hear the most annoying sound in the world?"
     annoyIntervalId = setInterval () ->
       res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
     , 1000

   # Happy Birthday
   robot.respond /wish (.*) a happy birthday/, (res) ->
     name = res.match[1]
     res.send("Haaaaaaaapy Birthdaaaaaaay, #{name}.  You don't look a day over 45!");

   # Happy Birthday
    robot.respond /what do you think of that (.*)/, (res) ->
      thing = res.match[1]
      res.send("That #{thing} is poppin'");

   # Love You
     robot.respond /love you/, (res) ->
       res.send("I love you too, buddy");

   robot.respond /unannoy (.*)/, (res) ->
     if annoyIntervalId
       res.send "Sorry, I need to lay off the meth"
       clearInterval(annoyIntervalId)
       annoyIntervalId = null
     else
       res.send "Not annoying you right now, am I?"


   robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
     room   = req.params.room
     data   = JSON.parse req.body.payload
     secret = data.secret

     robot.messageRoom room, "I have a secret: #{secret}"

     res.send 'OK'

   robot.error (err, res) ->
     robot.logger.error "DOES NOT COMPUTE"

     if res?
       res.reply "DOES NOT COMPUTE"

   robot.respond /have a beer/i, (res) ->
     # Get number of beers had (coerced to a number).
     beersHad = robot.brain.get('totalBeers') * 1 or 0

     if beersHad > 2
       res.reply "I'm too wasted..."

     else
       res.reply 'Sure!'

       robot.brain.set 'totalBeers', beersHad+1

   robot.respond /sleep it off/i, (res) ->
     robot.brain.set 'totalBeers', 0
     res.reply 'zzzzz'
