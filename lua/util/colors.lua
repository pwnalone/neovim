local M = {}

M.rgb_to_hex = function(r, g, b)
  return string.format("#%02x%02x%02x", r, g, b)
end

M.hex_to_rgb = function(c)
  c = string.lower(c)
  local r = tonumber(c:sub(2, 3), 16)
  local g = tonumber(c:sub(4, 5), 16)
  local b = tonumber(c:sub(6, 7), 16)
  return { r, g, b }
end

M.round = function(val)
  return math.floor(val + 0.5)
end

M.clamp = function(val, min, max)
  return math.min(math.max(val, min), max)
end

M.blend = function(foreground, background, alpha)
  local bg = M.hex_to_rgb(background)
  local fg = M.hex_to_rgb(foreground)

  local blend_channel = function(i)
    return M.round(M.clamp(alpha * fg[i] + ((1 - alpha) * bg[i]), 0, 255))
  end

  local r = blend_channel(1)
  local g = blend_channel(2)
  local b = blend_channel(3)

  return M.rgb_to_hex(r, g, b)
end

M.darken = function(color, amount, bg)
  return M.blend(color, bg or "#000000", amount)
end

return M
