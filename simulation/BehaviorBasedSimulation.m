classdef BehaviorBasedSimulation < simulation
    %BEHAVIORBASEDSIMULATION 
    % A simulation for robots navigation using behavior-based method
    
    properties
    end
    
    methods
        function obj = BehaviorBasedSimulation(map,swarmInfo)
            %BEHAVIORBASEDSIMULATION 
            % construct the simulation
            obj.sampleTime = 0.005;
            obj.numRobots = swarmInfo.numRobots;
            obj.world = world(swarmInfo);
            obj.controllers = cell(1,obj.numRobots);
            % assign controller to each robot
%             goal = [12 12];
            goal = [14 14];
            robotInfos = swarmInfo.infos;
            for i = 1:obj.numRobots
                robotInfo = robotInfos{i};
                obj.controllers{i} = DiffDriveBehaviorBasedBlend(robotInfo,goal);
            end
            % assign actuator to each robot
            obj.actuators = cell(1,obj.numRobots);
            for i = 1:obj.numRobots
                robotInfo = swarmInfo.infos{i};
                R = robotInfo.wheel_radius;
                L = robotInfo.body_width;
                if (robotInfo.type == "DiffDrive")
                    obj.actuators{i} = actuatorDiffDrive(R,L);
                end
            end
            % setup environment physics
            obj.physics = AABB(map,swarmInfo.numRobots,0.25,true);
            obj.prev_poses = swarmInfo.poses;
        end

            
        function obj = step(obj)
            readings = obj.sensor_phase();
            controls = obj.control_phase(readings);
            pose = obj.world.get_poses();
            a_pose  = pose(1:2,1);
            time_to_gaol_1 = sqrt((a_pose(1)-7)^2 + (a_pose(2)-7)^2) / controls{1}.vRef;
            for i = 2 :obj.numRobots
                a_pose = pose(1:2,i);
                dist = sqrt((a_pose(1)-7)^2 + (a_pose(2)-7)^2);
                v = dist / time_to_gaol_1;
                controls{i}.vRef = v ; 
            end
            poses = obj.actuate_phase_(controls);
            obj = obj.physics_phase(poses);
            obj.visualize_();
        end
        
         function controls = control_phase(obj,readings)
            poses = obj.world.get_poses(); % current system states
            controls = cell(1,obj.numRobots);
            for i = 1:obj.numRobots
                ctl = obj.controllers{i};
                pose = poses(:,i);
                reading = readings{i};
                controls{i} = ctl.compute_control(pose,reading);
            end
         end
        
         function controls = control_agent(obj,readings,goal)
            poses = obj.world.get_poses(); % current system states
            controls = cell(1,obj.numRobots);
            for i = 1:obj.numRobots
                ctl = obj.controllers{i};
                pose = poses(:,i);
                reading = readings{i};
                controls{i} = ctl.compute_control_agent(pose,reading,goal);
            end
         end         
    end
end

