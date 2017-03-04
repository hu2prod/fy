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

### What's a profit ###

tl;dr code less

#### Array missing parts ####

    a = []
    a.push 1
    a.upush 1 # will not push because 1 is present
    a.has 1 # == true
    a.idx 1 # == 0 ; just indexOf remap
    a.remove 1 # missing in JS

