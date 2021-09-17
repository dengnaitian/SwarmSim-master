function sumCost = costFunction(A_matrix,B_Matrix,pose,goal_pose,follower_number, convergDist,type)
%================================================================
% function:  calculate cost
% author:    dengnaitian
% parameter: 
%        pose:     N¡ªagents position£¬size£º3*N 
%        A_matrix: N-agents adjacency matrix£¬size:N*N
%        B_matrix: the relation between leader and agents size:1*N
%        type: 1 is running cost£¬0 is final cost
%idear:  sumCost= distCost + numCost + convergCost*type
% return:  the cost of all agents
% data£º   2021/8/7 11:30
% todo:  all kinds of cost should be have Practical physical meaning
%================================================================
    distCost = 0.2;
    numCost = 0.2;
    convergCost = 0.4;  
    sumCost =0;
    cnt = 1;
    row = 1;
    while( cnt <= follower_number)
        %calculate the cost between agents and leader
        if(B_Matrix(row) ~= 0)
            distance = sqrt(sum( ((pose(1:2,1) - pose(1:2,row+1)).^2 ) ,1));
            sumCost = sumCost + distCost* B_Matrix(row) * distance + numCost;
        end
        %calculate the cost between each agents
        for col = 1: cnt
            if(A_matrix(row,col) ~= 0 )
                distance = sqrt(sum( ((pose(1:2,row+1) - pose(1:2,col+1)).^2 ) ,1));
                % cost = distCost + numCost
                sumCost = sumCost + distCost * A_matrix(row,col) *  distance + numCost;
            end
        end
        % calculate the distance of converge to goal_points
        distance = sqrt(sum( ((pose(1:2,row+1) - goal_pose).^2 ) ,1));
        sumCost = sumCost + distance * convergCost;
        
        % type ==0 represent should be calculate the convergeCost
        if(type == 0)
            distance = sqrt(sum( ((pose(1:2,row+1) - goal_pose).^2 ) ,1));
            if(distance >  convergDist)
                sumCost = sumCost + convergCost;
            end
        end
        cnt = cnt + 1;
        row = row + 1;
    end            
end