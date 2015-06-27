Telegram = require 'telegram-bot'
request = require('request')

tg = new Telegram(process.env.TELEGRAM_BOT_TOKEN)
options = {
        "useragent": "My duckduckgo app"
        "no_redirects": "1"
        "no_html": "0"
}


tg.on 'message', (msg) ->
  return unless msg.text
  msg.text = msg.text.replace('@fuck_off_bot','').replace('!','')
  console.log msg.text
  msg_array = msg.text.split('/')
  console.log msg_array.length
  switch msg_array.length
    when 2 then url = 'http://www.foaas.com/'+msg_array[1]
    when 3 then url ='http://www.foaas.com/'+msg_array[1]+"/"+msg_array[2]

    when 4 then url = 'http://www.foaas.com/'+msg_array[1]+"/"+msg_array[2]+"/"+msg_array[3]
    when 5 then url = 'http://www.foaas.com/'+msg_array[1]+"/"+msg_array[2]+"/"+msg_array[3]+'/'+msg_array[4]
    else url = 'http://www.foaas.com/'+"flying/"+'fuck_off_bot'

  options = {
      url: url 
      method: 'GET'
      json: true
  }
  request options, (error, response, body) ->
    if !error and response.statusCode == 200
      console.log body
      if body.message and body.subtitle
        reply =  body.message + ''+ body.subtitle
      else
        reply = JSON.stringify(body)
      tg.sendMessage
        text: reply
        reply_to_message_id: msg.message_id
        chat_id: msg.chat.id
    else
      tg.sendMessage
        text: "I don't give a flying fuck.- fuck_off_bot"
        reply_to_message_id: msg.message_id
        chat_id: msg.chat.id

tg.start()
