{module, test} = QUnit

module 'TaoForm',

  beforeEach: (assert) ->
    done = assert.async()

    @taoForm = $('''
      <tao-form/>
    ''').appendTo('body').get(0)

    setTimeout -> done()

  afterEach: ->
    @taoForm.jq.remove()
    @taoForm = null

, ->

  test 'inherits from TaoComponent', (assert) ->
    assert.ok @taoForm instanceof TaoComponent
