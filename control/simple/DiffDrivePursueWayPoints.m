classdef DiffDrivePursueWayPoints < control
    %DIFFDRIVEPURSUEWAYPOINTS 
    % pursue way points control for differential drive dynamics
    % using purepursuit controller from robotics system toolbox
    properties
        controller
    end
    
    methods
        function obj = DiffDrivePursueWayPoints(waypoints)
            % waypoints 就是需要跟踪的路径。 
            obj.controller = robotics.PurePursuit;
            obj.controller.Waypoints = waypoints;
            obj.controller.LookaheadDistance = 0.1;
            obj.controller.DesiredLinearVelocity = 0.6;
            obj.controller.MaxAngularVelocity = 1.0;
        end
        
        function control = compute_control(obj,pose,readings)
            % 由于有了waypoints 所以reading 是不重要的
            % 输出速度和角速度即可
            [vRef,wRef] = obj.controller(pose);
            control.vRef = vRef;
            control.wRef = wRef;
        end
    end
end

