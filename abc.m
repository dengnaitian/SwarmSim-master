close all
clear 
clc


other_1_x = 10:46:194;
other_1_y = 2.001:0.002:2.01;
other_1_t = 1:2:10;

other_2_x = 60:60:300;
other_2_y = 6.001:0.002:6.01;
other_2_t = 1:2:10;

other_3_x = 100:50:300;
other_3_y = 2.001:0.002:2.01;
other_3_t = 1:2:10;

ego_x = 10:60:250;
ego_y = [ 5.5, 5.2, 4, 2.8, 2.5 ];
ego_t = 1:2:10;
t1 = linspace( ego_t(1),ego_t(end), 50 );
x1 = linspace( ego_x(1),ego_x(end), 50 );
y1 = interp1( ego_x,ego_y,x1,'cubic' );

%==========================================================================
% å›?1
%==========================================================================
figure('Name','å›?1')
    for i=1:5
        plotcube([30 0.4 0.5], [ x1(i*10)-4.5  y1(i*10)-0.15  t1(i*10)-0.25],          0.5, [0      0.447  0.741]);
        plotcube([30 0.4 0.5], [ x1(i*10)-4.5  12-(y1(i*10)-0.15)  t1(i*10)-0.25],          0.5, [0      0.447  0.741]);
        plotcube([30 0.4 0.5], [other_1_x(i)-4.5 other_1_y(i)-0.15 other_1_t(i)-0.25], 0.3, [1      0      0    ]);
        plotcube([30 0.4 0.5], [other_2_x(i)-4.5 other_2_y(i)-0.15 other_2_t(i)-0.25], 0.3, [0.439  0.188  0.627]);
%         plotcube([30 0.4 0.5], [other_3_x(i)-4.5 other_3_y(i)-0.15+3 other_3_t(i)-0.25], 0.5, [0.662  0.752  0.603]);
    end
    hold on
    plot3( x1,y1,t1,                     '-' ,'LineWidth',3,'Color','#0072BD' );
    hold on
    plot3( x1,12-y1,t1,                     '-' ,'LineWidth',3,'Color','#0072BD' );
    hold on    
    plot3( other_1_x,other_1_y,other_1_t,'--' ,'LineWidth',1,'Color','k' );
    hold on
    plot3( other_2_x,other_2_y,other_2_t,'--' ,'LineWidth',1,'Color','k' );
    hold on
%     plot3( other_3_x,other_3_y+3,other_3_t,'-' ,'LineWidth',3,'Color','#0072BD' );
    %hold on
    % t2 å’? t4 æ—¶åˆ»çš„åˆ‡ç‰?
%     plotcube([330 8 0.000001], [ 0  0  2], 0.3, [0.905 0.901 0.901]);
%     plotcube([330 8 0.000001], [ 0  0  4], 0.3, [0.905 0.901 0.901]);
%     plotcube([330 8 0.000001], [ 0  0  6], 0.3, [0.905 0.901 0.901]);
%     plotcube([330 8 0.000001], [ 0  0  8], 0.3, [0.905 0.901 0.901]);
%     plotcube([330 8 0.000001], [ 0  0  10], 0.3, [0.905 0.901 0.901]);
    hold off

    xlabel('X (m)','FontName','Times New Roman','FontSize',10)
    ylabel('Y (m)','FontName','Times New Roman','FontSize',10)
    zlabel('Time (s)','FontName','Times New Roman','FontSize',10)
    set(gca,'FontName','Times New Roman','FontSize',10,'LineWidth',0.7)
    zticks([2 4 6 8 10])
    zticklabels({'t1','t2','t3','t4','t5'})
    grid on
    box on
    %axis equal
        % å›¾ä¾‹è¯´æ˜Ž
        plotcube([15 0.3 0.5], [ 20  0.5  0], 0.5, [0      0.447  0.741]);
        plotcube([15 0.3 0.5], [ 100 0.5  0], 0.3, [1      0      0    ]);
        plotcube([15 0.3 0.5], [ 180 0.5  0], 0.3, [0.439  0.188  0.627]);
        %plotcube([15 0.3 0.5], [ 260 0.5  0], 0.5, [0.662  0.752  0.603]);
        text(  40,0.5,0.5, 'Ego', 'FontName','Times New Roman','FontSize',10);
        text( 120,0.5,0.5, 'Car1','FontName','Times New Roman','FontSize',10); 
        text( 200,0.5,0.5, 'Car2','FontName','Times New Roman','FontSize',10);
        %text( 280,0.5,0.5, 'Car3','FontName','Times New Roman','FontSize',10);
    axis( [0 330 0 16 0 12] )

% %==========================================================================
% % å›?2
% %==========================================================================
% figure('Name','å›?2')
%     for i=1:5
%         plotcube([15 0.3 0.5], [ x1(i*10)-4.5  y1(i*10)-0.15  t1(i*10)-0.25],          0.5, [0      0.447  0.741]);
%         plotcube([15 0.3 0.5], [other_1_x(i)-4.5 other_1_y(i)-0.15 other_1_t(i)-0.25], 0.3, [1      0      0    ]);
%         plotcube([15 0.3 0.5], [other_2_x(i)-4.5 other_2_y(i)-0.15 other_2_t(i)-0.25], 0.3, [0.439  0.188  0.627]);
%         plotcube([15 0.3 0.5], [other_3_x(i)-4.5 other_3_y(i)-0.15 other_3_t(i)-0.25], 0.5, [0.662  0.752  0.603]);
%     end
%     hold on
%     plot3( x1,y1,t1,                     '-' ,'LineWidth',3,'Color','#0072BD' )
%     hold on
%     plot3( other_1_x,other_1_y,other_1_t,'--' ,'LineWidth',1,'Color','k' )
%     hold on
%     plot3( other_2_x,other_2_y,other_2_t,'--' ,'LineWidth',1,'Color','k' )
%     hold on
%     plot3( other_3_x,other_3_y,other_3_t,'--' ,'LineWidth',1,'Color','k' )
%     hold on
%     plotcube([330 8 0.001], [ 0  0  5.8], 0.5, [0.905 0.901 0.901]);
%     hold off
% 
%     xlabel('X (m)','FontName','Times New Roman','FontSize',10)
%     ylabel('Y (m)','FontName','Times New Roman','FontSize',10)
%     zlabel('Time (s)','FontName','Times New Roman','FontSize',10)
%     set(gca,'FontName','Times New Roman','FontSize',10,'LineWidth',0.7)
%     grid on
%     box on
%     % axis equal
%     axis( [0 330 0 8 0 12] )
% 
% %==========================================================================
% % å›?3
% %==========================================================================
% figure('Name','å›?3')
%     for i=1:5
%         plotcube([15 0.3 0.5], [ x1(i*10)-4.5  y1(i*10)-0.15  t1(i*10)-0.25],          0.5, [0      0.447  0.741]);
%         plotcube([15 0.3 0.5], [other_1_x(i)-4.5 other_1_y(i)-0.15 other_1_t(i)-0.25], 0.3, [1      0      0    ]);
%         plotcube([15 0.3 0.5], [other_2_x(i)-4.5 other_2_y(i)-0.15 other_2_t(i)-0.25], 0.3, [0.439  0.188  0.627]);
%         plotcube([15 0.3 0.5], [other_3_x(i)-4.5 other_3_y(i)-0.15 other_3_t(i)-0.25], 0.5, [0.662  0.752  0.603]);
%     end
%     hold on
%     plot3( x1,y1,t1,                     '-' ,'LineWidth',3,'Color','#0072BD' )
%     hold on
%     plot3( other_1_x,other_1_y,other_1_t,'--' ,'LineWidth',1,'Color','k' )
%     hold on
%     plot3( other_2_x,other_2_y,other_2_t,'--' ,'LineWidth',1,'Color','k' )
%     hold on
%     plot3( other_3_x,other_3_y,other_3_t,'--' ,'LineWidth',1,'Color','k' )
%     hold on
%     plotcube([330 8 0.001], [ 0  0  8.8], 0.5, [0.905 0.901 0.901]);
%     hold off
% 
%     xlabel('X (m)','FontName','Times New Roman','FontSize',10)
%     ylabel('Y (m)','FontName','Times New Roman','FontSize',10)
%     zlabel('Time (s)','FontName','Times New Roman','FontSize',10)
%     set(gca,'FontName','Times New Roman','FontSize',10,'LineWidth',0.7)
%     grid on
%     box on
%     % axis equal
%     axis( [0 330 0 8 0 12] )



function plotcube(varargin)
% PLOTCUBE - Display a 3D-cube in the current axes
%
%   PLOTCUBE(EDGES,ORIGIN,ALPHA,COLOR) displays a 3D-cube in the current axes
%   with the following properties:
%   * EDGES : 3-elements vector that defines the length of cube edges
%   * ORIGIN: 3-elements vector that defines the start point of the cube
%   * ALPHA : scalar that defines the transparency of the cube faces (from 0
%             to 1)
%   * COLOR : 3-elements vector that defines the faces color of the cube
%
% Example:
%   >> plotcube([5 5 5],[ 2  2  2],.8,[1 0 0]);
%   >> plotcube([5 5 5],[10 10 10],.8,[0 1 0]);
%   >> plotcube([5 5 5],[20 20 20],.8,[0 0 1]);

% Default input arguments
inArgs = { ...
  [10 56 100] , ... % Default edge sizes (x,y and z)
  [10 10  10] , ... % Default coordinates of the origin point of the cube
  .7          , ... % Default alpha value for the cube's faces
  [1 0 0]       ... % Default Color for the cube
  };

% Replace default input arguments by input values
inArgs(1:nargin) = varargin;

% Create all variables
[edges,origin,alpha,clr] = deal(inArgs{:});

XYZ = { ...
  [0 0 0 0]  [0 0 1 1]  [0 1 1 0] ; ...
  [1 1 1 1]  [0 0 1 1]  [0 1 1 0] ; ...
  [0 1 1 0]  [0 0 0 0]  [0 0 1 1] ; ...
  [0 1 1 0]  [1 1 1 1]  [0 0 1 1] ; ...
  [0 1 1 0]  [0 0 1 1]  [0 0 0 0] ; ...
  [0 1 1 0]  [0 0 1 1]  [1 1 1 1]   ...
  };

XYZ = mat2cell(...
  cellfun( @(x,y,z) x*y+z , ...
    XYZ , ...
    repmat(mat2cell(edges,1,[1 1 1]),6,1) , ...
    repmat(mat2cell(origin,1,[1 1 1]),6,1) , ...
    'UniformOutput',false), ...
  6,[1 1 1]);


cellfun(@patch,XYZ{1},XYZ{2},XYZ{3},...
  repmat({clr},6,1),...
  repmat({'FaceAlpha'},6,1),...
  repmat({alpha},6,1)...
  );

view(3);
end