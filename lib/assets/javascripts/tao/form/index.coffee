#= require moment
#= require tao/ui
#= require tao/ui/icons/form
#= require_self
#= require ./element
#= require ./fields

Tao.Form = {}

Tao.Application.initializer 'moment', (app) ->
  moment.locale(app.locale.toLowerCase()) if moment? && app.locale
  moment.tz.setDefault(app.timeZone) if moment?.tz? && app.timeZone
