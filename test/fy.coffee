assert = require 'assert'
util = require './util'
require '../index.coffee'
window = global

describe 'fy section', ()->
  # ###################################################################################################
  #    string ops
  # ###################################################################################################
  it 'String.reverse', ()->
    assert.strictEqual '123', '321'.reverse()
    return
  
  it 'String.ljust', ()->
    assert.strictEqual '123 ', '123'.ljust(4)
    return
  
  it 'String.rjust', ()->
    assert.strictEqual ' 123', '123'.rjust(4)
    return
  
  it 'String.center', ()->
    assert.strictEqual ' 123', '123'.center(4)
    assert.strictEqual ' 123 ', '123'.center(5)
    return
  
  it 'String.repeat', ()->
    assert.strictEqual '1111', '1'.repeat(4)
    assert.strictEqual '12121212', '12'.repeat(4)
    return
  
  
  it 'Number.ljust', ()->
    assert.strictEqual '123 ', 123.ljust(4)
    return
  
  it 'Number.rjust', ()->
    assert.strictEqual ' 123', 123.rjust(4)
    return
  
  it 'Number.center', ()->
    assert.strictEqual ' 123', 123.center(4)
    assert.strictEqual ' 123 ', 123.center(5)
    return
  
  it 'Number.repeat', ()->
    assert.strictEqual '1111', 1.repeat(4)
    assert.strictEqual '12121212', 12.repeat(4)
    return
  # ###################################################################################################
  #    misc
  # ###################################################################################################
  it 'tic toc ptoc', ()->
    window.tic()
    assert window.toc() >= 0
    window.ptoc()
    return
  
  it 'call_later', (done)->
    window.call_later done
    return
  
  it 'RegExp.escape', ()->
    assert.strictEqual '\\-', RegExp.escape '-'
    assert.strictEqual '\\[', RegExp.escape '['
    assert.strictEqual '\\]', RegExp.escape ']'
    assert.strictEqual '\\(', RegExp.escape '('
    assert.strictEqual '\\)', RegExp.escape ')'
    return
  # ###################################################################################################
  #    array
  # ###################################################################################################
  
  it 'Array.has', ()->
    a = [1,2,3]
    assert a.has 1
    assert a.has 2
    assert a.has 3
    assert !a.has 4
    return
  
  it 'Array.upush', ()->
    a = [1,2,3]
    a.upush 4
    util.json_eq a, [1,2,3,4]
    a.upush 3
    util.json_eq a, [1,2,3,4]
    return
  
  it 'Array.idx', ()->
    a = [1,2,3]
    assert.strictEqual  0 , a.idx 1
    assert.strictEqual  1 , a.idx 2
    assert.strictEqual  2 , a.idx 3
    assert.strictEqual -1 , a.idx 4
    return
  
  it 'Array.clear', ()->
    a = [1,2,3]
    a.clear()
    
    assert.strictEqual  0 , a.length
    return
  
  it 'Array.remove_idx', ()->
    a = [1,2,3]
    util.json_eq [2,3], a.remove_idx 0
    a = [1,2,3]
    util.json_eq [1,3], a.remove_idx 1
    a = [1,2,3]
    util.json_eq [1,2], a.remove_idx 2
    a = [1,2,3]
    util.json_eq [1,2,3], a.remove_idx 3
    return
  
  it 'Array.remove', ()->
    a = [1,2,3]
    util.json_eq [2,3], a.remove 1
    a = [1,2,3]
    util.json_eq [1,3], a.remove 2
    a = [1,2,3]
    util.json_eq [1,2], a.remove 3
    a = [1,2,3]
    util.json_eq [1,2,3], a.remove 4
    return
  
  it 'Array.last', ()->
    a = [1,2,3]
    assert.strictEqual 3, a.last()
    assert.strictEqual 3, a.end()
    return
  
  it 'Array.append', ()->
    a = [1,2,3]
    b = a.append [4]
    util.json_eq [1,2,3,4], b 
    assert.strictEqual a, b
    
    a = [1,2,3]
    b = a.append []
    util.json_eq [1,2,3], b 
    
    a = [1,2,3]
    b = a.append [4,5]
    util.json_eq [1,2,3,4,5], b 
    
    return
  
  it 'Array.insert_after', ()->
    a = [1,2,3]
    a.insert_after -1, 4
    util.json_eq [4,1,2,3], a
    
    a = [1,2,3]
    a.insert_after 0, 4
    util.json_eq [1,4,2,3], a
    
    a = [1,2,3]
    a.insert_after 1, 4
    util.json_eq [1,2,4,3], a
    
    a = [1,2,3]
    a.insert_after 2, 4
    util.json_eq [1,2,3,4], a
    return
  
  it 'arr_set', ()->
    a = [1,2,3]
    window.arr_set a, b = [1]
    util.json_eq [1], a
    assert a != b
    return
  
  it 'arr_merge', ()->
    util.json_eq [],    window.arr_merge [] , []
    util.json_eq [1],   window.arr_merge [1], []
    util.json_eq [1],   window.arr_merge [] , [1]
    util.json_eq [1,2], window.arr_merge [1], [2]
    util.json_eq [],    window.array_merge [] , []
    util.json_eq [1],   window.array_merge [1], []
    util.json_eq [1],   window.array_merge [] , [1]
    util.json_eq [1,2], window.array_merge [1], [2]
    return
  
  it 'Array.set', ()->
    a = [1,2,3]
    a.set b = [1]
    util.json_eq [1], a
    assert a != b
    return
  
  # ###################################################################################################
  #    clone
  # ###################################################################################################
  it 'clone number', ()->
    a = 1
    util.json_eq a, window.clone a
    return
  
  it 'clone string', ()->
    a = '1'
    util.json_eq a, window.clone a
    return
  
  it 'clone []', ()->
    a = []
    util.json_eq a, window.clone a
    return
  
  it 'clone [1,2,3]', ()->
    a = [1,2,3]
    util.json_eq a, window.clone a
    assert a != window.clone a
    return
  
  it 'clone {}', ()->
    a = {}
    util.json_eq a, window.clone a
    assert a != window.clone a
    return
  
  it 'clone {a:1}', ()->
    a = {a:1}
    util.json_eq a, window.clone a
    assert a != window.clone a
    return
  
  it 'clone [{}]', ()->
    a = [{}]
    util.json_eq a, window.clone a
    assert a != window.clone a
    return
  
  # ###################################################################################################
  #    deep clone
  # ###################################################################################################
  it 'deep_clone number', ()->
    a = 1
    util.json_eq a, window.deep_clone a
    return
  
  it 'deep_clone string', ()->
    a = '1'
    util.json_eq a, window.deep_clone a
    return
  
  it 'deep_clone []', ()->
    a = []
    util.json_eq a, window.deep_clone a
    return
  
  it 'deep_clone [1,2,3]', ()->
    a = [1,2,3]
    util.json_eq a, window.deep_clone a
    assert a != window.deep_clone a
    return
  
  it 'deep_clone {}', ()->
    a = {}
    util.json_eq a, window.deep_clone a
    assert a != window.deep_clone a
    return
  
  it 'deep_clone {a:1}', ()->
    a = {a:1}
    util.json_eq a, window.deep_clone a
    assert a != window.deep_clone a
    return
  
  it 'deep_clone [{}]', ()->
    a = [{}]
    util.json_eq a, window.deep_clone a
    assert a != window.deep_clone a
    return
  
  # ###################################################################################################
  #    obj_*
  # ###################################################################################################
  
  it 'obj_set', ()->
    a = {}
    window.obj_set a, {a:1}
    util.json_eq a, {a:1}
    
    a = {b:1}
    window.obj_set a, {a:1}
    util.json_eq a, {b:1, a:1}
    
    a = {a:1}
    window.obj_set a, {a:2}
    util.json_eq a, {a:2}
    return
  
  it 'h_count', ()->
    a = {}
    assert.strictEqual 0, window.h_count a
    assert.strictEqual 0, window.count_h a
    assert.strictEqual 0, window.hash_count a
    assert.strictEqual 0, window.count_hash a
    
    a = {a:1}
    assert.strictEqual 1, window.h_count a
    assert.strictEqual 1, window.count_h a
    assert.strictEqual 1, window.hash_count a
    assert.strictEqual 1, window.count_hash a
    
    a = {a:1,b:1}
    assert.strictEqual 2, window.h_count a
    assert.strictEqual 2, window.count_h a
    assert.strictEqual 2, window.hash_count a
    assert.strictEqual 2, window.count_hash a
    
    return
  
  it 'obj_clear', ()->
    a = base_a = {}
    window.obj_clear a
    util.json_eq {}, a
    assert.strictEqual a, base_a
    
    a = {a:1}
    window.obj_clear a
    util.json_eq {}, a
    
    return
  
  it 'h_count', ()->
    a = {}
    assert.strictEqual 0, window.h_count a
    assert.strictEqual 0, window.count_h a
    assert.strictEqual 0, window.hash_count a
    assert.strictEqual 0, window.count_hash a
    
    a = {a:1}
    assert.strictEqual 1, window.h_count a
    assert.strictEqual 1, window.count_h a
    assert.strictEqual 1, window.hash_count a
    assert.strictEqual 1, window.count_hash a
    
    a = {a:1,b:1}
    assert.strictEqual 2, window.h_count a
    assert.strictEqual 2, window.count_h a
    assert.strictEqual 2, window.hash_count a
    assert.strictEqual 2, window.count_hash a
    return
  