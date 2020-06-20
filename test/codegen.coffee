assert = require "assert"
util = require "../src/test_util"

require "../src/codegen.coffee"

describe "codegen section", ()->
  describe "make_tab", ()->
    it "no tab -> no work", ()->
      assert.equal make_tab("",     ""), ""
      assert.equal make_tab("a",    ""), "a"
      assert.equal make_tab("a\nb", ""), "a\nb"
      return
    
    it "tab add", ()->
      assert.equal make_tab("",     "  "), ""
      assert.equal make_tab("a",    "  "), "a"
      assert.equal make_tab("a\nb", "  "), "a\n  b"
      return
  
  describe "join_list", ()->
    it "no tab -> no work", ()->
      assert.equal join_list([],        ""), ""
      assert.equal join_list(["a"],     ""), "a"
      assert.equal join_list(["a","b"], ""), "a\nb"
      return
    
    it "tab add", ()->
      assert.equal join_list([],        "  "), ""
      assert.equal join_list(["a"],     "  "), "a"
      assert.equal join_list(["a","b"], "  "), "a\n  b"
      return
    
  