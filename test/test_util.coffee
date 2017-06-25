assert = require 'assert'
util = require '../src/test_util.coffee'

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
  
  it 'wrap', (done)->
    util.wrap (()->
      perr "SHALL NOT PASS"
      pp   "SHALL NOT PASS"
      p    "SHALL NOT PASS"
      puts "SHALL NOT PASS"
      process.exit()
    ),done
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
  
  
  it 'not_throws not throws', ()->
    util.not_throws ()->
      
    return
  
  