((identifier) @lua.parameter.self
 (#match? @lua.parameter.self "^(self|this)$"))

((function_call 
  (arguments 
    (identifier) @function.pcall.lua
  (#match? @function.pcall.lua "^require$"))))
