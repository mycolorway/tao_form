#= require moment
#= require moment/zh-cn
#= require tao/ui
#= require tao/ui/icons/form
#= require_self
#= require ./element
#= require ./fields

Tao.Form = {}

Tao.Application.initializer 'moment', (app) ->
  if moment? && app.locale
    moment.locale(app.locale.toLowerCase())

  if moment?.tz? && app.timeZone
    moment.tz.setDefault(app.timeZone)
