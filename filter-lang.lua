-- A Lua filter to include only specific language sections
-- local target_lang = PANDOC_STATE.lang or "en" -- Default language to "en"

local target_lang = ""

function Meta(meta)
  if meta.lang then
    target_lang = pandoc.utils.stringify(meta.lang)
  else
    target_lang = "en" -- Default language
  end
end

function Div(el)
  if el.attr and el.attr.attributes and el.attr.attributes.lang then
    local lang = el.attr.attributes.lang
    if lang ~= target_lang then
      return ""
    end
  end
end

return {
  { Meta = Meta },
  { Div = Div }
}
