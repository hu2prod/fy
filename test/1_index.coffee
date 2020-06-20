assert = require "assert"
util = require "../src/test_util"

Array.isArray = null
Math.log2 = null
Math.log10 = null
require "../src/index.coffee"
window = global

describe "index section", ()->
  # ###################################################################################################
  #    string ops
  # ###################################################################################################
  # Прим. везде в strictEqual перепутан порядок. Но пофиг, т.к. так удобнее
  it "String.reverse", ()->
    assert.strictEqual "123", "321".reverse()
    return
  
  it "String.capitalize", ()->
    assert.strictEqual "", "".capitalize()
    assert.strictEqual "A", "a".capitalize()
    assert.strictEqual "A", "A".capitalize()
    assert.strictEqual "Aa", "aa".capitalize()
    return
  
  it "String.ljust", ()->
    assert.strictEqual "123 ", "123".ljust(4)
    return
  
  it "String.rjust", ()->
    assert.strictEqual " 123", "123".rjust(4)
    return
  
  it "String.center", ()->
    assert.strictEqual " 123", "123".center(4)
    assert.strictEqual " 123 ", "123".center(5)
    return
  
  it "String.repeat", ()->
    assert.strictEqual "1111", "1".repeat(4)
    assert.strictEqual "12121212", "12".repeat(4)
    return
  
  
  it "Number.ljust", ()->
    assert.strictEqual "123 ", 123.ljust(4)
    return
  
  it "Number.rjust", ()->
    assert.strictEqual " 123", 123.rjust(4)
    return
  
  it "Number.center", ()->
    assert.strictEqual " 123", 123.center(4)
    assert.strictEqual " 123 ", 123.center(5)
    return
  
  it "Number.repeat", ()->
    assert.strictEqual "1111", 1.repeat(4)
    assert.strictEqual "12121212", 12.repeat(4)
    return
  # ###################################################################################################
  #    misc
  # ###################################################################################################
  it "tic toc ptoc", ()->
    window.tic()
    assert window.toc() >= 0
    window.ptoc()
    return
  
  it "call_later", (done)->
    window.call_later done
    return
  
  it "RegExp.escape", ()->
    for ch in "/-()[]{}*+?.,^$|#"
      assert.strictEqual "\\"+ch, RegExp.escape ch
    return
  # ###################################################################################################
  #    array
  # ###################################################################################################
  
  it "Array.isArray", ()->
    assert Array.isArray []
    assert.strictEqual Array.isArray(1), false
    assert.strictEqual Array.isArray("1"), false
    assert.strictEqual Array.isArray(null), false
    assert.strictEqual Array.isArray(false), false
    assert.strictEqual Array.isArray(true), false
    assert.strictEqual Array.isArray({}), false
    assert.strictEqual Array.isArray(/123/), false
    return
  
  it "Array.has", ()->
    a = [1,2,3]
    assert a.has 1
    assert a.has 2
    assert a.has 3
    assert !a.has 4
    return
  
  it "Array.upush", ()->
    a = [1,2,3]
    a.upush 4
    util.json_eq a, [1,2,3,4]
    a.upush 3
    util.json_eq a, [1,2,3,4]
    return
  
  it "Array.fast_remove ", ()->
    a = [1,2,3]
    a.fast_remove 1
    util.json_eq a, [3,2]
    
    a = [1,2,3]
    a.fast_remove 4
    util.json_eq a, [1,2,3]
    return
  
  it "Array.fast_remove_idx ", ()->
    a = [1,2,3]
    a.fast_remove_idx 0
    util.json_eq a, [3,2]
    
    a = [1,2,3]
    a.fast_remove_idx -1
    util.json_eq a, [1,2,3]
    
    a = [1,2,3]
    a.fast_remove_idx 9001
    util.json_eq a, [1,2,3]
    return
  
  it "Array.idx", ()->
    a = [1,2,3]
    assert.strictEqual  0 , a.idx 1
    assert.strictEqual  1 , a.idx 2
    assert.strictEqual  2 , a.idx 3
    assert.strictEqual -1 , a.idx 4
    return
  
  it "Array.clear", ()->
    a = [1,2,3]
    a.clear()
    
    assert.strictEqual  0 , a.length
    return
  
  it "Array.remove_idx", ()->
    a = [1,2,3]
    util.json_eq [2,3], a.remove_idx 0
    a = [1,2,3]
    util.json_eq [1,3], a.remove_idx 1
    a = [1,2,3]
    util.json_eq [1,2], a.remove_idx 2
    a = [1,2,3]
    util.json_eq [1,2,3], a.remove_idx 3
    return
  
  it "Array.remove", ()->
    a = [1,2,3]
    util.json_eq [2,3], a.remove 1
    a = [1,2,3]
    util.json_eq [1,3], a.remove 2
    a = [1,2,3]
    util.json_eq [1,2], a.remove 3
    a = [1,2,3]
    util.json_eq [1,2,3], a.remove 4
    return
  
  it "Array.last", ()->
    a = [1,2,3]
    assert.strictEqual 3, a.last()
    assert.strictEqual 3, a.end()
    return
  
  it "Array.append", ()->
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
  
  it "Array.uappend", ()->
    a = [1,2,3]
    b = a.uappend [4]
    util.json_eq [1,2,3,4], b 
    assert.strictEqual a, b
    
    a = [1,2,3]
    b = a.uappend []
    util.json_eq [1,2,3], b 
    
    a = [1,2,3]
    b = a.uappend [4,5]
    util.json_eq [1,2,3,4,5], b 
    
    a = [1,2,3]
    b = a.uappend [1]
    util.json_eq [1,2,3], b 
    assert.strictEqual a, b
    
    return
  
  it "Array.insert_after", ()->
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
  
  it "arr_set", ()->
    a = [1,2,3]
    window.arr_set a, b = [1]
    util.json_eq [1], a
    assert a != b
    return
  
  it "arr_merge", ()->
    util.json_eq [],    window.arr_merge [] , []
    util.json_eq [1],   window.arr_merge [1], []
    util.json_eq [1],   window.arr_merge [] , [1]
    util.json_eq [1,2], window.arr_merge [1], [2]
    util.json_eq [],    window.array_merge [] , []
    util.json_eq [1],   window.array_merge [1], []
    util.json_eq [1],   window.array_merge [] , [1]
    util.json_eq [1,2], window.array_merge [1], [2]
    util.json_eq [1,2,3], window.array_merge [1], [2], [3]
    return
  
  it "Array.set", ()->
    a = [1,2,3]
    a.set b = [1]
    util.json_eq [1], a
    assert a != b
    return
  
  # ###################################################################################################
  #    clone
  # ###################################################################################################
  
  it "clone number", ()->
    a = 1
    util.json_eq a, window.clone a
    return
  
  it "clone string", ()->
    a = "1"
    util.json_eq a, window.clone a
    return
  
  it "clone []", ()->
    a = []
    util.json_eq a, window.clone a
    return
  
  it "clone [1,2,3]", ()->
    a = [1,2,3]
    util.json_eq a, window.clone a
    assert a != window.clone a
    return
  
  it "clone {}", ()->
    a = {}
    util.json_eq a, window.clone a
    assert a != window.clone a
    return
  
  it "clone {a:1}", ()->
    a = {a:1}
    util.json_eq a, window.clone a
    assert a != window.clone a
    return
  
  it "clone [{}]", ()->
    a = [{}]
    util.json_eq a, window.clone a
    assert a != window.clone a
    return
  
  # ###################################################################################################
  #    deep clone
  # ###################################################################################################
  it "deep_clone number", ()->
    a = 1
    util.json_eq a, window.deep_clone a
    return
  
  it "deep_clone string", ()->
    a = "1"
    util.json_eq a, window.deep_clone a
    return
  
  it "deep_clone []", ()->
    a = []
    util.json_eq a, window.deep_clone a
    return
  
  it "deep_clone [1,2,3]", ()->
    a = [1,2,3]
    util.json_eq a, window.deep_clone a
    assert a != window.deep_clone a
    return
  
  it "deep_clone {}", ()->
    a = {}
    util.json_eq a, window.deep_clone a
    assert a != window.deep_clone a
    return
  
  it "deep_clone {a:1}", ()->
    a = {a:1}
    util.json_eq a, window.deep_clone a
    assert a != window.deep_clone a
    return
  
  it "deep_clone [{}]", ()->
    a = [{}]
    util.json_eq a, window.deep_clone a
    assert a != window.deep_clone a
    return
  
  # ###################################################################################################
  #    obj_*
  # ###################################################################################################
  
  it "is_object", ()->
    assert is_object {}
    assert.strictEqual is_object(1), false
    assert.strictEqual is_object("1"), false
    assert.strictEqual is_object(null), false
    assert.strictEqual is_object(false), false
    assert.strictEqual is_object(true), false
    assert.strictEqual is_object([]), true
    assert.strictEqual is_object(/123/), true
    return
  
  it "obj_set", ()->
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
  
  it "obj_merge", ()->
    a = window.obj_merge {}, {a:1}
    util.json_eq a, {a:1}
    
    a = window.obj_merge {b:1}, {a:1}
    util.json_eq a, {b:1, a:1}
    
    a = window.obj_merge {a:1}, {a:2}
    util.json_eq a, {a:2}
    
    a = window.obj_merge {a:1}, {a:2} , {a:3}
    util.json_eq a, {a:3}
    return
  
  it "h_count", ()->
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
  
  it "obj_clear", ()->
    a = base_a = {}
    window.obj_clear a
    util.json_eq {}, a
    assert.strictEqual a, base_a
    
    a = {a:1}
    window.obj_clear a
    util.json_eq {}, a
    
    return
  
  it "h_count", ()->
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
  # ###################################################################################################
  #    function
  # ###################################################################################################
  
  # Прим. Если не совсем очевидно попробуй заменить sbind на bind и запусти тесты
  it "sbind", ()->
    fn = ()->@
    ctx1={a:1}
    ctx2={b:1}
    ctx3={c:1}
    fn2 = fn.sbind ctx1
    assert.strictEqual fn2(), ctx1
    assert.strictEqual fn2.call(ctx3), ctx3
    fn3 = fn2.sbind ctx2
    assert.strictEqual fn3(), ctx2
    return
  # ###################################################################################################
  #    Math
  # ###################################################################################################
  it "Math.log2", ()->
    val = 1.5
    assert.strictEqual Math.log2(val), Math.log(val)/Math.log(2)
    return
  
  it "Math.log10", ()->
    val = 1.5
    assert.strictEqual Math.log10(val), Math.log(val)/Math.log(10)
    return
  # ###################################################################################################
  #    print / non exception tests
  # ###################################################################################################
  it "pp", ()->
    pp null
    pp 1
    pp "1"
  
  it "print", ()->
    print null
    print 1
    print "1"
  
  it "insp", ()->
    insp null
    insp 1
    insp "1"
    insp /ab+c/i
    insp a: 1, b: [2, 3]
    insp a:a:a:a:a:a:a:1, 5 # 5 is depth
    # circular:
    a = {}
    a.b = a
    insp a