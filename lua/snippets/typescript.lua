-- ~/.config/nvim/lua/snippets/typescript.lua
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
	-- Console log with type
	s(
		"clg",
		fmt("console.log('{}: ', {})", {
			i(1, "variable"),
			i(2, "value"),
		})
	),

	-- Arrow function
	s(
		"afn",
		fmt(
			[[
    const {} = ({}): {} => {{
      {}
    }}
  ]],
			{
				i(1, "functionName"),
				i(2, "arg"),
				i(3, "ReturnType"),
				i(0),
			}
		)
	),

	-- Interface declaration
	s(
		"int",
		fmt("interface {} {{\n  {}\n}}", {
			i(1, "Name"),
			i(0),
		})
	),

	-- Type declaration
	s(
		"type",
		fmt("type {} = {{\n  {}\n}}", {
			i(1, "TypeName"),
			i(0),
		})
	),

	-- Generic type
	s(
		"generic",
		fmt("type {}<{}> = {}", {
			i(1, "TypeName"),
			i(2, "T"),
			i(0),
		})
	),

	-- Try-catch block
	s(
		"try",
		fmt(
			[[
    try {{
      {}
    }} catch (error) {{
      if (error instanceof Error) {{
        console.error('{}:', error.message);
      }}
      {}
    }}
  ]],
			{
				i(1),
				i(2, "Error context"),
				i(0),
			}
		)
	),

	-- Class definition
	s(
		"cls",
		fmt(
			[[
    class {} {{
      constructor({}) {{
        {}
      }}
      {}
    }}
  ]],
			{
				i(1, "ClassName"),
				i(2),
				i(3, "// initialization"),
				i(0),
			}
		)
	),

	-- Async function
	s(
		"asfn",
		fmt(
			[[
    async function {}({}): Promise<{}> {{
      {}
    }}
  ]],
			{
				i(1, "functionName"),
				i(2),
				i(3, "ReturnType"),
				i(0),
			}
		)
	),
	-- Fetch API call
	s(
		"fetch",
		fmt(
			[[
    const response = await fetch('{}');
    if (!response.ok) throw new Error('Failed to fetch');
    const data: {} = await response.json();
    {}
  ]],
			{
				i(1, "https://api.example.com/data"),
				i(2, "DataType"),
				i(0),
			}
		)
	),

	-- Type guard
	s(
		"guard",
		fmt(
			[[
    function is{}(obj: any): obj is {} {{
      return {}
    }}
  ]],
			{
				i(1, "TypeName"),
				rep(1),
				i(0, "'property' in obj"),
			}
		)
	),

	-- Enum declaration
	s(
		"enum",
		fmt(
			[[
    enum {} {{
      {},
    }}
  ]],
			{
				i(1, "EnumName"),
				i(0),
			}
		)
	),
}
