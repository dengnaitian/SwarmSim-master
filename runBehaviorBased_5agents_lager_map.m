%% a test script for simulator class
clear all;
close all;
% generate map for the simulation
size = 100;
resolution = 10;
numObstacles = 0;
space = 5;
A = [[0,1,1,0],
     [1,0,0,1],
     [1,0,0,0],
     [0,1,0,0]];
% A = A*0.5;
B = [1,0,0,0];
% B = B * 0.5;
b = zeros(4);
b(1,1) = 1;
D = diag(sum(A,2));
L = D - A ;
M = L + b;
[m_eig_vector,m_eig] = eig(M);
[eig_value,ind] = sort(diag(m_eig));
%p = zeros(size*resolution);
map_gen = MapGenerate(size,size,space,resolution);
[p,map_gen] = map_gen.addBounds(2);
for i = 1:numObstacles
    %p = add_random_circle(p);
    [p,map_gen] = map_gen.addRandomObstacle(1.0,0.5);
end
map = binaryOccupancyMap(p,resolution);

%% specify some parameters
numRobots = 6;
numSensors = 25;
sensorRange = 2;
showTraj = false;
% initial_poses = 8*(rand(3,numRobots).*[0.5;0.5;0]) + [0.5;0.5;0];

initial_poses = [[1,1,0];[3,1,0];[24,1,0];[22,22,0];[1,24,0];[18,12,0]]';
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
iterator = 1200;
rec_traj = zeros(iterator,10);
rec_dist = zeros(iterator,5);
rec_speed = zeros(iterator,5);
costValue = zeros(iterator+1,1);
for i = 1:iterator
    readings = sim.sensor_phase();
    controls = sim.control_agent(readings,[goal_x  goal_y]);
    pycontrol.control3();
    pycontrol.update();
    controls{1}.wRef = pycontrol.wRef;
    controls{1}.vRef = pycontrol.vRef;
    pose = sim.world.get_poses();
    %goal points
    goal_x = pose(1,6);
    goal_y = pose(2,6);
    goal_pose = [goal_x;goal_y];
    %calculate distance to goal
    distance_to_goal = pose(1:2,1:5) - [goal_x;goal_y];
    distance_to_goal = sqrt(distance_to_goal(1,:).^2 + distance_to_goal(2,:).^2 );
    % calculate velocity
    distance = pose - last_pose;
    distance = sqrt(distance(1,:).^2 + distance(2,:).^2 );
    vel =  distance/0.005;
%     vel = sqrt(diff_posedp[i] = LTS + 1;(1,:).^2 + diff_pose(2,:).^2 );
    vel(1);
    velocity = one_order_control(pose(:,1:5),goal_pose,vel(1),4,A,B,eig_value(1));
    for j =2:5
        velocity_input = min(10,velocity(j-1));
        controls{j}.vRef = velocity_input;
    end
    controls{6}.wRef = pycontrol.target_wRef;
    controls{6}.vRef = pycontrol.target_vRef;
    last_pose = pose;   
    pose = sim.actuate_phase_(controls);
    i
    sim = sim.physics_phase(pose);
    sim.visualize_agent([goal_x goal_y]);    
    axis([0 size 0 size])
%     pause(0.00002);  
    rec_traj(i,1:5) = pose(1,1:5);
    rec_traj(i,6:10) = pose(2,1:5);
    rec_dist(i,:) = distance_to_goal;
    rec_speed(i,:) = vel(1,1:5);
    costValue(i,:) = costFunction(A,B,pose,goal_pose,numRobots-2,10,1);
end
costValue(iterator+1,:) = costFunction(A,B,pose,goal_pose,numRobots-2,10,0);
py.pygame.quit()