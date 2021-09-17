close all;
myColors;
addpath('D:\Program\SwarmSim-master\fcts');

%% Extract position and velocity from demos

demoNum=5;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   % number of demos
demo_dt=0.01;                 % time interval of data
demoLen=700; % size of each demo;
demo_dura=demoLen*demo_dt;    % time length of each demo
dim=1;                        % dimension of demo
Data = dataprocess();
%% Extract the reference trajectory
model.nbStates = 8;   % Number of states in the GMM
model.nbVar =1+2*dim; % Number of variables [t,x1,x2,.. vx1,vx2...]
model.dt = 0.01;     % Time step duration
% nbData = demo_dura/model.dt; % Length of each trajectory
nbData = 700;
model = init_GMM_timeBased(Data, model);
[model,gamma2,~] = EM_GMM(Data, model);
[DataOut, SigmaOut,H] = GMR(model, [1:nbData]*model.dt, 1, 2:model.nbVar); %see Eq. (17)-(19)

information = load('information.mat');
p = information.p;
figure
% set(gca,'xtick',[0 5 10 15])
% set(gca,'ytick',[0 5 10 15])
xlim([0, 15]);
ylim([0, 15]);
hold on
plot(1,15,'.','markersize',1,'color','k')
hold on
for i = 1:150
    for j = 1:150
        if(p(i,j) == 1)
            x = j/10.0;
            y = 15.0- i/10.0; 
            plot(x,y,'.','markersize',20,'color','k')
            hold on
        end
    end
end
%% show reference trajectory
plotGMM(DataOut(1:2,:), SigmaOut(1:2,1:2,:), mycolors.g, .025);
hold on
plot(DataOut(1,:),DataOut(2,:),'color',mycolors.g,'linewidth',3.0);
hold on
for i=1:5        
    first = 1+ (i-1) *700;
    last = i* 700;
    plot(Data(2, first:last),Data(3,first:last),'--') ;
    hold on
end

