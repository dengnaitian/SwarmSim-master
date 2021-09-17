classdef LeaderFollowerSimulation < simulation
    %LEADERFOLLOWERSIMULATION 
    % A Leader-Follower formation control simulation
    
    properties
        form
        numFollowers
    end
    
    methods
        function obj = LeaderFollowerSimulation(map,swarmInfo,form,waypoints)
            %LEADERFOLLOWER SIMULATION 
            obj.sampleTime = 0.05;
            obj.numRobots = swarmInfo.numRobots;
            obj.numFollowers = obj.numRobots - 1;
            obj.world = world(swarmInfo);
            obj.controllers = cell(1,obj.numRobots);
            obj.follower_wps = waypoints;
            % assign controller for the leader(PRM waypoints)
            leader_goal = [12 12];
            leader_pose = swarmInfo.poses(:,1);
            leader_wps = planPRM(map,leader_pose,leader_goal);  % return [[x1,y1]',[x2,y2]',...[xn,yn]']  
            obj.controllers{1} = DiffDrivePursueWayPoints(leader_wps); %return Pure pursue controller  leader �Ŀ�����
            % assign controller for the followers
            obj.form = form;%LineFormation();
            %type="dphi"; params.d = 1; params.phi = 0;  
            %d-phi�����˾���ͽǶ� ����d=1 phi=0
            for i = 2:obj.numRobots
                type = obj.form.getType(i);
                %leadIdx = form.getIdx(i);
                params = obj.form.getParam(i);
                obj.controllers{i} = DiffDriveFollower(type,params);  %��ʱcontrollers �洢���ǿ��������࣬��������ֵ
            end
            % assign actuators
            for i = 1:obj.numRobots
                robotInfo = swarmInfo.infos{i};
                R = robotInfo.wheel_radius;
                L = robotInfo.body_width;
                if (robotInfo.type == "DiffDrive")
                    obj.actuators{i} = actuatorDiffDrive(R,L); %��������������ϵ��λ����Ϣ���ٶ���Ϣ��
                end
            end
            % setup environment physics
            obj.physics = AABB(map,swarmInfo.numRobots,0.25,true);
            obj.prev_poses = swarmInfo.poses;
        end
        
        function obj = step(obj)
            readings = obj.sensor_phase();
            controls = obj.control_phase(readings);
            poses = obj.actuate_phase_(controls);  %����poses
            obj = obj.physics_phase(poses);
            obj.visualize_();
        end

        function controls = control_phase(obj,readings,index)
            % get current poses of all robots
            poses = obj.world.get_poses();
%             poses
            controls = cell(1,obj.numRobots);
            % control the leader ����leader��controls
            ctl = obj.controllers{1};  %��ʾcontrol����Ϣ
            pose = poses(:,1);
            controls{1} = ctl.compute_control(pose,readings); %������ķ���������ĺ�����DiffDriverPursueWayPoints��
            % pp for follower
            follower_waypoints = obj.follower_wps;
            pp =  DiffDrivePursueWayPoints(follower_waypoints);
        
            % control the followers
            for i = 2:obj.numRobots
                ctl = obj.controllers{i};
                type = obj.form.getType(i);
                leadIdx = obj.form.getIdx(i);
                pose = poses(:,i);  %�Լ���pose
                % �����µ�pure Pursue
                ppcontrol = pp.compute_control(pose,readings);
                if (strcmp(type,"dphi"))
                    lead = poses(:,leadIdx);   %ÿ��follower ����leader ����һ���� leader��pose
                    controls{i} = ctl.compute_control(pose,lead,[0;0;0]);  %pose ���Լ���pose
%                     if i==2 || i==3 
%                         controls{i}.vRef = 0.8 * controls{i}.vRef + 0.2*ppcontrol.vRef;
%                         controls{i}.wRef = 0.8 * controls{i}.wRef + 0.2*ppcontrol.wRef;
%                     end
                    if(index > 200 && index<500 )
                        controls{i}.vRef =  0.6;
                        controls{i}.wRef =  ppcontrol.wRef;
                    end

                elseif (strcmp(type,"dd"))
                    lead1 = poses(:,leadIdx(1));
                    lead2 = poses(:,leadIdx(2));
                    controls{i} = ctl.compute_control(pose,lead1,lead2);
                end
            end
        end
        
    end
end

