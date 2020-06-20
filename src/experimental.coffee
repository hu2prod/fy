require "./index" # for macro ops

Function.prototype.wrap_once = ()->
  old_fn = @
  ()->
    return if !old_fn
    _fn = old_fn
    old_fn = null
    _fn arguments...
