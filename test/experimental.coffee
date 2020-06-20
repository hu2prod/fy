assert = require "assert"
util = require "../src/test_util"

require "../src/experimental.coffee"

describe "experimental section", ()->
  # ###################################################################################################
  #    string ops
  # ###################################################################################################
  it "__FILE__", ()->
    assert.strictEqual __FILE__, "experimental.coffee"
    return
  
  it "__LINE__", ()->
    assert.strictEqual __LINE__, 15
    return
  
  it "__STACK__", ()->
    assert __STACK__.length > 3
    return
  # ###################################################################################################
  #    wrap_once
  # ###################################################################################################
  describe "wrap_once", ()->
    it "should not call function if wrapper is not called", ()->
      fn = ()->
        throw new Error "You should not call me"
      fn.wrap_once()
    
    it "should call function if wrapper is called first time", ()->
      counter = 0
      fn = ()->
        counter++
      wrapper = fn.wrap_once()
      wrapper()
      assert.equal 1, counter
    
    it "should call function 1 time if wrapper is called multiple times", ()->
      counter = 0
      fn = ()->
        counter++
      wrapper = fn.wrap_once()
      wrapper()
      wrapper()
      assert.equal 1, counter
    