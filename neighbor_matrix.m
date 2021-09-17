function matrix = neighbor_matrix(pose,robot_nums,neighor_distance)
    matrix = eye(10);
    for i = 1:robot_nums
        agent_pose= pose(1:2,i);
        for j = 1:robot_nums
            neighbor_pose = pose(1:2,j);
            dist = sqrt((agent_pose(1)-neighbor_pose(1))^2 + (agent_pose(2)-neighbor_pose(2))^2); 
            if(dist<=neighor_distance)
                matrix(i,j) = 1; 
            end
        end
    end
end