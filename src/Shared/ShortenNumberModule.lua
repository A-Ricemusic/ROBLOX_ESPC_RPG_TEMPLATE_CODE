-- Shorten Number Module
-- Username
-- October 5, 2022



local ShortenNumberModule = {}


ShortenNumberModule.Comma = function(Value)
	local Number
	local Formatted = Value
	while true do  
		Formatted, Number = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (Number == 0) then
			break
		end
	end
	return Formatted
end

function addComas(str)
	return #str % 3 == 0 and str:reverse():gsub("(%d%d%d)", "%1,"):reverse():sub(2) or str:reverse():gsub("(%d%d%d)", "%1,"):reverse()
end

local function roundWhole(n)
	return math.floor(n + 0.5)
end

local function roundDecimal(t)
    return math.floor(t * 10) * 0.1
end

ShortenNumberModule.Abb2 = function(Input)
    if Input < -1e3 then
		Input = roundWhole(tonumber(Input))
		Input = addComas(tostring(Input))
	
    elseif Input < 0 and Input >= -1e3 then
	    Input = roundDecimal(tonumber(Input))
	
	elseif Input < 1e3 and Input >= 0 then
		Input = roundDecimal(tonumber(Input))
		
	elseif Input < 0 and Input >= 1e6 then
		Input = roundDecimal(tonumber(Input))	
	
	elseif Input < 1e6 and Input >= 1e3 then
		Input = tostring(Input/1e3):sub(1,5) .. "K"
			
	elseif Input < 1e9 and Input >= 1e6 then
		Input = tostring(Input/1e6):sub(1,5) .. "M"
		
	elseif Input < 1e12 and Input >= 1e9 then
		Input = tostring(Input/1e9):sub(1,5) .. "B"
		
	elseif Input < 1e15 and Input >= 1e12 then
		Input = tostring(Input/1e12):sub(1,5) .. "T"
		
	elseif Input < 1e18 and Input >= 1e15 then
		Input = tostring(Input/1e15):sub(1,5) .. "Qd"
		
	elseif Input < 1e21 and Input >= 1e18 then
		Input = tostring(Input/1e18):sub(1,5) .. "Qn"
		
	elseif Input < 1e24 and Input >= 1e21 then
		Input = tostring(Input/1e21):sub(1,5) .. "Sx"
		
	elseif Input < 1e27 and Input >= 1e24 then
		Input = tostring(Input/1e24):sub(1,5) .. "Sp"
		
	elseif Input < 1e30 and Input >= 1e27 then
		Input = tostring(Input/1e27):sub(1,5) .. "Oc"
		
	elseif Input < 1e33 and Input >= 1e30 then
		Input = tostring(Input/1e30):sub(1,5) .. "No"
		
	elseif Input < 1e36 and Input >= 1e33 then
		Input = tostring(Input/1e33):sub(1,5) .. "De"
		
	elseif Input < 1e39 and Input >= 1e36 then
		Input = tostring(Input/1e36):sub(1,5) .. "Ud"
		
	elseif Input < 1e42 and Input >= 1e39 then
		Input = tostring(Input/1e39):sub(1,5) .. "Dd"
		
	elseif Input < 1e45 and Input >= 1e42 then
		Input = tostring(Input/1e42):sub(1,5) .. "Td"
		
	elseif Input < 1e48 and Input >= 1e45 then
		Input = tostring(Input/1e45):sub(1,5) .. "QtD"
		
	elseif Input < 1e51 and Input >= 1e48 then
		Input = tostring(Input/1e48):sub(1,5) .. "QnD"
		
	elseif Input < 1e54 and Input >= 1e51 then
		Input = tostring(Input/1e51):sub(1,5) .. "SxD"
		
	elseif Input < 1e57 and Input >= 1e54 then
		Input = tostring(Input/1e54):sub(1,5) .. "SpDe"
		
	elseif Input < 1e60 and Input >= 1e57 then
		Input = tostring(Input/1e57):sub(1,5) .. "OcD"
		
	elseif Input < 1e63 and Input >= 1e60 then
		Input = tostring(Input/1e60):sub(1,5) .. "NoD"
		
	elseif Input < 1e66 and Input >= 1e63 then
		Input = tostring(Input/1e63):sub(1,5) .. "Vg"
		
	elseif Input < 1e69 and Input >= 1e66 then
		Input = tostring(Input/1e66):sub(1,5) .. "UVg"
		
	elseif Input < 1e72 and Input >= 1e69 then
		Input = tostring(Input/1e69):sub(1,5) .. "DVg"
		
	elseif Input < 1e75 and Input >= 1e72 then
		Input = tostring(Input/1e72):sub(1,5) .. "TVg"
		
	elseif Input < 1e78 and Input >= 1e75 then
		Input = tostring(Input/1e75):sub(1,5) .. "QtVg"
		
	elseif Input < 1e81 and Input >= 1e78 then
		Input = tostring(Input/1e78):sub(1,5) .. "QnVg"
		
	elseif Input < 1e84 and Input >= 1e81 then
		Input = tostring(Input/1e81):sub(1,5) .. "SxVg"
		
	elseif Input < 1e87 and Input >= 1e84 then
		Input = tostring(Input/1e84):sub(1,5) .. "SpVg"
		
	elseif Input < 1e90 and Input >= 1e87 then
		Input = tostring(Input/1e87):sub(1,5) .. "OcVg"
		
	elseif Input < 1e93 and Input >= 1e90 then
		Input = tostring(Input/1e90):sub(1,5) .. "NoVg"
		
	elseif Input < 1e96 and Input >= 1e93 then
		Input = tostring(Input/1e93):sub(1,5) .. "Tg"
		
	elseif Input < 1e99 and Input >= 1e96 then
		Input = tostring(Input/1e96):sub(1,5) .. "UTg"
		
	elseif Input < 1e102 and Input >= 1e99 then
		Input = tostring(Input/1e99):sub(1,5) .. "DTg"
		
	elseif Input < 1e105 and Input >= 1e102 then
		Input = tostring(Input/1e102):sub(1,5) .. "TTg"
		
	elseif Input < 1e108 and Input >= 1e105 then
		Input = tostring(Input/1e105):sub(1,5) .. "QdTg"
		
	elseif Input < 1e111 and Input >= 1e108 then
		Input = tostring(Input/1e108):sub(1,5) .. "QnTg"
		
	elseif Input < 1e114 and Input >= 1e111 then
		Input = tostring(Input/1e111):sub(1,5) .. "SxTg"
		
	elseif Input < 1e117 and Input >= 1e114 then
		Input = tostring(Input/1e114):sub(1,5) .. "SpTg"
		
	elseif Input < 1e120 and Input >= 1e117 then
		Input = tostring(Input/1e117):sub(1,5) .. "OcTg"
		
	elseif Input < 1e123 and Input >= 1e120 then
		Input = tostring(Input/1e120):sub(1,5) .. "NoTg"
		
	elseif Input < 1e126 and Input >= 1e123 then
		Input = tostring(Input/1e123):sub(1,5) .. "qg"
		
	elseif Input < 1e129 and Input >= 1e126 then
		Input = tostring(Input/1e126):sub(1,5) .. "Uqg"
		
	elseif Input < 1e132 and Input >= 1e129 then
		Input = tostring(Input/1e129):sub(1,5) .. "Dqg"
		
	elseif Input < 1e135 and Input >= 1e132 then
		Input = tostring(Input/1e132):sub(1,5) .. "Tqg"
		
	elseif Input < 1e138 and Input >= 1e135 then
		Input = tostring(Input/1e135):sub(1,5) .. "Qdqg"
		
	elseif Input < 1e141 and Input >= 1e138 then
		Input = tostring(Input/1e138):sub(1,5) .. "Qnqg"
		
	elseif Input < 1e144 and Input >= 1e141 then
		Input = tostring(Input/1e141):sub(1,5) .. "Sxqg"
		
	elseif Input < 1e147 and Input >= 1e144 then
		Input = tostring(Input/1e144):sub(1,5) .. "Spqg"
		
	elseif Input < 1e150 and Input >= 1e147 then
		Input = tostring(Input/1e147):sub(1,5) .. "Ocqg"
		
	elseif Input < 1e153 and Input >= 1e150 then
		Input = tostring(Input/1e150):sub(1,5) .. "Noqg"
		
	elseif Input < 1e156 and Input >= 1e153 then
		Input = tostring(Input/1e153):sub(1,5) .. "Qg"
		
	elseif Input < 1e159 and Input >= 1e156 then
		Input = tostring(Input/1e156):sub(1,5) .. "UQg"
		
	elseif Input < 1e162 and Input >= 1e159 then
		Input = tostring(Input/1e159):sub(1,5) .. "DQg"
		
	elseif Input < 1e165 and Input >= 1e162 then
		Input = tostring(Input/1e162):sub(1,5) .. "TQg"
		
	elseif Input < 1e168 and Input >= 1e165 then
		Input = tostring(Input/1e165):sub(1,5) .. "QdQg"
		
	elseif Input < 1e171 and Input >= 1e168 then
		Input = tostring(Input/1e168):sub(1,5) .. "QnQg"
		
	elseif Input < 1e174 and Input >= 1e171 then
		Input = tostring(Input/1e171):sub(1,5) .. "SxQg"
		
	elseif Input < 1e177 and Input >= 1e174 then
		Input = tostring(Input/1e174):sub(1,5) .. "SpQg"
		
	elseif Input < 1e180 and Input >= 1e177 then
		Input = tostring(Input/1e177):sub(1,5) .. "OcQg"
		
	elseif Input < 1e183 and Input >= 1e180 then
		Input = tostring(Input/1e180):sub(1,5) .. "NoQg"
		
	elseif Input < 1e186 and Input >= 1e183 then
		Input = tostring(Input/1e183):sub(1,5) .. "sg"
		
	elseif Input < 1e189 and Input >= 1e186 then
		Input = tostring(Input/1e186):sub(1,5) .. "Usg"
		
	elseif Input < 1e192 and Input >= 1e189 then
		Input = tostring(Input/1e189):sub(1,5) .. "Dsg"
		
	elseif Input < 1e195 and Input >= 1e192 then
		Input = tostring(Input/1e192):sub(1,5) .. "Tsg"
		
	elseif Input < 1e198 and Input >= 1e195 then
		Input = tostring(Input/1e195):sub(1,5) .. "Qdsg"
		
	elseif Input < 1e201 and Input >= 1e198 then
		Input = tostring(Input/1e198):sub(1,5) .. "Qnsg"
		
	elseif Input < 1e204 and Input >= 1e201 then
		Input = tostring(Input/1e201):sub(1,5) .. "Sxsg"
		
	elseif Input < 1e207 and Input >= 1e204 then
		Input = tostring(Input/1e204):sub(1,5) .. "Spsg"
		
	elseif Input < 1e210 and Input >= 1e207 then
		Input = tostring(Input/1e207):sub(1,5) .. "Ocsg"
		
	elseif Input < 1e213 and Input >= 1e210 then
		Input = tostring(Input/1e210):sub(1,5) .. "Nosg"
		
	elseif Input < 1e216 and Input >= 1e213 then
		Input = tostring(Input/1e213):sub(1,5) .. "Sg"
		
	elseif Input < 1e219 and Input >= 1e216 then
		Input = tostring(Input/1e216):sub(1,5) .. "USg"
		
	elseif Input < 1e222 and Input >= 1e219 then
		Input = tostring(Input/1e219):sub(1,5) .. "DSg"
		
	elseif Input < 1e225 and Input >= 1e222 then
		Input = tostring(Input/1e222):sub(1,5) .. "TSg"
		
	elseif Input < 1e228 and Input >= 1e225 then
		Input = tostring(Input/1e225):sub(1,5) .. "QdSg"
		
	elseif Input < 1e231 and Input >= 1e228 then
		Input = tostring(Input/1e228):sub(1,5) .. "QnSg"
		
	elseif Input < 1e234 and Input >= 1e231 then
		Input = tostring(Input/1e231):sub(1,5) .. "SxSg"
		
	elseif Input < 1e237 and Input >= 1e234 then
		Input = tostring(Input/1e234):sub(1,5) .. "SpSg"
		
	elseif Input < 1e240 and Input >= 1e237 then
		Input = tostring(Input/1e237):sub(1,5) .. "OcSg"
		
	elseif Input < 1e243 and Input >= 1e240 then
		Input = tostring(Input/1e240):sub(1,5) .. "NoSg"
		
	elseif Input < 1e246 and Input >= 1e243 then
		Input = tostring(Input/1e243):sub(1,5) .. "Og"
		
	elseif Input < 1e249 and Input >= 1e246 then
		Input = tostring(Input/1e246):sub(1,5) .. "UOg"
		
	elseif Input < 1e252 and Input >= 1e249 then
		Input = tostring(Input/1e249):sub(1,5) .. "DOg"
		
	elseif Input < 1e255 and Input >= 1e252 then
		Input = tostring(Input/1e252):sub(1,5) .. "TOg"
		
	elseif Input < 1e258 and Input >= 1e255 then
		Input = tostring(Input/1e255):sub(1,5) .. "QdOg"
		
	elseif Input < 1e261 and Input >= 1e258 then
		Input = tostring(Input/1e258):sub(1,5) .. "QnOg"
		
	elseif Input < 1e264 and Input >= 1e261 then
		Input = tostring(Input/1e261):sub(1,5) .. "SxOg"
		
	elseif Input < 1e267 and Input >= 1e264 then
		Input = tostring(Input/1e264):sub(1,5) .. "SpOg"
		
	elseif Input < 1e270 and Input >= 1e267 then
		Input = tostring(Input/1e267):sub(1,5) .. "OcOg"
		
	elseif Input < 1e273 and Input >= 1e270 then
		Input = tostring(Input/1e270):sub(1,5) .. "NoOg"
		
	elseif Input < 1e276 and Input >= 1e273 then
		Input = tostring(Input/1e273):sub(1,5) .. "Ng"
		
	elseif Input < 1e279 and Input >= 1e276 then
		Input = tostring(Input/1e276):sub(1,5) .. "UNg"
		
	elseif Input < 1e282 and Input >= 1e279 then
		Input = tostring(Input/1e279):sub(1,5) .. "DNg"
		
	elseif Input < 1e285 and Input >= 1e282 then
		Input = tostring(Input/1e282):sub(1,5) .. "TNg"
		
	elseif Input < 1e288 and Input >= 1e285 then
		Input = tostring(Input/1e285):sub(1,5) .. "QdNg"
		
	elseif Input < 1e291 and Input >= 1e288 then
		Input = tostring(Input/1e288):sub(1,5) .. "QnNg"
		
	elseif Input < 1e294 and Input >= 1e291 then
		Input = tostring(Input/1e291):sub(1,5) .. "SxNg"
		
	elseif Input < 1e297 and Input >= 1e294 then
		Input = tostring(Input/1e294):sub(1,5) .. "SpNg"
		
	elseif Input < 1e300 and Input >= 1e297 then
		Input = tostring(Input/1e297):sub(1,5) .. "OcNg"
		
	elseif Input < 1e303 and Input >= 1e300 then
		Input = tostring(Input/1e300):sub(1,5) .. "NoNg"
		
	elseif Input < 1e306 and Input >= 1e303 then
		Input = tostring(Input/1e303):sub(1,5) .. "Ce"
		
	elseif Input < 1.7976931348e308 and Input >= 1e306 then
		Input = addComas(tostring(Input/1e303):sub(1,5)) .. "Ce"
		
    elseif Input >= 1.7976931348e308 then
	    Input = "Infinity"		
	end
		
	return Input
end



return ShortenNumberModule