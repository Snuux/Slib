local slib = {
  _VERSION = 'slib v1.0',
  _DESCRIPTION = 'Save files easy for Love2D',
  _LICENSE = [[
MIT LICENSE

Copyright (c) 2014 Richkov Vadim. Snuux

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Thanks TSerial for pack and unpack functions!
]]
}

local n = ""

function slib.pack(t, drop, indend)
	assert(type(t) == "table", "Can only slib.pack tables.")
	local s, empty, indent = "{"..(indent and "\n" or ""), true, indent and math.max(type(indent)=="number" and indent or 0,0)
	local function proc(k,v, omitKey)
  empty = nil	
  local tk, tv, skip = type(k), type(v)
  local pack = slib.pack
  
  if type(drop)=="table" and drop[k] then k = "["..drop[k].."]"
  elseif tk == "boolean" then k = k and "[true]" or "[false]"
  elseif tk == "string" then local f = string.format("%q",k) if f ~= '"'..k..'"' then k = '['..f..']' end
  elseif tk == "number" then k = "["..k.."]"
  elseif tk == "table" then k = "["..pack(k, drop, indent and indent+1).."]"
  elseif type(drop) == "function" then k = "["..string.format("%q",drop(k)).."]"
  elseif drop then skip = true
  else error("Attempted to slib.pack a table with an invalid key: "..tostring(k))
  end

  if type(drop)=="table" and drop[v] then v = drop[v]
  elseif tv == "boolean" then v = v and "true" or "false"
  elseif tv == "string" then v = string.format("%q", v)
  elseif tv == "number" then
  elseif tv == "table" then v = pack(v, drop, indent and indent+1)
  elseif type(drop) == "function" then v = string.format("%q",drop(v))
  elseif drop then skip = true
  else error("Attempted to slib.pack a table with an invalid value: "..tostring(v))
  end

  if not skip then return string.rep("\t",indent or 0)..(omitKey and "" or k.."=")..v..","..(indent and "\n" or "") end
  return ""
  end

	local l=-1 repeat l=l+1 until t[l+1]==nil	
	for i=1,l do s = s..proc(i, t[i], true) end
	for k, v in pairs(t) do if not (type(k)=="number" and k<=l) then s = s..proc(k, v) end end
	if not empty then s = string.sub(s,1,string.len(s)-1) end
	if indent then s = string.sub(s,1,string.len(s)-1).."\n" end
	return s..string.rep("\t",(indent or 1)-1).."}"
end

function slib.unpack(s, safe)
	if safe then s = string.match(s, "(%b{})") end
  assert(type(s) == "string", "Can only slib.unpack strings.")
	local f, result = loadstring(n..".table="..s)
  
	if not safe then assert(f,result) elseif not f then return nil, result end
	result = f()
	local t = slib.table
	slib.table = nil
	return t, result
end

function slib.init(s)
  n = s
end

function slib.convert( chars, dist, inv )
  return string.char( ( string.byte( chars ) - 32 + ( inv and -dist or dist ) ) % 95 + 32 )
end

function slib.crypt(str, k, inv)
  local convert = slib.convert
  
  local enc= ""
  for i=1,#str do
    if(#str-k[5] >= i or not inv) then
      for inc=0,3 do
        if(i%4 == inc)then
          enc = enc .. convert(string.sub(str,i,i),k[inc+1],inv);
          break;
        end
      end
    end
  end
  
  if(not inv)then
    for i=1,k[5] do
      enc = enc .. string.char(math.random(32,126));
    end
  end
  
  return enc;
end

function slib.isFirstSave(filename)
  filename = filename or "save.dat"
  if love.filesystem.isFile(filename) then
    return false
  end
  return true
end

function slib.saveE(table, filename, drop, enc)
  filename = filename or "save.dat"
  enc = enc or {29, 58, 93, 28, 27}
  drop = {drop} or {}
  local string = slib.pack(table, drop)
  
  local crypted = slib.crypt(string, enc)
  love.filesystem.write(filename, crypted)
  love.filesystem.append(filename, "e", 1)
  
  return true
end

function slib.save(table, filename, drop, enc)
  filename = filename or "save.dat"
  enc = enc or {29, 58, 93, 28, 27}
  drop = {drop} or {}
  local string = slib.pack(table, drop)
  
  love.filesystem.write(filename, string)
  
  return true
end

function slib.load(filename, enc)
  filename = filename or "save.dat"
  enc = enc or {29, 58, 93, 28, 27}
  local tab = {}
  local str = nil
  
  if love.filesystem.isFile(filename) then
    local size = love.filesystem.getSize(filename)
    local str = love.filesystem.read(filename, size)
    local t = string.len(str)
    
    if string.sub(str, t) == 'e' then
      local str = string.sub(str, 1, t-1)
      str = slib.crypt(str, enc, true)
      tab = slib.unpack(str, true)
    else
      tab = slib.unpack(str, true)
    end
  end
  return tab, true
end

return slib