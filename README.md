[![Build Status](https://travis-ci.org/hu2prod/fy.svg?branch=master)](https://travis-ci.org/hu2prod/fy)
[![Coverage Status](https://coveralls.io/repos/github/hu2prod/fy/badge.svg?branch=master)](https://coveralls.io/github/hu2prod/fy?branch=master)
[![Dependency Status](https://www.versioneye.com/user/projects/58ba944901b5b7003a212afd/badge.svg?style=flat-square)](https://www.versioneye.com/user/projects/58ba944901b5b7003a212afd)

##  Description ##

It's result of 2+ years tweaking of kinda minimal set of features I needed without requiring 100500 micromodules.

## Install ##

    npm i hu2prod/fy

## Usage ##
Start your new one-purpose base.coffee file with this

    #!/usr/bin/iced
    ### !pragma coverage-skip-block ###
    require "fy"

## What's a profit ##

tl;dr code less

#### Pretty print ####

    pp a: 1, b: [2, 3]        # pretty print powered by prettyjson. Do not use with circular links!
    insp a: 1, b: [2, 3]      # colourful inspect by Node.js util module. Understands circular links.
    insp a:a:a:a:a:a:a:1, 5   # 5 is depth (default depth is 2)
    
    # console.log aliases:
    p "Hello World"           # use p for debug
    puts "Hello World"        # use puts if you really mean it (for messages that should remain in production)
    println "Hello World"     # one more alias 
    
    # console.error aliases:
    pe "OMG they killed Kenny"
    perr "You bastards!"
    
    print "a"                 # process.stdout.write replacement (doesn't put \n at the end)

#### Array missing parts ####

    a = []
    a.push 1
    a.upush 1 # will not push because 1 is present
    a.has 1 # == true
    a.idx 1 # == 0 ; just indexOf remap
    a.remove 1 # missing in JS
    a = arr_merge [1], [2], [3] # concat more verbose


#### String formatting ####

e.g. matrix print

    matrix = [
      [1, 2, 3]
      [4, 5, 6]
      [7, 8, 111]
    ]
    size = 6
    list = ["#{"".center size}"]
    for row, idx in matrix
      list.push idx.center size
    p list.join "_"
    for row, idx in matrix
      list = [idx.rjust size]
      for val in row
        list.push val.toFixed(2).rjust size
      p list.join "_"

#### Object missing parts ####

    a = {some:1, complex:2, object:3, with:4, too:5, many:6, keys:7}
    obj_clear a
    # have clear {} but keep reference
    a.length # == undefined
    h_count a # == 7
    count_h a # == 7 # if you can't remember right order
    
    obj_merge {a:1}, {b:2}, {c:3} # NOTE extends is not standard ES4 and more verbose


### Codegen ###

    # it will add multiple functions to global scope
    require "fy/codegen"

#### make_tab ####

    # For example you have some scope
    child = """
    if (a) {
      fn()
    }
    """
    # you want include it here
    """
    if (b) {
      #{child}
    }
    """
    ###
    result would be
    if (b) {
      if (a) {
      fn()
    }
    }
    But we want
    if (b) {
      if (a) {
        fn()
      }
    }
    ###
    """
    if (b) {
      #{make_tab child, '  '}
    }
    """
    # now result is expected
    # make sure that there is same amount of spaces as same line indent

#### join_list ####

    # For example you have some multiple lines
    i_want_add_this_list = []
    i_want_add_this_list.push "fn1()"
    i_want_add_this_list.push "fn2()"
    i_want_add_this_list.push "fn3()"
    # you want include it here
    """
    if (a) {
      #{i_want_add_this_list.join '\n'}
    }
    """
    
    ###
    result would be
    if (a) {
      fn1()
    fn2()
    fn3()
    }
    But we want
    if (a) {
      fn1()
      fn2()
      fn3()
    }
    ###
    
    """
    if (a) {
      #{join_list i_want_add_this_list.join '  '}
    }
    """
    # now result is expected
    
