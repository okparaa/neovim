-- ~/.config/nvim/lua/snippets/typescriptreact.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- Helper to get component name from filename
local get_component_name = function()
	local filename = vim.fn.expand("%:t:r")
	return filename:gsub("^%l", string.upper):gsub("_", "")
end

return {
	s(
		"clg",
		fmt("console.log('{}:', {})", {
			i(1, "label"),
			i(2, "data"),
		})
	),
	-- Functional component
	s(
		"rfc",
		fmt(
			[[
    interface {}Props {{
      {}
    }}
    
    const {}: React.FC<{}Props> = ({{{}}}) => {{
      {}
      return (
        <div>
          {}
        </div>
      )
    }}
    
    export default {}
  ]],
			{
				f(get_component_name),
				i(1),
				f(get_component_name),
				f(get_component_name),
				i(2, "props"),
				i(3, "// hooks and logic"),
				i(0),
				f(get_component_name),
			}
		)
	),

	-- useState hook
	s(
		"us",
		fmt(
			[[
    const [{}, set{}] = useState<{}>({})
  ]],
			{
				i(1, "state"),
				f(function(args)
					return args[1][1]:gsub("^%l", string.upper)
				end, { 1 }),
				i(2, "StateType"),
				i(3, "initialValue"),
			}
		)
	),

	-- useEffect hook
	s(
		"ue",
		fmt(
			[[
    useEffect(() => {{
      {}
      {}
    }}, [{}])
  ]],
			{
				i(1, "// effect logic"),
				c(2, {
					t(""),
					fmt("return () => {{\n  {}\n}}", { i(1, "// cleanup") }),
				}),
				i(3),
			}
		)
	),

	-- useMemo hook
	s(
		"um",
		fmt(
			[[
    const {} = useMemo(() => {{
      {}
      return {}
    }}, [{}])
  ]],
			{
				i(1, "memoizedValue"),
				i(2, "// calculation"),
				i(3),
				i(4),
			}
		)
	),

	-- Custom hook
	s(
		"ch",
		fmt(
			[[
    function use{}({}) {{
      {}
      return {}
    }}
  ]],
			{
				i(1, "CustomHook"),
				i(2, "initialValue"),
				i(3, "// hook logic"),
				i(0),
			}
		)
	),

	-- Context provider
	s(
		"ctx",
		fmt(
			[[
    interface {}ContextType {{
      {}
    }}
    
    const {}Context = createContext<{}ContextType | null>(null)
    
    export function {}({{ children }}: {{ children: React.ReactNode }}) {{
      {}
      return (
        <{}Context.Provider value={{}}>
          {{children}}
        </{}Context.Provider>
      )
    }}
    
    export function use{}() {{
      const context = useContext({}Context)
      if (!context) throw new Error('use{} must be used within a {}')
      return context
    }}
  ]],
			{
				f(get_component_name),
				i(1),
				f(get_component_name),
				f(get_component_name),
				f(get_component_name),
				i(2, "// state and logic"),
				f(get_component_name),
				f(get_component_name),
				f(get_component_name),
				f(get_component_name),
				f(get_component_name),
				f(get_component_name),
			}
		)
	),

	-- Next.js page component
	s(
		"npage",
		fmt(
			[[
    interface PageProps {{
      {}
    }}
    
    export default function Page({{{}}}: PageProps) {{
      return (
        <main>
          {}
        </main>
      )
    }}
  ]],
			{
				i(1),
				i(2, "props"),
				i(0),
			}
		)
	),

	-- Server component
	-- Next.js Server Component (FIXED)
	s(
		"nsc",
		fmt(
			[[
    interface Props {{
      {}
    }}
    
    export default async function {}({{{}}}: Props) {{
      {}
      return (
        <>
          {}
        </>
      )
    }}
  ]],
			{
				i(1), -- Props interface
				f(get_component_name), -- Component name
				i(2, "params"), -- Function params
				i(3, "// await data fetching"), -- Body content
				i(0), -- JSX content
			}
		)
	),

	-- Client component
	s(
		"ncc",
		fmt(
			[[
    'use client'
    
    interface Props {{
      {}
    }}
    
    export default function {}({{{}}}: Props) {{
      {}
      return (
        <div>
          {}
        </div>
      )
    }}
  ]],
			{
				i(1),
				f(get_component_name),
				i(2, "props"),
				i(3, "// client-side logic"),
				i(0),
			}
		)
	),

	-- Next.js Link component
	s(
		"nlink",
		fmt(
			[[
    <Link href="{}"{}>{}</Link>
  ]],
			{
				i(1, "/path"),
				c(2, {
					t(""),
					fmt(' className="{}"', { i(1) }),
					fmt(' target="_blank" rel="noopener noreferrer"', {}),
				}),
				i(0, "Link text"),
			}
		)
	),

	-- Next.js Image component
	s(
		"nimg",
		fmt(
			[[
    <Image
      src="{}"
      alt="{}"
      width={}
      height={}
      {}
    />
  ]],
			{
				i(1, "/image.jpg"),
				i(2, "description"),
				i(3, "500"),
				i(4, "300"),
				c(5, {
					t(""),
					fmt("priority", {}),
					fmt('loading="lazy"', {}),
				}),
			}
		)
	),
}
