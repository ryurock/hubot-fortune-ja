# Description:
#   Returns fortune information from http://fortune.yahoo.co.jp/12astro/ranking.html
#
# Commands:
#   hubot 占い - http://fortune.yahoo.co.jp/12astro/ranking.htmlから今日の占いを取得します
#

request = require 'request'
cheerio = require 'cheerio'
Iconv   = require('iconv').Iconv
Async = require('async')

module.exports = (robot) ->
  robot.respond /占い$/i, (msg) ->
    constellation = []
    url  = "http://fortune.yahoo.co.jp/12astro/ranking.html"
    options =
      url      : url
      timeout  : 2000
      headers  : {'user-agent': 'node title fetcher'}
      encoding : null
    request options, (error, response, body) ->
      conv = new Iconv('euc-jp','UTF-8//TRANSLIT//IGNORE')
      body = conv.convert(body).toString()
      $ = cheerio.load body

      text = "【#{robot.name}】が今日の占いを教えるだぬ〜ん\n\n" +
      "#{$('.mg10t').find('.bg03>h2>img').attr('alt')}\n" +
      "#{$('.mg10t').find('.bg03>p.txt').text()}\n\n" + 
      "詳細はこちら http://fortune.yahoo.co.jp/12astro/ranking.html\n"

      constellation.push({
        name        : $('tr.st01').eq(0).find(".seiza>img").attr('alt')
        description : $('tr.st01').eq(0).find("a").text()
      })
      constellation.push({
        name        : $('tr.st02').eq(0).find(".seiza>img").attr('alt')
        description : $('tr.st02').eq(0).find("a").text()
      })
      constellation.push({
        name        : $('tr.st01').eq(1).find(".seiza>img").attr('alt')
        description : $('tr.st01').eq(1).find("a").text()
      })
      constellation.push({
        name        : $('tr.st02').eq(1).find(".seiza>img").attr('alt')
        description : $('tr.st02').eq(1).find("a").text()
      })
      constellation.push({
        name        : $('tr.st01').eq(2).find(".seiza>img").attr('alt')
        description : $('tr.st01').eq(2).find("a").text()
      })
      constellation.push({
        name        : $('tr.st02').eq(2).find(".seiza>img").attr('alt')
        description : $('tr.st02').eq(2).find("a").text()
      })
      constellation.push({
        name        : $('tr.st01').eq(3).find(".seiza>img").attr('alt')
        description : $('tr.st01').eq(3).find("a").text()
      })
      constellation.push({
        name        : $('tr.st02').eq(3).find(".seiza>img").attr('alt')
        description : $('tr.st02').eq(3).find("a").text()
      })
      constellation.push({
        name        : $('tr.st01').eq(4).find(".seiza>img").attr('alt')
        description : $('tr.st01').eq(4).find("a").text()
      })
      constellation.push({
        name        : $('tr.st02').eq(4).find(".seiza>img").attr('alt')
        description : $('tr.st02').eq(4).find("a").text()
      })
      constellation.push({
        name        : $('tr.st01').eq(5).find(".seiza>img").attr('alt')
        description : $('tr.st01').eq(5).find("a").text()
      })
      constellation.push({
        name        : $('tr.st02').eq(5).find(".seiza>img").attr('alt')
        description : $('tr.st02').eq(5).find("a").text()
      })

      Async.each(constellation, (i, callback) ->
        text = text + "--------------\n" + "◆#{i.name}◆\n" + "#{i.description}\n" 
      )

      msg.send text

