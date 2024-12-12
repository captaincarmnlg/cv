-- filter to exclude certain tags

local target_tag = ""

function Meta(meta)
  if meta.ex then
    target_tag = pandoc.utils.stringify(meta.ex)
  else
    target_tag = ""
  end
end

function Div(el)
  if el.attr and el.attr.attributes and el.attr.attributes.ex then
    local tag = el.attr.attributes.ex
    if tag == target_tag then
      return ""
    end
  end
end

return {
  { Meta = Meta },
  { Div = Div }
}
