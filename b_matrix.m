function b_matrix = b_matrix(pose,robot_nums,neighor_distance)
    b_matrix = zeros(1,10);
    leader_pose = pose(1:2,1);
    for i = 2:robot_nums
        agent_pose= pose(1:2,i);
        dist = sqrt((agent_pose(1)-leader_pose(1))^2 + (agent_pose(2)-leader_pose(2))^2); 
        if(dist<=neighor_distance)
                b_matrix(1,i) = 1; 
        end       
    end
end