-- Ajouter à votre configuration LazyVim
return {

{
  "xaocdev/vim-coolclass",
  ft = "cpp",
  config = function()
    vim.g.coolclass_templates = {
      cpp = {
        header = [[
#pragma once

class ${ClassName} {
public:
    ${ClassName}();
    virtual ~${ClassName}();

    // Add your class methods here
};]],
        source = [[
#include "${ClassName}.hpp"

${ClassName}::${ClassName}() {}
${ClassName}::~${ClassName}() {}

// Implement your methods here
]]
      }
    }
  end
}
}
