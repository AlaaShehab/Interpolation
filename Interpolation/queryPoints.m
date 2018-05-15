classdef queryPoints < matlab.mixin.SetGet
    properties
        qs = [];         
    end
    
    methods
          function obj = queryPoints(qs)
            obj.qs = qs;
          end
    end
    
end

