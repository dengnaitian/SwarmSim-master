function Data = dataprocess()
str = ["traj3.mat","traj4.mat","traj5.mat","traj6.mat","traj7.mat"];
totalNum=0;
demoNum = 5;
demoLen = 700;
demo_dt = 0.01;
for i=1:demoNum        
    traj = load(str(i));
    demos = traj.leaderTraj;
    for j=1:demoLen
        totalNum=totalNum+1;
        Data(1,totalNum)=j*demo_dt;
        Data(2:3,totalNum)=demos(1:2,j);
    end    
end


% information = load('information.mat');
% p = information.p;
% figure
% set(gca,'xtick',[0 5 10 15])
% set(gca,'ytick',[0 5 10 15])
% xlim([0, 15]);
% ylim([0, 15]);
% hold on
% plot(1,15,'.','markersize',1,'color','k')
% hold on
% for i = 1:150
%     for j = 1:150
%         if(p(i,j) == 1)
%             x = j/10.0;
%             y = 15.0- i/10.0; 
%             plot(x,y,'.','markersize',7,'color','k')
%             hold on
%         end
%     end
% end

