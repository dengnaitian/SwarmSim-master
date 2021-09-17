%% a test script for simulator class
clear all;
close all;
% generate map for the simulation
size = 100;
resolution = 10;
numObstacles = 0;
space = 5;
% A = [   [0,1,0,0,0,0,0,0,0,1],
%         [1,0,1,0,0,0,0,0,0,0],
%         [0,1,0,1,0,0,0,0,0,0],
%         [0,0,1,0,1,0,0,0,0,0],
%         [0,0,0,1,0,1,0,0,0,0],
%         [0,0,0,0,1,0,1,0,0,0],
%         [0,0,0,0,0,1,0,1,0,0],
%         [0,0,0,0,0,0,1,0,1,0],
%         [0,0,0,0,0,0,0,1,0,1],
%         [1,0,0,0,0,0,0,0,1,0]];
%% agent =10 small map
% A = [   [0,1,1,0,0,0,0,0,0,0],
%         [1,0,1,0,0,0,0,0,0,0],
%         [1,1,0,1,0,0,0,0,0,0],
%         [0,0,1,0,1,1,0,0,0,0],
%         [0,0,0,1,0,1,0,0,0,0],
%         [0,0,0,1,1,0,1,0,0,0],
%         [0,0,0,0,0,1,0,1,1,1],
%         [0,0,0,0,0,0,1,0,1,1],
%         [0,0,0,0,0,0,1,1,0,1],
%         [0,0,0,0,0,0,1,1,1,0]];   
%     
% % A = A*0.5;
% B = [1,0,0,0,0,0,0,0,0,0];
% % B = B * 0.5;
% b = zeros(10);
% b(1,1) = 1;
% b(5,5) = 0;
% b(10,10) = 0;
%% agent 10 lager map
% A = [   [0,1,0,0,0,0,0,0,0,0],
%         [1,0,1,0,0,0,0,0,0,0],
%         [0,1,0,1,1,0,0,0,0,0],
%         [0,0,1,0,1,0,0,0,0,0],
%         [0,0,1,1,0,0,0,0,0,0],
%         [0,0,0,0,0,0,1,0,0,0],
%         [0,0,0,0,0,1,0,1,0,0],
%         [0,0,0,0,0,0,1,0,1,1],
%         [0,0,0,0,0,0,0,1,0,1],
%         [0,0,0,0,0,0,0,1,1,0]];   
%     
% % A = A*0.5;
% B = [1,0,0,0,0,1,0,0,0,0];
% % B = B * 0.5;
% b = zeros(10);
% b(1,1) = 1;
% b(6,6) = 1;
% b(10,10) = 0;
%% agent 10
A = [   [0,1,1,0,0,0,0,0,0,0],
        [1,0,1,0,0,0,0,0,0,0],
        [1,1,0,1,0,0,0,0,0,0],
        [0,0,1,0,1,0,0,0,0,0],
        [0,0,0,1,0,0,0,0,0,0],
        [0,0,0,0,0,0,1,0,0,0],
        [0,0,0,0,0,1,0,1,1,1],
        [0,0,0,0,0,0,1,0,1,1],
        [0,0,0,0,0,0,1,1,0,1],
        [0,0,0,0,0,0,1,1,1,0]];   
    
% A = A*0.5;
B = [0,0,0,0,0,0,0,0,0,0];
% B = B * 0.5;
b = zeros(10);
b(1,1) = 0;
b(6,6) = 0;
b(10,10) = 0;
%% agent 10 lager map
D = diag(sum(A,2));
L = D - A ;
M = L + b;
[m_eig_vector,m_eig] = eig(M);
[eig_value,ind] = sort(diag(m_eig));
% 2021.7.21 
A = A * 1;
B = B * 1;

%p = zeros(size*resolution);
map_gen = MapGenerate(size,size,space,resolution);
[p,map_gen] = map_gen.addBounds(2);
for i = 1:numObstacles
    %p = add_random_circle(p);
    [p,map_gen] = map_gen.addRandomObstacle(1.0,0.5);
end
map = binaryOccupancyMap(p,resolution);

%% specify some parameters
numRobots = 12;
numSensors = 25;
sensorRange = 2;
showTraj = false;
% initial_poses = 8*(rand(3,numRobots).*[0.5;0.5;0]) + [0.5;0.5;0];
%map_size = 25
% initial_poses = [[1,1,0];[8,1,1.2];[16,1,1.8];[24,1,2.3];[24,8,2.5];[24,16,-2.6];[24,24,-2.3];[12,24,-1.5];[1,24,-0.8];[1,16,-0.3];[1,8,0.3];[12,12,0]]';
%map_size = 100
initial_poses = [[20,20,0];[20,15,1];[30,15,1];[40,15,1];[50,15,1];[60,15,1];[15,20,0];[15,30,0];[15,40,0];[15,50,0];[15,60,0];[50,50,0]]';

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
goal_x = last_pose(1,12);
goal_y = last_pose(2,12);
goal_pose = [goal_x;goal_y];
iterator = 300;
rec_traj = zeros(iterator,22);
rec_dist = zeros(iterator,11);
rec_speed = zeros(iterator,11);
costValue = zeros(iterator+1,1);
for i = 1:iterator
        

%     B = [1,0,0,0,0,1,0,0,0,0];
    B =  binornd(1,[0.7,0,0,0,0,0.7,0,0,0,0.7]);
    b = zeros(10);
    for i = 1:10
        b(i,i) = B(i);
        b(i,i) = B(i);
        b(i,i)= B(i);  
    end

    %% agent 10 lager map
    D = diag(sum(A,2));
    L = D - A;
    M = L + b;
    [m_eig_vector,m_eig] = eig(M);
    [eig_value,ind] = sort(diag(m_eig));
    % 2021.7.21 
    A = A * 1;
    B = B * 1;
    
    
    
    readings = sim.sensor_phase();
    controls = sim.control_agent(readings,[goal_x  goal_y]);
    pycontrol.control3();
    pycontrol.update();
    controls{1}.wRef = pycontrol.wRef;
    controls{1}.vRef = pycontrol.vRef;
    pose = sim.world.get_poses();
    goal_x = pose(1,12);
    goal_y = pose(2,12);
    goal_pose = [goal_x;goal_y];
    %calculate distance to goal
    distance_to_goal = pose(1:2,1:11) - [goal_x;goal_y];
    distance_to_goal = sqrt(distance_to_goal(1,:).^2 + distance_to_goal(2,:).^2 );
    % calculate velocity
    distance = pose - last_pose;
    distance = sqrt(distance(1,:).^2 + distance(2,:).^2 );
    vel =  distance/0.005;
    vel(1);
    i
    velocity = one_order_control(pose(:,1:11),goal_pose,vel(1),10,A,B,eig_value(3));
    for j =2:11
        velocity_input = min(10,velocity(j-1));
        controls{j}.vRef = velocity_input;
    end
    controls{12}.wRef = pycontrol.target_wRef;
    controls{12}.vRef = pycontrol.target_vRef;
    last_pose = pose;   
    pose = sim.actuate_phase_(controls);
    sim = sim.physics_phase(pose);
    if( mod(i,2)==0)
        sim.visualize_agent([goal_x goal_y]);    
%         axis([0 25 0 25])
        axis([0 size 0 size])
    end
%     pause(0.00002);  
    rec_traj(i,1:11) = pose(1,1:11);
    rec_traj(i,12:22) = pose(2,1:11);
    rec_dist(i,:) = distance_to_goal;
    rec_speed(i,:) = vel(1,1:11);
    %º∆À„costFuncetion
    costValue(i,:) = costFunction(A,B,pose,goal_pose,numRobots-2,10,1);
end
costValue(iterator+1,:) = costFunction(A,B,pose,goal_pose,numRobots-2,10,0);
py.pygame.quit()