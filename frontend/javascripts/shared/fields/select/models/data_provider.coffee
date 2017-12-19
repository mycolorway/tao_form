import Option from './option'
import { Module } from '@mycolorway/tao'
import _ from 'lodash'
import $ from 'jquery'

class DataProvider extends Module

  @option 'remote', default: false

  @option 'field'

  _init: ->
    @_initOptions()

    @field?.on 'tao:addOption', (e, option) =>
      if option.data?.group
        index = _.findIndex @options, (opt) ->
          opt.data?.group == option.data?.group
        @options.splice index, 0, option
      else
        @options.unshift option

  _initOptions: ->
    @options = if @field?
      @field.find('option').map (i, optionEl) ->
        Option.fromElement optionEl
      .get()
    else
      []

  getOption: (value) ->
    return value if value instanceof Option
    return null if _.isNull(value) || _.isUndefined(value)

    result = @options.filter (option) -> option.value == value
    if result.length > 0 then result[0] else null

  filter: (value, callback) ->
    if @remote && @options.length < @remote.totalOptionSize
      if value
        @_fetch value, callback
      else
        callback? @options, @remote.totalOptionSize
    else
      options = @options.filter (option) -> option.match(value)
      callback? options

    null

  _fetch: (value, callback) ->
    return unless @remote && @remote.url

    $.ajax
      url: @remote.url
      data: _.extend {}, @remote.params,
        "#{@remote.searchKey}": value
      dataType: 'json'
    .done (result) ->
      options = if _.isArray(result.options) && result.options.length > 0 &&\
          _.isArray(result.options[0]) && _.isArray(result.options[0][1])
        result.options.reduce (opts, group) ->
          unless _.isArray(group) && group.length > 1 && _.isArray(group[1])
            return
          group[1].forEach (opt) ->
            opts.push Option.fromJson(opt, group[0])
          opts
        , []
      else if _.isPlainObject(result.options)
        _.flatten(
          for groupName, opts of result.options
            Option.fromJson(opt, groupName) for opt in opts
        )
      else if _.isArray result.options
        (Option.fromJson(option) for option in result.options)
      else
        []

      callback? options, result.totalSize

  reset: ->
    @_initOptions()

export default DataProvider
