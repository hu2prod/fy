assert = require "assert"
util = require "../src/test_util"

require "../src/unused.coffee"
window = global

describe "unused section", ()->
  # ###################################################################################################
  #    misc
  # ###################################################################################################
  it "count", (done)->
    t0 = null
    effect_1 = 0
    effect_2 = 0
    t1 = once_interval t0, (()->effect_1=1), 1
    t2 = once_interval t1, (()->effect_2=1), 1
    assert.strictEqual t1, t2
    await setTimeout defer(), 100
    assert.strictEqual effect_1, 1
    assert.strictEqual effect_2, 0
    done()
    return
  
  # ###################################################################################################
  #    obj_*
  # ###################################################################################################
  
  it "count", ()->
    a = {}
    assert.strictEqual 0, window.count a
    
    a = {a:1}
    assert.strictEqual 1, window.count a
    a = {a:1,b:1}
    assert.strictEqual 2, window.count a
    
        
    assert.strictEqual 0, window.count []
    assert.strictEqual 1, window.count [1]
    assert.strictEqual 2, window.count [1,2]
    
    return
  
  it "hash_key", ()->
    list = [
      {a:1}
      {a:2}
    ]
    list.hash_key("a")
    util.json_eq list.hash, {
      1 : list
      2 : list
    }
    return
  # ###################################################################################################
  #    async
  # ###################################################################################################
  it "stream_parallel", (done)->
    t = stream_parallel ()->
      done()
    
    for v in [1,2,3]
      t()
      do ()->
        await setTimeout defer(), 100
        t.end()
    return
  
  it "stream_parallel 0", (done)->
    t = stream_parallel ()->
      done()
    
    for v in []
      t()
      do ()->
        await setTimeout defer(), 100
        t.end()
    return
  
  # ###################################################################################################
  #    non exception tests
  # ###################################################################################################
  it "ppw", ()->
    ppw 1