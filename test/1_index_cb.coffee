assert = require "assert"
require "../src/index.coffee"

describe "index section", ()->
  # NOTE await damages __LINE__
  # ###################################################################################################
  #    cb
  # ###################################################################################################
  
  it "pass ok", ()->
    fn_ok = ()->Promise.resolve(1)
    
    await fn_ok().cb defer(err, res)
    assert.strictEqual err, null
    assert.strictEqual res, 1
    
  it "catch ok", ()->
    fn_fail = ()->Promise.reject(1)
    
    await fn_fail().cb defer(err, res)
    assert.strictEqual err, 1
