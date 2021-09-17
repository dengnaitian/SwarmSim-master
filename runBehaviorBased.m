%% a test script for simulator class
clear all;
close all;
% generate map for the simulation
size = 15;
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
numRobots = 4;
numSensors = 25;
sensorRange = 2;
showTraj = false;
% initial_poses = 8*(rand(3,numRobots).*[0.5;0.5;0]) + [0.5;0.5;0];

initial_poses = [[1,1,0];[14,1,0];[11,11,0];[1,14,0]]';
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
data_demo = zeros(8,230)
for i = 1:250
%     sim = sim.step();
    readings = sim.sensor_phase();
    controls = sim.control_phase(readings);
    pycontrol.control3();
    pycontrol.update();
    controls{1}.wRef = pycontrol.wRef;
    controls{1}.vRef = pycontrol.vRef;    
    pose = sim.world.get_poses();   
    diff_pose =  (pose - last_pose)/0.05;
    vel = sqrt(diff_pose(1,:).^2 + diff_pose(2,:).^2 );
    a_pose  = pose(1:2,1);
    dist = sqrt((a_pose(1)-7)^2 + (a_pose(2)-7)^2);
    time_to_gaol_1 = dist /vel(1);
    data_demo(1,i) = vel(1);
    data_demo(2,i) = dist;
    data_record{1}(:,i) = [time_to_gaol_1,dist,controls{1}.vRef];
    for j = 2 :sim.numRobots
        a_pose = pose(1:2,j);
        dist = sqrt((a_pose(1)-7)^2 + (a_pose(2)-7)^2);
        v = dist / time_to_gaol_1;
        t = dist / vel(j);
        controls{j}.vRef = v ; 
        data_record{j}(:,i) = [t,dist,v];
        data_demo(j+1,i) = dist;
        data_demo(j+4,i) = v;
    end 
    poses = sim.actuate_phase_(controls);
    last_pose = pose;
    sim = sim.physics_phase(poses);
    sim.visualize_();    
    axis([0 15 0 15])
    pause(0.02);
end
py.pygame.quit()