[![Build Status](https://travis-ci.org/hu2prod/fy.svg?branch=master)](https://travis-ci.org/hu2prod/fy)

**WARNING** this module will work only with coffee-script or iced-coffee-script
##  Description ##

It's result of 2+ years tweaking of kinda minimal set of features I needed without requiring 100500 micromodules.

## Install ##

    npm i hu2prod/fy

## Usage ##
Start your new one-purpose base.coffee file with this

    #!/usr/bin/iced
    ### !pragma coverage-skip-block ###
    require 'fy'

## What's a profit ##

tl;dr code less

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
    p list.join '_'
    for row, idx in matrix
      list = [idx.rjust size]
      for val in row
        list.push val.toFixed(2).rjust size
      p list.join '_'

#### Object missing parts ####

    a = {some:1, complex:2, object:3, with:4, too:5, many:6, keys:7}
    obj_clear a
    # have clear {} but keep reference
    a.length # == undefined
    h_count a # == 7
    count_h a # == 7 # if you can't remember right order
    
    obj_merge {a:1}, {b:2}, {c:3} # NOTE extends is not standard ES4 and more verbose
