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
  
  it 'wrap print', (done)->
    util.wrap (()->
      perr "SHALL NOT PASS"
      pp   "SHALL NOT PASS"
      p    "SHALL NOT PASS"
      puts "SHALL NOT PASS"
      process.exit()
    ),done
    return
  
  it 'wrap_async', (done)->
    util.wrap_async (on_end)->
      await setTimeout defer(), 100
      on_end()
    , done
    return
  
  it 'wrap_async print', (done)->
    util.wrap_async (on_end)->
      perr "SHALL NOT PASS"
      pp   "SHALL NOT PASS"
      p    "SHALL NOT PASS"
      puts "SHALL NOT PASS"
      # process.exit()
      await setTimeout defer(), 100
      on_end()
    , done
    return
  
  it 'wrap_async error', (done)->
    await
      util.wrap_async (on_end)->
        on_end new Error "expected error"
      , defer(err)
    if !err
      return done new Error "missing error"
    done()
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
  
  