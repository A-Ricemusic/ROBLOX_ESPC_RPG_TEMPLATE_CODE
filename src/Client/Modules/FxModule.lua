-- Fx Module
-- Username
-- October 4, 2022



local FxModule = {}


function FxModule:Fx(Parent)
    
    local partsWithId = {}
    local awaitRef = {}
    
    local root = {
        ID = 0;
        Type = "Part";
        Properties = {
            Size = Vector3.new(38.26700973510742,6.537660598754883,19.754974365234375);
            Transparency = 0.5;
            Name = "FxSlash";
            CanCollide = false;
            BottomSurface = Enum.SurfaceType.Smooth;
            CFrame = CFrame.new(52.07599639892578,3.268831968307495,-32.41742706298828,1,0,0,0,1,0,0,0,1);
            Position = Vector3.new(52.07599639892578,3.268831968307495,-32.41742706298828);
            TopSurface = Enum.SurfaceType.Smooth;
        };
        Children = {
            {
                ID = 1;
                Type = "SpecialMesh";
                Properties = {
                    VertexColor = Vector3.new(1.5,1.5,1.5);
                    MeshType = Enum.MeshType.FileMesh;
                    Scale = Vector3.new(9.566922187805176,6.537660598754883,9.877487182617188);
                    MeshId = "rbxassetid://6665452633";
                    TextureId = "rbxassetid://8821193347";
                };
                Children = {};
            };
            {
                ID = 2;
                Type = "PointLight";
                Properties = {
                    Range = 12;
                    Name = "light";
                };
                Children = {};
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
    
    



return FxModule