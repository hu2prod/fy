assert = require 'assert'
util = require '../test_util.coffee'

describe 'test_util section', ()->
  it 'json_eq', ()->
    assert.throws ()->
      util.json_eq {}, []
    util.json_eq {a:1}, {a:1}
    return
  
  it 'wrap', (done)->
    util.wrap (()->)
    ,done
    return
  
  it 'throws', (done)->
    util.throws ()->
      throw new Error "test"
    , done
    return
  
  it 'not_throws', ()->
    assert.throws ()->
      util.not_throws ()->
        throw new Error "test"
      
    return
  
  