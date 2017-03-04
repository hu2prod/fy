assert = require 'assert'
util = require './util'

Number.MIN_SAFE_INTEGER = null
Number.MAX_SAFE_INTEGER = null
require '../legacy.coffee'

describe 'legacy section', ()->
  # ###################################################################################################
  #    string ops
  # ###################################################################################################
  it 'Number', ()->
    assert.strictEqual Number.MIN_SAFE_INTEGER, -9007199254740991 
    assert.strictEqual Number.MAX_SAFE_INTEGER, 9007199254740991 
    return
  