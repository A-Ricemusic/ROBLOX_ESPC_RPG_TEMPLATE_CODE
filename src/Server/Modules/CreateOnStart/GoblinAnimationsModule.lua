-- Goblin Animations Module
-- Username
-- October 4, 2022



local GoblinAnimationsModule = {}

local partsWithId = {}
local awaitRef = {}


function GoblinAnimationsModule:Start(Parent)
    local root = {
        ID = 0;
        Type = "Folder";
        Properties = {
            Name = "Animations";
        };
        Children = {
            {
                ID = 1;
                Type = "StringValue";
                Properties = {
                    Name = "cheer";
                };
                Children = {
                    {
                        ID = 2;
                        Type = "Animation";
                        Properties = {
                            Name = "CheerAnim";
                            AnimationId = "http://www.roblox.com/asset/?id=507770677";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 3;
                Type = "StringValue";
                Properties = {
                    Name = "climb";
                };
                Children = {
                    {
                        ID = 4;
                        Type = "Animation";
                        Properties = {
                            Name = "ClimbAnim";
                            AnimationId = "http://www.roblox.com/asset/?id=616156119";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 5;
                Type = "StringValue";
                Properties = {
                    Name = "dance";
                };
                Children = {
                    {
                        ID = 6;
                        Type = "Animation";
                        Properties = {
                            Name = "Animation1";
                            AnimationId = "http://www.roblox.com/asset/?id=507771019";
                        };
                        Children = {
                            {
                                ID = 7;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                    Value = 10;
                                };
                                Children = {};
                            };
                        };
                    };
                    {
                        ID = 8;
                        Type = "Animation";
                        Properties = {
                            Name = "Animation2";
                            AnimationId = "http://www.roblox.com/asset/?id=507771955";
                        };
                        Children = {
                            {
                                ID = 9;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                    Value = 10;
                                };
                                Children = {};
                            };
                        };
                    };
                    {
                        ID = 10;
                        Type = "Animation";
                        Properties = {
                            Name = "Animation3";
                            AnimationId = "http://www.roblox.com/asset/?id=507772104";
                        };
                        Children = {
                            {
                                ID = 11;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                    Value = 10;
                                };
                                Children = {};
                            };
                        };
                    };
                };
            };
            {
                ID = 12;
                Type = "StringValue";
                Properties = {
                    Name = "dance2";
                };
                Children = {
                    {
                        ID = 13;
                        Type = "Animation";
                        Properties = {
                            Name = "Animation1";
                            AnimationId = "http://www.roblox.com/asset/?id=507776043";
                        };
                        Children = {
                            {
                                ID = 14;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                    Value = 10;
                                };
                                Children = {};
                            };
                        };
                    };
                    {
                        ID = 15;
                        Type = "Animation";
                        Properties = {
                            Name = "Animation2";
                            AnimationId = "http://www.roblox.com/asset/?id=507776720";
                        };
                        Children = {
                            {
                                ID = 16;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                    Value = 10;
                                };
                                Children = {};
                            };
                        };
                    };
                    {
                        ID = 17;
                        Type = "Animation";
                        Properties = {
                            Name = "Animation3";
                            AnimationId = "http://www.roblox.com/asset/?id=507776879";
                        };
                        Children = {
                            {
                                ID = 18;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                    Value = 10;
                                };
                                Children = {};
                            };
                        };
                    };
                };
            };
            {
                ID = 19;
                Type = "StringValue";
                Properties = {
                    Name = "dance3";
                };
                Children = {
                    {
                        ID = 20;
                        Type = "Animation";
                        Properties = {
                            Name = "Animation1";
                            AnimationId = "http://www.roblox.com/asset/?id=507777268";
                        };
                        Children = {
                            {
                                ID = 21;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                    Value = 10;
                                };
                                Children = {};
                            };
                        };
                    };
                    {
                        ID = 22;
                        Type = "Animation";
                        Properties = {
                            Name = "Animation2";
                            AnimationId = "http://www.roblox.com/asset/?id=507777451";
                        };
                        Children = {
                            {
                                ID = 23;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                    Value = 10;
                                };
                                Children = {};
                            };
                        };
                    };
                    {
                        ID = 24;
                        Type = "Animation";
                        Properties = {
                            Name = "Animation3";
                            AnimationId = "http://www.roblox.com/asset/?id=507777623";
                        };
                        Children = {
                            {
                                ID = 25;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                    Value = 10;
                                };
                                Children = {};
                            };
                        };
                    };
                };
            };
            {
                ID = 26;
                Type = "StringValue";
                Properties = {
                    Name = "fall";
                };
                Children = {
                    {
                        ID = 27;
                        Type = "Animation";
                        Properties = {
                            Name = "FallAnim";
                            AnimationId = "http://www.roblox.com/asset/?id=616157476";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 28;
                Type = "StringValue";
                Properties = {
                    Name = "idle";
                };
                Children = {
                    {
                        ID = 29;
                        Type = "Animation";
                        Properties = {
                            Name = "Animation1";
                            AnimationId = "rbxassetid://3489171152";
                        };
                        Children = {
                            {
                                ID = 30;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                    Value = 9;
                                };
                                Children = {};
                            };
                        };
                    };
                    {
                        ID = 31;
                        Type = "Animation";
                        Properties = {
                            Name = "Animation2";
                            AnimationId = "rbxassetid://3489171152";
                        };
                        Children = {
                            {
                                ID = 32;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                    Value = 1;
                                };
                                Children = {};
                            };
                        };
                    };
                };
            };
            {
                ID = 33;
                Type = "StringValue";
                Properties = {
                    Name = "jump";
                };
                Children = {
                    {
                        ID = 34;
                        Type = "Animation";
                        Properties = {
                            Name = "JumpAnim";
                            AnimationId = "http://www.roblox.com/asset/?id=616161997";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 35;
                Type = "StringValue";
                Properties = {
                    Name = "laugh";
                };
                Children = {
                    {
                        ID = 36;
                        Type = "Animation";
                        Properties = {
                            Name = "LaughAnim";
                            AnimationId = "http://www.roblox.com/asset/?id=507770818";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 37;
                Type = "StringValue";
                Properties = {
                    Name = "point";
                };
                Children = {
                    {
                        ID = 38;
                        Type = "Animation";
                        Properties = {
                            Name = "PointAnim";
                            AnimationId = "http://www.roblox.com/asset/?id=507770453";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 39;
                Type = "StringValue";
                Properties = {
                    Name = "pose";
                };
                Children = {
                    {
                        ID = 40;
                        Type = "Animation";
                        Properties = {
                            Name = "ZombiePose";
                            AnimationId = "http://www.roblox.com/asset/?id=885545458";
                        };
                        Children = {
                            {
                                ID = 41;
                                Type = "NumberValue";
                                Properties = {
                                    Name = "Weight";
                                };
                                Children = {};
                            };
                        };
                    };
                };
            };
            {
                ID = 42;
                Type = "StringValue";
                Properties = {
                    Name = "run";
                };
                Children = {
                    {
                        ID = 43;
                        Type = "Animation";
                        Properties = {
                            Name = "RunAnim";
                            AnimationId = "rbxassetid://3489173414";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 44;
                Type = "StringValue";
                Properties = {
                    Name = "sit";
                };
                Children = {
                    {
                        ID = 45;
                        Type = "Animation";
                        Properties = {
                            Name = "SitAnim";
                            AnimationId = "http://www.roblox.com/asset/?id=2506281703";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 46;
                Type = "StringValue";
                Properties = {
                    Name = "swim";
                };
                Children = {
                    {
                        ID = 47;
                        Type = "Animation";
                        Properties = {
                            Name = "Swim";
                            AnimationId = "http://www.roblox.com/asset/?id=616165109";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 48;
                Type = "StringValue";
                Properties = {
                    Name = "swimidle";
                };
                Children = {
                    {
                        ID = 49;
                        Type = "Animation";
                        Properties = {
                            Name = "SwimIdle";
                            AnimationId = "http://www.roblox.com/asset/?id=616166655";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 50;
                Type = "StringValue";
                Properties = {
                    Name = "toollunge";
                };
                Children = {
                    {
                        ID = 51;
                        Type = "Animation";
                        Properties = {
                            Name = "ToolLungeAnim";
                            AnimationId = "http://www.roblox.com/asset/?id=522638767";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 52;
                Type = "StringValue";
                Properties = {
                    Name = "toolnone";
                };
                Children = {
                    {
                        ID = 53;
                        Type = "Animation";
                        Properties = {
                            Name = "ToolNoneAnim";
                            AnimationId = "http://www.roblox.com/asset/?id=507768375";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 54;
                Type = "StringValue";
                Properties = {
                    Name = "toolslash";
                };
                Children = {
                    {
                        ID = 55;
                        Type = "Animation";
                        Properties = {
                            Name = "ToolSlashAnim";
                            AnimationId = "http://www.roblox.com/asset/?id=522635514";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 56;
                Type = "StringValue";
                Properties = {
                    Name = "walk";
                };
                Children = {
                    {
                        ID = 57;
                        Type = "Animation";
                        Properties = {
                            Name = "WalkAnim";
                            AnimationId = "rbxassetid://3489174223";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 58;
                Type = "StringValue";
                Properties = {
                    Name = "wave";
                };
                Children = {
                    {
                        ID = 59;
                        Type = "Animation";
                        Properties = {
                            Name = "WaveAnim";
                            AnimationId = "http://www.roblox.com/asset/?id=507770239";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 60;
                Type = "BindableFunction";
                Properties = {
                    Name = "PlayEmote";
                };
                Children = {};
            };
            {
                ID = 61;
                Type = "NumberValue";
                Properties = {
                    Name = "ScaleDampeningPercent";
                    Value = 0.4000000059604645;
                };
                Children = {};
            };
            {
                ID = 62;
                Type = "Folder";
                Properties = {
                    Name = "DeathAnimations";
                };
                Children = {
                    {
                        ID = 63;
                        Type = "Animation";
                        Properties = {
                            Name = "DeathAnimation";
                            AnimationId = "rbxassetid://3716468774";
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 64;
                Type = "Folder";
                Properties = {
                    Name = "InitialPoses";
                };
                Children = {
                    {
                        ID = 65;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LowerTorso_Initial";
                            Value = CFrame.new(0,2.944424704054427e-10,0,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 66;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LowerTorso_Original";
                            Value = CFrame.new(0,2.944424704054427e-10,0,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 67;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LowerTorso_Composited";
                            Value = CFrame.new(3.605880732574916e-26,2.944424981610183e-10,3.605880732574916e-26,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 68;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "UpperTorso_Initial";
                            Value = CFrame.new(-6.617444900424222e-24,0.4884321391582489,-6.617444900424222e-24,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 69;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "UpperTorso_Original";
                            Value = CFrame.new(-6.617444900424222e-24,0.4884321391582489,-6.617444900424222e-24,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 70;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "UpperTorso_Composited";
                            Value = CFrame.new(5.981568664242048e-17,0.4884321689605713,5.981568664242048e-17,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 71;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "Head_Initial";
                            Value = CFrame.new(-7.422014558500223e-09,1.5409104824066162,0.15732645988464355,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 72;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "Head_Original";
                            Value = CFrame.new(-7.422014558500223e-09,1.5409104824066162,0.15732645988464355,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 73;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "Head_Composited";
                            Value = CFrame.new(-7.422014558500223e-09,2.0293428897857666,0.15732647478580475,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 74;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftUpperArm_Initial";
                            Value = CFrame.new(-0.6196257472038269,1.164784550666809,0.1896892637014389,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 75;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftUpperArm_Original";
                            Value = CFrame.new(-0.6196257472038269,1.164784550666809,0.1896892637014389,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 76;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftUpperArm_Composited";
                            Value = CFrame.new(-0.6196258068084717,1.65321683883667,0.1896892786026001,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 77;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftLowerArm_Initial";
                            Value = CFrame.new(-0.2750164866447449,-0.9594759941101074,0.1014149934053421,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 78;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftLowerArm_Original";
                            Value = CFrame.new(-0.2750164866447449,-0.9594759941101074,0.1014149934053421,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 79;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftLowerArm_Composited";
                            Value = CFrame.new(-0.8946422934532166,0.6937407851219177,0.2911042869091034,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 80;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftHand_Initial";
                            Value = CFrame.new(-0.2359095811843872,-0.7964189052581787,-0.308481365442276,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 81;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftHand_Original";
                            Value = CFrame.new(-0.2359095811843872,-0.7964189052581787,-0.308481365442276,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 82;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftHand_Composited";
                            Value = CFrame.new(-1.1305519342422485,-0.10267817974090576,-0.017377115786075592,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 83;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightUpperArm_Initial";
                            Value = CFrame.new(0.6227420568466187,0.9390811920166016,0.21503755450248718,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 84;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightUpperArm_Original";
                            Value = CFrame.new(0.6227420568466187,0.9390811920166016,0.21503755450248718,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 85;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightUpperArm_Composited";
                            Value = CFrame.new(0.6227421164512634,1.4275134801864624,0.21503756940364838,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 86;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightLowerArm_Initial";
                            Value = CFrame.new(0.28062528371810913,-0.9831222295761108,0.06748774647712708,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 87;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightLowerArm_Original";
                            Value = CFrame.new(0.28062528371810913,-0.9831222295761108,0.06748774647712708,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 88;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightLowerArm_Composited";
                            Value = CFrame.new(0.9033674001693726,0.4443911612033844,0.28252533078193665,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 89;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightHand_Initial";
                            Value = CFrame.new(0.2476080060005188,-0.8074023723602295,-0.26733940839767456,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 90;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightHand_Original";
                            Value = CFrame.new(0.2476080060005188,-0.8074023723602295,-0.26733940839767456,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 91;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightHand_Composited";
                            Value = CFrame.new(1.1509754657745361,-0.3630112409591675,0.015185898169875145,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 92;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftUpperLeg_Initial";
                            Value = CFrame.new(-0.32454171776771545,-0.16386236250400543,0,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 93;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftUpperLeg_Original";
                            Value = CFrame.new(-0.32454171776771545,-0.16386236250400543,0,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 94;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftUpperLeg_Composited";
                            Value = CFrame.new(-0.32454174757003784,-0.16386237740516663,-2.0067353684060923e-17,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 95;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftLowerLeg_Initial";
                            Value = CFrame.new(-0.10675880312919617,-1.274451732635498,-0.041036609560251236,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 96;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftLowerLeg_Original";
                            Value = CFrame.new(-0.10675880312919617,-1.274451732635498,-0.041036609560251236,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 97;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftLowerLeg_Composited";
                            Value = CFrame.new(-0.431300550699234,-1.4383141994476318,-0.041036613285541534,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 98;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftFoot_Initial";
                            Value = CFrame.new(-0.1600961685180664,-1.3999582529067993,0.04986901581287384,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 99;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftFoot_Original";
                            Value = CFrame.new(-0.1600961685180664,-1.3999582529067993,0.04986901581287384,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 100;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "LeftFoot_Composited";
                            Value = CFrame.new(-0.5913967490196228,-2.8382725715637207,0.008832408115267754,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 101;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightUpperLeg_Initial";
                            Value = CFrame.new(0.32454171776771545,-0.16386236250400543,0,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 102;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightUpperLeg_Original";
                            Value = CFrame.new(0.32454171776771545,-0.16386236250400543,0,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 103;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightUpperLeg_Composited";
                            Value = CFrame.new(0.32454174757003784,-0.16386237740516663,-2.0067353684060923e-17,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 104;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightLowerLeg_Initial";
                            Value = CFrame.new(0.11172434687614441,-1.2744511365890503,-0.041036609560251236,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 105;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightLowerLeg_Original";
                            Value = CFrame.new(0.11172434687614441,-1.2744511365890503,-0.041036609560251236,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 106;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightLowerLeg_Composited";
                            Value = CFrame.new(0.43626609444618225,-1.438313603401184,-0.041036613285541534,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 107;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightFoot_Initial";
                            Value = CFrame.new(0.09266763925552368,-1.5901298522949219,0.05431872978806496,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 108;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightFoot_Original";
                            Value = CFrame.new(0.09266763925552368,-1.5901298522949219,0.05431872978806496,1,0,0,0,1,0,0,0,1);
                        };
                        Children = {};
                    };
                    {
                        ID = 109;
                        Type = "CFrameValue";
                        Properties = {
                            Name = "RightFoot_Composited";
                            Value = CFrame.new(0.5289337635040283,-3.0284435749053955,0.01328212209045887,1,1.2246468525851679e-16,-1.499759904157988e-32,-1.2246468525851679e-16,1,-1.2246468525851679e-16,0,1.2246468525851679e-16,1);
                        };
                        Children = {};
                    };
                };
            };
            {
                ID = 110;
                Type = "Folder";
                Properties = {
                    Name = "AttackAnimations";
                };
                Children = {
                    {
                        ID = 111;
                        Type = "Animation";
                        Properties = {
                            Name = "AttackAnimation2";
                            AnimationId = "rbxassetid://10724946029";
                        };
                        Children = {};
                    };
                    {
                        ID = 112;
                        Type = "Animation";
                        Properties = {
                            Name = "AttackAnimation3";
                            AnimationId = "rbxassetid://9991697436";
                        };
                        Children = {};
                    };
                    {
                        ID = 113;
                        Type = "Animation";
                        Properties = {
                            Name = "AttackAnimation1";
                            AnimationId = "rbxassetid://10149103707";
                        };
                        Children = {};
                    };
                };
            };
        };
    };
    
    local function Scan(item, parent)
        local obj = Instance.new(item.Type)
        if (item.ID) then
            local awaiting = awaitRef[item.ID]
            if (awaiting) then
                awaiting[1][awaiting[2]] = obj
                awaitRef[item.ID] = nil
            else
                partsWithId[item.ID] = obj
            end
        end
        for p,v in pairs(item.Properties) do
            if (type(v) == "string") then
                local id = tonumber(v:match("^_R:(%w+)_$"))
                if (id) then
                    if (partsWithId[id]) then
                        v = partsWithId[id]
                    else
                        awaitRef[id] = {obj, p}
                        v = nil
                    end
                end
            end
            obj[p] = v
        end
        for _,c in pairs(item.Children) do
            Scan(c, obj)
        end
        obj.Parent = parent
        return obj
    end
    
     Scan(root, Parent) 
end


return GoblinAnimationsModule