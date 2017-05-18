
# instance of this class should be immutable

class Tao.Form.Select.Option extends TaoModule

  @option 'text', 'value', 'data'

  @fromElement: (element) ->
    $element = $ element
    return unless (value = $element.val()) && !$option.is(':disabled')

    data = $element.data()
    data.group = $option.parent('optgroup').prop('label') if $option.parent('optgroup').length

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
    String(filterKey).indexOf(value) > -1
