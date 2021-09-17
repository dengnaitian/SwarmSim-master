%% a test script for simulator class
clear all;
close all;

%% kmp
% 
addpath('D:\Program\SwarmSim-master\fcts');
addpath('D:\Program\SwarmSim-master\demos');
% %% Extract position and velocity from demos
myColors;


%% generate map for the simulation
size = 15;
resolution = 10;
numObstacles = 0;
space = 5;
p = zeros(size*resolution);
map_gen = MapGenerate(size,size,space,resolution);
[p,map_gen] = map_gen.addBounds(2);
for i = 1:numObstacles
    [p,map_gen] = map_gen.addRandomObstacle(1.5,0.5);
end
information = load('matlab.mat');
% p = information.information.p;
map = binaryOccupancyMap(p,resolution);

%% specify some parameters
% form = VShapeFormation();%DiamondFormation(); 
form = LineFormation();
numRobots = form.numRobots;
numSensors = 5;
sensorRange = 2.5;
showTraj = false;
initial_poses = 8*(rand(3,numRobots).*[0.5;0.5;0]) + [0.5;0.5;0];
% initial_poses = information.information.initial_poses;
robotInfos = cell(1,numRobots);
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
%% leader-follower simulation
gmr = load('gmr_result.mat');
SigmaOut = load('gmr_sigma.mat');
DataOut = gmr.DataOut;
follower_waypoints = DataOut';
sim = LeaderFollowerSimulation(map,swarmInfo,form,follower_waypoints);   %选择编队的模型
pycontrol = py.myfun.Control;
for i = 1:700
%     sim = sim.step();
    readings = sim.sensor_phase();  %read lidar data
    pose = sim.world.get_poses();
    leaderTraj(:,i)   = pose(1:2,1);
    followeTraj2(:,i) = pose(1:2,2);
    followeTraj3(:,i) = pose(1:2,3);
    followeTraj4(:,i) = pose(1:2,4);
    followeTraj5(:,i) = pose(1:2,5);
    controls = sim.control_phase(readings,i);  %follower 直接是打满方向盘
    pycontrol.control3();
    pycontrol.update();
    controls{1}.wRef = pycontrol.wRef;
    controls{1}.vRef = pycontrol.vRef;
    
%     controls{1}.vRef
%     controls{1}.wRef
    poses = sim.actuate_phase_(controls);
    sim = sim.physics_phase(poses);  %updata the poses 
    sim.visualize_();
    
    axis([0 size 0 size])
    pause(0);
end
hold on 
py.pygame.quit()
plot(leaderTraj(1,:),leaderTraj(2,:))
hold on
plot(followeTraj2(1,:),followeTraj2(2,:))
hold on
plot(followeTraj3(1,:),followeTraj3(2,:))
hold on
plot(followeTraj4(1,:),followeTraj4(2,:))
hold on
plot(followeTraj5(1,:),followeTraj5(2,:))
plot(DataOut(1,:),DataOut(2,:),'color',mycolors.g,'linewidth',3.0);
hold on 
plotGMM(DataOut(:,:), SigmaOut(1:2,1:2,:), mycolors.g, .025);











