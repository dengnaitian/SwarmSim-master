%% a test script for simulator class
clear all;
close all;
% generate map for the simulation
size = 25;
resolution = 10;
numObstacles = 0;
space = 5;
%p = zeros(size*resolution);
map_gen = MapGenerate(size,size,space,resolution);
[p,map_gen] = map_gen.addBounds(2);
for i = 1:numObstacles
    %p = add_random_circle(p);
    [p,map_gen] = map_gen.addRandomObstacle(1.0,0.5);
end
map = binaryOccupancyMap(p,resolution);

%% specify some parameters
numRobots = 10;
numSensors = 25;
sensorRange = 2;
showTraj = false;
% initial_poses = 8*(rand(3,numRobots).*[0.5;0.5;0]) + [0.5;0.5;0];

initial_poses = [[1,1,0];[24,1,0];[22,22,0];[1,24,0];[12,12,0];[3,1,0];[21,1,0];[18,22,0];[1,16,0];[4,4,0]]';
robotInfos = cell(1,numRobots);
data_record = cell(1,numRobots);
for i = 1:numRobots
    t = "DiffDrive"; % differential drive dynamics
    R = 0.1; 
    L = 0.5;
    s = numSensors;
    r = sensorRange;
    show = showTraj;
    robotInfo = RobotInfo(t,R,L,s,r);
    robotInfos{i} = robotInfo;
end
swarmInfo = SwarmInfo(numRobots,robotInfos,initial_poses,false);
%% virtual structure simulation
sim = BehaviorBasedSimulation(map,swarmInfo);
pycontrol = py.myfun.Control;
last_pose = sim.world.get_poses();
data_demo = zeros(8,230);
goal_x = 12;
goal_y = 12;
goal_pose = [goal_x;goal_y];
Neighbor_matrix = eye(10);
for i = 1:805
    if( i<50)
        readings = sim.sensor_phase();
        controls = sim.control_agent(readings,[goal_x  goal_y]);
        pycontrol.control3();
        pycontrol.update();
        controls{1}.wRef = pycontrol.wRef;
        controls{1}.vRef = pycontrol.vRef;
        pose = sim.world.get_poses();
        diff_pose =  (pose - last_pose)/0.05;
        vel = sqrt(diff_pose(1,:).^2 + diff_pose(2,:).^2 )
        a_pose  = pose(1:2,1);
        dist = sqrt((a_pose(1)-goal_x)^2 + (a_pose(2)-goal_y)^2);
        time = dist / vel(1);
        input_data(1,i) = vel(1);
        input_data(2,i) = dist; 
        for j = 2 :sim.numRobots
            a_pose = pose(1:2,j);
            dist = sqrt((a_pose(1)-goal_x)^2 + (a_pose(2)-goal_y)^2);
            velocity = dist/time;
            controls{j}.vRef = velocity;
            input_data(j+1,i) = dist; 
            input_data(j+4,i) = velocity;
        end 
        controls{5}.wRef = pycontrol.target_wRef;
        controls{5}.vRef = pycontrol.target_vRef;
        poses = sim.actuate_phase_(controls);
        last_pose = pose;
        sim = sim.physics_phase(poses);
        sim.visualize_agent([goal_x goal_y]);    
        axis([0 25 0 25])
        pause(0.02);  
    end
    if(i>=50)
        readings = sim.sensor_phase();
        controls = sim.control_agent(readings,[goal_x  goal_y]);
        pycontrol.control3();
        pycontrol.update();
        controls{1}.wRef = pycontrol.wRef;
        controls{1}.vRef = pycontrol.vRef;
        pose = sim.world.get_poses();
        diff_pose =  (pose - last_pose)/0.05;
        vel = sqrt(diff_pose(1,:).^2 + diff_pose(2,:).^2 )
        a_pose  = pose(1:2,1);
        dist = sqrt((a_pose(1)-goal_x)^2 + (a_pose(2)-goal_y)^2);
        time = dist / vel(1);
        input_data(1,i) = vel(1);
        input_data(2,i) = dist; 
        Adjacency_Matrix = neighbor_matrix(pose,10,25);
        leader_matrix = b_matrix(pose,10,100);
        control = updata_velocity(pose,goal_pose,vel,10,Adjacency_Matrix,leader_matrix);
        for j =2:sim.numRobots
            controls{j}.vRef = control(j);
        end
        controls{5}.wRef = pycontrol.target_wRef;
        controls{5}.vRef = pycontrol.target_vRef;

        poses = sim.actuate_phase_(controls);
        last_pose = pose;
        sim = sim.physics_phase(poses);
        sim.visualize_agent([goal_x goal_y]);    
        axis([0 25 0 25])
        pause(0.02);
    end
end

py.pygame.quit()