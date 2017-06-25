# ###################################################################################################
#    experimental __FILE__ __STACK__ __LINE__
# ###################################################################################################
`
Object.defineProperty(global, '__STACK__', {
  get: function(){
    var orig = Error.prepareStackTrace;
    Error.prepareStackTrace = function(_, stack){ return stack; };
    var err = new Error;
    Error.captureStackTrace(err, arguments.callee);
    var stack = err.stack;
    Error.prepareStackTrace = orig;
    return stack;
  }
});

Object.defineProperty(global, '__LINE__', {
  get: function(){
    return __STACK__[1].getLineNumber();
  }
});

Object.defineProperty(global, '__FILE__', {
  get: function(){
    return __STACK__[1].getFileName().split('/').slice(-1)[0];
  }
});
`