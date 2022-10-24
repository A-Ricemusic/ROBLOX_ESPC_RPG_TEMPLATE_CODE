-- Animation Module
-- Username
-- September 29, 2022

--[[
INSTRUCTIONS

--FUNCTIONS:

-----------------------------
module.Rig(model to rig) - returns a rig
--Sets up a model to be an animatable rig
--Example:
	Let's say you have a monster model you want to animate, with a script inside.
	In the script, you have a line:
	
		rig = module.Rig(script.Parent)
	
	You can then use the returned "rig" to play your animations.
	
-----------------------------
rig.Play(animation [,loop]) - returns nothing
--Plays an animation on the rig
--Example:
	You have an animation defined like this:
	
		Splits = { --This curly brace is the beginning of the animation
			{ --This curly brace begins the first frame
				speed = 8, duration = 2,
				moves = {rightLeg = 90, leftLeg = -90}
			},
			{ --This brace begins the second frame
				speed = 8, duration = 2,
				moves = {rightLeg = -90, leftLeg = 90
			}
		}
	
	To play the animation, use:
	
		rig.Play(Splits)
		
	If you want to loop the animation, do this:
	
		rig.Play(Splits,true)

-----------------------------
rig.Stiff([speed]) - returns nothing
--Resets all target positions and angles in the rig's constraints to 0
--You optionally pass in a speed at which the constraints reset.

-----------------------------

--ANIMATIONS:

An animation is simply a table (dictionary) with keys and values arranged in specific ways.
You can keep animations in a module to be retrieved, or you could even
define animations in the script that uses them. Wherever you decide to store your
animations, the layout of an animation is the same.

An animation contains frames, which are also tables. When an animation is played, each frame
will be used in sequence to set the angles and speeds of constraints in your rig.

Required components (or keys) of an animation frame are:
-speed (the constraint's target speeds will be set to this value in each frame)
-duration (the time to wait before moving on to the next frame)
-moves (the information for the angles and positions to set the constraints)
Optional:
-speeds (a table, not to be confused with "speed," including "speeds" in your frame allows for moving
	individual constraints at separate speeds, essentially overriding the frame speed for that constraint)
-preFunc (a function that is called at the beginning of the frame)
-postFunc (a function that is called at the end of the frame)

--Example:

		DoStuff = { --This is the opening brace for the animation
			--This is a frame--
			{
				preFunc = function() --the preFunc will be called at the beginning of the frame
					script.Parent.Part.BrickColor = BrickColor.Gray()
				end,
				speed = 3, duration = 3,--Each frame needs a speed, duration, and moves
				moves = {h = 45, p = 5, c = {TargetAngle = 45, TargetPosition = 5, AngularSpeed = 0.5, Speed = 2}}
			}, --Don't forget your commas
			------------------
			

			--This is a frame--
			{
				speeds = {p = 30}, --Use a "speeds" table to override the frame speed for certain constraints
				speed = 4, duration = 3,
				moves = {h = 180, p = 15, c = {TargetAngle = 180, TargetPosition = 15}},
				postFunc = function() --the postFunc will be called at the end of the frame
					script.Parent.Part.BrickColor = BrickColor.Red()
				end
			},
			------------------
			

			--This is a frame--
			{
				speed = 12, duration = 3,
				moves = {h = 0, p = 0, c = {TargetAngle = 0, TargetPosition = 0}}
			}
			------------------
		}

--MODEL HEIRARCHY
You can have parts more than one generation deep in your model and this module will still work.
Example 1:
	-Monster
		-Head
		-Torso
		-Left Leg <-- a model or folder
			-ImportantPart1
				-HingeConstraint
			-AnotherPartInLeg
		-Right Leg <-- a model or folder
			-ImportantPart2
				-HingeConstraint
			-AnotherPartInLeg

In the above example, ImportantPart1 and ImportantPart2 will be tracked in the rigged monster,
and "ImportantPart1" and "ImportantPart2" will be the reference names for animating constraints.
So, a "moves" block in an animation frame will look like:

		moves = {ImportantPart1 = 40}

However, if more than one constraint are found in a part, then the constraints are tracked differently.
In such a case, the names of the constraints are used instead, so they should be named something
specific.
Example 2:
	-Monster
		-Head
		-Torso
		-Left Leg <-- a model or folder
			-ImportantPart1
				-HingeConstraint1 <--The constraint needs a specific name this time
				-HingeConstraint2
			-AnotherPartInLeg
		-Right Leg <-- a model or folder
			-ImportantPart2
				-HingeConstraint3
				-PrismaticConstraint1
			-AnotherPartInLeg
				-HingeConstraint

In this case, each constraint has a unique name so that the module can differentiate between them.
A "moves" block will now look like this:

		moves = {
			HingeConstraint1 = 40,
			AnotherPartInLeg = 40
		}

HingConstraint1 is referred to by its own name because it has a sibling constraint, but AnotherPartInLeg
still uses the part's name because the part only contains one constraint.


--DOODAD EXAMPLE: https://www.roblox.com/library/6153633482/Doodad-Example

]]--

local AnimationModule = {}

function ScanRig(item,rig)
	local partJoints = {}
	for _,v in pairs(item:GetChildren()) do
		if v:IsA("Constraint") then
			table.insert(partJoints,v)
		end
		ScanRig(v,rig)
	end
	if #partJoints > 1 then
		for i,v in pairs(partJoints) do
			rig.joints[v.Name] = v
		end
	elseif #partJoints == 1 then
		local joint = partJoints[1]
		rig.joints[joint.Parent.Name] = joint
	end
end


function FailCommand(rig)
	rig.lastCommandTime = os.clock()
end

function FailWait(rig, amount)
	local t = rig.lastCommandTime
	wait(amount)
	return t ~= rig.lastCommandTime
end

    AnimationModuleodule.Rig = function(model)
	local rig = {}
	rig.joints = {}
	rig.lastCommandTime = 0
	rig.model = model
	ScanRig(model,rig)
	rig.Play = function(anim, loop)
		spawn(function()
			FailCommand(rig)
			repeat
				for _,frame in pairs(anim) do
					if frame.preFunc then spawn(frame.preFunc) end
					for jointName,angle in pairs(frame.moves) do
						local joint = rig.joints[jointName]
						local speed = frame.speed
						if frame.speeds and frame.speeds[jointName] then
							speed = frame.speeds[jointName]
						end
						if joint:IsA("HingeConstraint") then
							joint.TargetAngle = angle
							joint.AngularSpeed = speed
						elseif joint:IsA("PrismaticConstraint") then
							joint.TargetPosition = angle
							joint.Speed = speed
						elseif joint:IsA("CylindricalConstraint") then
							joint.Speed = speed
							joint.AngularSpeed = speed
							for l,b in pairs(angle) do
								joint[l] = b
							end
						end
					end
					if FailWait(rig, frame.duration) then return end
					if frame.postFunc then spawn(frame.postFunc) end
				end
			until not loop
		end)		
	end

	rig.Stiff = function(speed)
		if not speed then speed = 5 end
		FailCommand(rig)
		if not speed then speed = 1 end
		for _,v in pairs(rig.joints) do
			if v:IsA("HingeConstraint") then
				v.TargetAngle = 0
				v.AngularSpeed = speed
			elseif v:IsA("PrismaticConstraint") then
				v.TargetPosition = 0
				v.Speed = speed
			elseif v:IsA("CylindricalConstraint") then
				v.TargetPosition = 0
				v.TargetAngle = 0
				v.InclinationAngle = 0
				v.AngularSpeed = speed
				v.Speed = speed
			end
		end
	end

	return rig
end
return AnimationModule