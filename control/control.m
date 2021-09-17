classdef (Abstract)control
    %CONTROLLER Abstract class of robot controllers
    
    properties
        control_bnd
    end
    
    methods (Abstract)
        compute_control(obj,pose,readings)
        compute_control_agent(obj,pose,readings,goal)
        
    end
end

