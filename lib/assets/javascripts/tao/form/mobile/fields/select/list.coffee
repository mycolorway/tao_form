#= require tao/form/fields/select/list/base

class Tao.Form.Select.List extends Tao.Form.Select.ListBase

  refreshHeight: ->
    $listWrapper = @jq.find('.list-wrapper')
    winHeight = $(window).height()
    offsetTop = $listWrapper[0].getBoundingClientRect().top

    $listWrapper.css
      height: winHeight - offsetTop

TaoComponent.register Tao.Form.Select.List
