function control = updata_velocity(pose,goal_pose,velocity,robot_nums,Adjacency_Matrix,leader_matrix)
    l = 1;
    temp1 = pose(1:2,:) - goal_pose;
    temp2 = temp1.^2;
    temp2 = temp2(1,:) + temp2(2,:);
    distance = temp2.^(0.5);
    time = distance ./ velocity
    control = zeros(1,10);
    for i = 2:robot_nums
        row = Adjacency_Matrix(i,:);
        agent_time = time(i);
        sigma_time = 0.5*leader_matrix(i) *(agent_time - time(1));
        for j = 1 :robot_nums
            if(j~=5)
                weight = row(j)*0.1;
                sigma_time = sigma_time + l * weight * (agent_time - time(j));
            end
        end
        final_time = time(1) - sigma_time;
        if(final_time<0)
            final_time = 1;
        end
        vel =  distance(i) / final_time;
        if(vel>2)
            vel = 2;
        end
        control(i) = vel;
    end    
    control
end
