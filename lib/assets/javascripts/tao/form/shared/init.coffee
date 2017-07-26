Tao.Application.initializer 'moment', (app) ->
  if moment? && app.locale
    moment.locale(app.locale.toLowerCase())

  if moment?.tz? && app.timeZone
    moment.tz.setDefault(app.timeZone)

Tao.AttributeManager.registerAttribute 'moment',
  get: (element, name, options) ->
    value = element.getAttribute name
    if _.isString value
      try
        moment value
      catch e
        options.default || null
    else
      options.default || null
  set: (element, name, val, options) ->
    val = try
      val.format()
    catch e
      ''
    element.setAttribute name, val
