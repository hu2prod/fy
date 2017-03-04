window = global # для совместимости с a_generic, На сервере места не жалко, а на клиенте жалко
# ###################################################################################################
#  rubyfy
# ###################################################################################################
window.p    = console.log.bind console
window.puts = console.log.bind console
window.pe   = console.error.bind console
window.perr = console.error.bind console
window.print= (t)-> process.stdout.write t # TODO bind
window.println= console.log

# ###################################################################################################
#  matlabfy
# ###################################################################################################
timer = null
window.tic = ()->
  timer = new Date

window.toc = ()->
  (new Date - timer)/1000

window.ptoc = ()->
  console.log toc().toFixed(3)+' s'
  
# ###################################################################################################
#    pretty print
# ###################################################################################################
prettyjson = require 'prettyjson'
global.pp = (t)-> console.log prettyjson.render t

# ###################################################################################################
#    String missing parts
# ###################################################################################################
String.prototype.reverse = ()->
  @split('').reverse().join('')

String.prototype.ljust = (length, char = ' ')->
  append = new Array(Math.max(0, length - @length) + 1).join char
  append = append.substr 0, length - @length
  @ + append

String.prototype.rjust = (length, char = ' ')->
  append = new Array(Math.max(0, length - @length) + 1).join char
  append = append.substr 0, length - @length
  append + @

String.prototype.center = (length, char = ' ')->
  req_length = (length - @length + 1)//2
  append = new Array(Math.max(0, (req_length)*2)).join char
  append = append.substr 0, req_length
  pre = append
  post= append
  if (2*req_length + @length) > length
    post = post.substr 0, req_length-1
  pre + @ + post

String.prototype.repeat = (count)->
  res = new Array count+1
  res.join @

Number.prototype.ljust  = (length, char = ' ')-> @.toString().ljust length, char
Number.prototype.rjust  = (length, char = ' ')-> @.toString().rjust length, char
Number.prototype.center = (length)-> @.toString().center length
Number.prototype.repeat = (count)-> @.toString().repeat count

# ###################################################################################################
#  Note this is polyfill between browser and server
# ###################################################################################################
window.call_later= (cb)->process.nextTick cb

# ###################################################################################################
#    Array missing parts
# ###################################################################################################
Array.prototype.has   = (t)-> -1 != @indexOf t
Array.prototype.upush = (t)->
  @push t if -1 == @indexOf t
  return

Array.isArray ?= (obj)-> obj instanceof Array
Array.prototype.clone = Array.prototype.slice
Array.prototype.clear = ()->@length = 0
Array.prototype.idx   = Array.prototype.indexOf
Array.prototype.remove_idx = (idx)->
  return @ if idx < 0 or idx >= @length
  @splice idx, 1
  @

# https://github.com/mafintosh/unordered-array-remove
Array.prototype.fast_remove = (t)->
  idx = @indexOf t
  return if idx == -1
  @[idx] = @[@length-1]
  @pop()
  @

Array.prototype.fast_remove_idx = (idx)->
  return @ if idx < 0 or idx >= @length
  @[idx] = @[@length-1]
  @pop()
  @

Array.prototype.remove = (t)->
  @remove_idx @idx t
  @

Array.prototype.last = Array.prototype.end = ()->
  @[@length-1]

Array.prototype.insert_after = (idx, t)->
  @splice idx+1, 0, t
  t

Array.prototype.append = (list)->
  for v in list
    @push v
  @

# ###################################################################################################
#    hash missing parts
# ###################################################################################################
window.h_count = window.count_h = window.hash_count = window.count_hash = (t)->
  ret = 0
  for k of t
    ret++
  ret

window.is_object = (t)-> t == Object(t)

window.obj_set = (dst, src)->
  for k,v of src
    dst[k] = v
  dst

window.obj_clear = (t)->
  for k,v of t
    delete t[k]
  t

Array.prototype.set = (t)->
  @length = t.length
  for v,k in t
    @[k] = v
  @

window.arr_set = (dst, src)->
  dst.length = src.length
  for v,k in src
    dst[k] = v
  dst

# TODO benchmark vs [].concat(a,b) vs Array.concat vs a.concat(b)
window.array_merge = window.arr_merge = (a, b)->a.concat b

window.obj_merge = (a, b)->
  ret = {}
  for k,v of a
    ret[k] = v
  for k,v of b
    ret[k] = v
  ret

# ###################################################################################################
#    RegExp missing parts
# ###################################################################################################
# http://stackoverflow.com/questions/3115150/how-to-escape-regular-expression-special-characters-using-javascript
RegExp.escape = (text)->text.replace /[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&"

# ###################################################################################################
#  Function missing parts  
# ###################################################################################################

Function.prototype.sbind = (athis, main_rest...)->
  __this = @
  ret       = (rest...)->__this.apply athis, main_rest.concat rest
  ret.call  = (_new_athis, rest...)-> __this.apply _new_athis, main_rest.concat rest
  ret.apply = (_new_athis, rest)->    __this.apply _new_athis, main_rest.concat rest
  # ret.toString = ()->__this.toString()
  ret

# ###################################################################################################
#    clone
# ###################################################################################################
window.clone = (t)->
  return t if t != Object(t)
  return t.slice() if Array.isArray t
  ret = {}
  for k,v of t
    ret[k] = v
  return ret
  t

window.deep_clone = deep_clone = (t)->
  return t if t != Object(t)
  if Array.isArray t
    res = []
    for v in t
      res.push deep_clone v
    return res
  
  res = {}
  for k,v of t
    res[k] = deep_clone v
  res


# ###################################################################################################
#    Math unpack
# ###################################################################################################
for v in 'abs min max sqrt log round ceil floor'.split ' '
  global[v] = Math[v]
_log2 = Math.log 2
_log10= Math.log 10
global.log2 ?= (t)->Math.log(t)/_log2
global.log10?= (t)->Math.log(t)/_log10
