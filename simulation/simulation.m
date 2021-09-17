classdef simulation
    %SIMULATION Abstract class for a simulation
    
    properties
        sampleTime
        numRobots
        world
        physics
        controllers
        actuators
        prev_poses
        hPlot
        follower_wps
    end
    
    methods (Abstract)
        control_phase(obj)
        control_agent(obj)
        step(obj)
    end
    
    methods
        function readings = sensor_phase(obj)
            readings = obj.world.readSensors();
        end
        
        function obj = physics_phase(obj,poses)
            poses = obj.physics.check_obstacles(poses,obj.prev_poses);
            %poses = obj.physics.check_robots(poses,obj.prev_poses);
            obj.world = obj.world.update_poses(poses);
            obj.prev_poses = poses;
        end
        
        function poses = actuate_phase_(obj,controls)  %¸üÐÂ×´Ì¬
            poses = obj.world.get_poses(); % current system states
            for i = 1:obj.numRobots
                if(i==obj.numRobots)
                    poses(1,i)  = poses(1,i) + controls{i}.vRef;
                    poses(2,i)  = poses(2,i) + controls{i}.wRef;
                end
                if(i ~= obj.numRobots)
                    actuator = obj.actuators{i};
                    pose = poses(:,i);
                    control = controls{i};
                    vel = actuator.actuate(control,pose);
                    poses(:,i) = pose  + vel * obj.sampleTime;
                end
            end
        end
        

          
        
        function visualize_(obj)
            readings = obj.world.readSensors();
            obj.world.visualize(readings);
        end
        
        
        function visualize_agent(obj,goal)
            readings = obj.world.readSensors();
%             obj.world.visualize(readings);
            obj.world.visualize_goal(readings,goal);
        end
        
        
    end
    
end

