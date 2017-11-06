import { Module } from '@mycolorway/tao'
import _ from 'lodash'
import $ from 'jquery'

# instance of this class should be immutable
class Option extends Module

  @option 'text', 'value', 'data'

  @fromElement: (element) ->
    $element = $ element
    return unless (value = $element.val()) && !$element.is(':disabled')

    data = $element.data()
    data.group = $element.parent('optgroup').prop('label') if $element.parent('optgroup').length

    new @
      text: $element.text()
      value: value
      data: data

  @fromJson: (json, group) ->
    data = if json.length > 2 then json[2] else {}
    data.group = group if group

    new @
      text: json[0]
      value: json[1]
      data: data

  _init: ->
    if @data
      @data[_.camelCase key.replace(/^data-/, '')] = value for key, value of @data
    else
      @data = {}

  match: (value) ->
    filterKey = @data.searchKey || @text
    String(filterKey).toLowerCase().indexOf(value.toLowerCase()) > -1

export default Option
