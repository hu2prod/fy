assert = require "assert"
util = require "../src/test_util"

require "../src/experimental.coffee"

describe "experimental section", ()->
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
    