assert = require 'assert'
util = require '../src/test_util'

require '../src/experimental.coffee'

describe 'experimental section', ()->
  # ###################################################################################################
  #    string ops
  # ###################################################################################################
  it '__FILE__', ()->
    assert.strictEqual __FILE__, 'experimental.coffee'
    return
  
  it '__LINE__', ()->
    assert.strictEqual __LINE__, 15
    return
  
  it '__STACK__', ()->
    assert __STACK__.length > 3
    return
  