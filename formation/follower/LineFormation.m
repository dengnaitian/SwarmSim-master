classdef LineFormation < LFformation
    %LINEFORMATION 
    % A four-robot formation in line shape
    %   1
    %   |
    %   2
    %   |
    %   3
    %   |
    %   4
    
    properties
%         numRobots
%         leaderIdx
%         followInfo
    end
    
    methods
        function obj = LineFormation()
            %LINEFORMATION 
            obj.numRobots = 5;
            leadIdx = cell(4,1);
            leadIdx{1} = 1;
            leadIdx{2} = 2;
            leadIdx{3} = 3;
            leadIdx{4} = 4;
            obj.leaderIdx = leadIdx;
            followInfo = cell(4,1);
            param1.type = "dphi";
            param1.d = 1.0;
            param1.phi = 0;
            param2.type = "dphi";
            param2.d = 1.0;
            param2.phi = 0;
            param3.type = "dphi";
            param3.d = 1.0;
            param3.phi = 0;            
            param4.type = "dphi";
            param4.d = 1.0;
            param4.phi = 0;
            followInfo{1} = param1;
            followInfo{2} = param2;
            followInfo{3} = param3;
            followInfo{4} = param4;
            obj.followInfo = followInfo;
        end
        
    end
end

