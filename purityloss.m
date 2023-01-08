for i = 1:1:4 
   [ s2_time_test,s2_sig_test] = calculateS2(Complete_data_With_laser(i).raw_x,Complete_data_With_laser(i).raw_y);
plot(s2_time_test,s2_sig_test+s2_sig_test.^2,'-.','Color',C(i,:),'DisplayName',strcat('S2+S2^2',Complete_data_With_laser(i).name));
hold on 
plot(s2_time_test,s2_sig_test,'-.','Color',C(i,:),'DisplayName',strcat('S2+S2^2',Complete_data_With_laser(i).name));

end 