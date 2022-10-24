-- Curve Util Module
-- Username
-- October 5, 2022



local CurveUtilModule = {}

local DEFAULT_THRESHOLD = 0.01

function CurveUtilModule:Expt(start, to, pct, dt_scale)
	if math.abs(to - start) < DEFAULT_THRESHOLD then
		return to
	end

	local y = CurveUtilModule:Expty(start,to,pct,dt_scale)

	--rtv = start + (to - start) * timescaled_friction--
	local delta = (to - start) * y
	return start + delta
end

function CurveUtilModule:Expty(start, to, pct, dt_scale)
	--y = e ^ (-a * timescale)--
	local friction = 1 - pct
	local a = -math.log(friction)
	return 1 - math.exp(-a * dt_scale)
end

function CurveUtilModule:Sign(val)
	if val > 0 then
		return 1
	elseif val < 0 then
		return -1
	else
		return 0
	end
end

function CurveUtilModule:BezierValForT(p0, p1, p2, p3, t)
	local cp0 = (1 - t) * (1 - t) * (1 - t)
	local cp1 = 3 * t * (1-t)*(1-t)
	local cp2 = 3 * t * t * (1 - t)
	local cp3 = t * t * t
	return cp0 * p0 + cp1 * p1 + cp2 * p2 + cp3 * p3
end

CurveUtilModule._BezierPt2ForT = { x = 0; y = 0 }
function CurveUtilModule:BezierPt2ForT(
	p0x, p0y,
	p1x, p1y,
	p2x, p2y,
	p3x, p3y,
	t)

	CurveUtilModule._BezierPt2ForT.x = CurveUtilModule:BezierValForT(p0x,p1x,p2x,p3x,t)
	CurveUtilModule._BezierPt2ForT.y = CurveUtilModule:BezierValForT(p0y,p1y,p2y,p3y,t)
	return CurveUtilModule._BezierPt2ForT
end

function CurveUtilModule:YForPointOf2PtLine(pt1, pt2, x)
	--(y - y1)/(x - x1) = m--
	local m = (pt1.y - pt2.y) / (pt1.x - pt2.x)
	--y - mx = b--
	local b = pt1.y - m * pt1.x
	return m * x + b
end

function CurveUtilModule:DeltaTimeToTimescale(s_frame_delta_time)
	return s_frame_delta_time / (1.0 / 60.0)
end

function CurveUtilModule:SecondsToTick(sec)
	return (1 / 60.0) / sec
end

function CurveUtilModule:ExptValueInSeconds(threshold, start, seconds)
		return 1 - math.pow((threshold / start), 1 / (60.0 * seconds))
end

function CurveUtilModule:NormalizedDefaultExptValueInSeconds(seconds)
		return self:ExptValueInSeconds(DEFAULT_THRESHOLD, 1, seconds)
end


return CurveUtilModule