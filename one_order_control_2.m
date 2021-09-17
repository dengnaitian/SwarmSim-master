function control = one_order_control_2(pose,goal_pose,leader_velocity,follower_nums,A_matrix,B_Matrix,eig_value)
    % parameter：
    % leader_velocity ; distance_to_goal ; A_matrix ; B_matrix
%     lamda = 0.1729;
    k = 1 / (4* 0.5 * (1-0.5*0.5)*eig_value) + 1;
    temp1 = pose(1:2,:) - goal_pose;
    temp2 = temp1.^2;
    distance =sqrt( temp2(1,:) + temp2(2,:));
%     distance = temp2.^(0.5);
    leader_dis = distance(1);
    foll_dis   = distance(2:follower_nums+1);
    u = zeros(1,follower_nums);
    v = leader_velocity;
    for i = 1:follower_nums
        sigma = 0;
        for j = 1: follower_nums
            a_ij = A_matrix(i,j);
            b_i0 = B_Matrix(i);
            sigma = sigma +  a_ij * (foll_dis(i) - foll_dis(j)) + b_i0 * (foll_dis(i) -leader_dis);
        end
        % 由于简化了观测器，直接得到了速度，因此相当于每一个都有链接，没有实现全部断开
        % 假如与leader有联系，则获取v
        u(i) = (k) * sigma + v ;
%         if(B_Matrix(i) ~=0)
%            u(i) = (k) * sigma + v ;
%         % 假如没联系，则看他是否有跟其他范围内的agent有联系
%         else
%             flag = 0;
%             %遍历看看是否抱紧大腿
%             for index = 1:follower_nums
%                 flag = flag || ( B_Matrix(index) && A_matrix(i,index) );
%             end
%             %假如有大腿抱，则可以获取速度
%             if(flag ==1)
%                 u(i) = (k) * sigma +v;
%             % 假如没有大腿抱，则无法获取
%             else
%                 u(i) = (k) * sigma;
%             end
%         end
    end
    control = u;
end