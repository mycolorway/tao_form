import '@mycolorway/tao/src/custom_elements'
import { expect } from 'chai'
import $ from 'jquery'
import { Component } from '@mycolorway/tao'
import FormElement from '../src/element'

describe 'TaoForm', ->

  element = null

  beforeEach (done) ->
    element = $('''
      <tao-form/>
    ''').appendTo('body').get(0)
    setTimeout -> done()

  afterEach ->
    element.jq.remove()
    element = null

  it 'inherits from TaoComponent', ->
    expect(element instanceof Component).to.be.true
    expect(element instanceof FormElement).to.be.true
