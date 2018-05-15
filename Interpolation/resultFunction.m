classdef resultFunction < matlab.mixin.SetGet
    properties
        f;          %function
    end
    
    methods
          function obj = resultFunction(f)
            obj.f = f;
          end
    end
    
end

