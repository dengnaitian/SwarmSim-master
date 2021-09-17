%% a test script for simulator class
% clear all;
% close all;
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
occupy_map = load('occupy_map_forgpr.mat');
p = occupy_map.p;
map = binaryOccupancyMap(p,resolution);

%% specify some parameters
numRobots = 5;
numSensors = 25;
sensorRange = 2;
showTraj = false;
% initial_poses = 8*(rand(3,numRobots).*[0.5;0.5;0]) + [0.5;0.5;0];
goal_x = 10;
goal_y = 15;
initial_poses = [[1,1,0];[24,1,0];[22,22,0];[1,24,0];[goal_x,goal_y,0]]';
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
my_gpr = py.gpr.gpr;
my_gpr.fit();
% virtual structure simulation
sim = BehaviorBasedSimulation(map,swarmInfo);
pycontrol = py.myfun.Control;
last_pose = sim.world.get_poses();

for i = 1:1000
%     sim = sim.step();
    i
    readings = sim.sensor_phase();
%     controls = sim.control_phase(readings); 
    controls = sim.control_agent(readings,[goal_x  goal_y]);
    % leader controller
    pycontrol.control3();
    pycontrol.update();
    controls{1}.wRef = pycontrol.wRef;
    controls{1}.vRef = pycontrol.vRef;      
    controls{5}.wRef = pycontrol.target_wRef;
    controls{5}.vRef = pycontrol.target_vRef;
    %get pose 
    pose = sim.world.get_poses();    
    goal_x = pose(1,5);
    goal_y = pose(2,5);
    %calculate velocity of agents
    diff_pose =  (pose - last_pose)/0.01;
    vel = sqrt(diff_pose(1,:).^2 + diff_pose(2,:).^2 );
    input_data(1,1) = vel(1);
    %calculate the distance of followers to goal points
    distance_to_goal =  sqrt((pose(1,:)-goal_x).^2 + (pose(2,:) -goal_y).^2);
    input_data(2:5) = distance_to_goal(1:4)';
    velocity = double(my_gpr.prediction(input_data) )
    record_velocity(i,1:4) = vel(1:4);
    record_time(i,:) = distance_to_goal(1:4)./vel(1:4);
    for j = 2 :sim.numRobots -1 
        controls{j}.vRef =  velocity(j-1) ; 
    end
    controls{5}.wRef = pycontrol.target_wRef;
    controls{5}.vRef = pycontrol.target_vRef;
    poses = sim.actuate_phase_(controls);
    last_pose = pose;
    sim = sim.physics_phase(poses);
%     sim.visualize_();    
    if(rem(i,5)==0)
        sim.visualize_agent([goal_x  goal_y]);
        hold on;
        axis([0 25 0 25])
        pause(0.02);
    end
end
py.pygame.quit()
