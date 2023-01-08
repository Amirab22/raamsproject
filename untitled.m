clear all;
close all;
mainAddress = 'H:\.shortcut-targets-by-id\0B090sjH0xr55LTE5QXc4ejBWZkU\NV Lab\Control code\Saves\Setup 1\_AutoSave\';
list_of_files_no_laser = ["ExpRaamS3_20221129_190307","ExpRaamS3_20221129_192517","ExpRaamS3_20221130_183118","ExpRaamS3_20221130_193646"];
list_of_files_with_laser = ["ExpRaamS3WithLaser_20221201_111332","ExpRaamS3WithLaser_20221201_121528","ExpRaamS3WithLaser_20221201_132448","ExpRaamS3WithLaser_20221204_151424"];
for i=1:length(list_of_files_no_laser)

    temp_load = load(strcat(mainAddress,list_of_files_no_laser(i)));
    name = strcat('WF = ',num2str(temp_load.myStruct.ExpRaamS3.amplitude(2)));
    data(i).name = name;
    data(i).experiment = temp_load;
    
    extracted = extractDataRamsey(temp_load.myStruct);
    data(i).raw_x = extracted.time;
    data(i).raw_y = extracted.signal.referenced/max(extracted.signal.referenced);
    data(i).raw_err = extracted.sterr.ref_err;
    [data(i).s2_time,data(i).S2_sig,data(i).err] = calculateS2(extracted.time,extracted.signal.referenced,extracted.sterr.ref_err);

    figure(1)
    ax = gca; ax.FontSize = 15; fig_hand = gcf;fig_hand.Color = 'w'; set(gcf,'Position',[680   326   880   652])
    l1 = legend('Location','northwest');
    title('S2 values');    xlabel('R1 time \musec');    ylabel('S2 value (norm. FL.)')
    plot(data(i).s2_time,data(i).S2_sig,'.-','MarkerSize',12,'DisplayName',data(i).name)
    hold on

    figure(2)
    ax = gca; ax.FontSize = 15; fig_hand = gcf;fig_hand.Color = 'w'; set(gcf,'Position',[680   326   880   652])
    l2 = legend();
    title('Ramsey with different drive');    xlabel('R1 time \musec');    ylabel('S2 value (norm. FL.)');


    plot(data(i).raw_x,data(i).raw_y,'.-','MarkerSize',8,'DisplayName',data(i).name)
    hold on


    Complete_data_No_laser = data;
end

clear i data  temp_load
for i=1:length(list_of_files_with_laser)

    temp_load = load(strcat(mainAddress,list_of_files_with_laser(i)));
    name = strcat('WF = ',num2str(temp_load.myStruct.ExpRaamS3WithLaser.amplitude(2)));
    data(i).name = name;
    data(i).experiment = temp_load;
    
    extracted = extractDataRamsey(temp_load.myStruct);
    data(i).raw_x = extracted.time;
    data(i).raw_y = extracted.signal.referenced/max(extracted.signal.referenced);
    data(i).raw_err = extracted.sterr.ref_err;
    [data(i).s2_time,data(i).S2_sig,data(i).err] = calculateS2(extracted.time,extracted.signal.referenced,extracted.sterr.ref_err);

    figure(3)
    ax = gca; ax.FontSize = 15; fig_hand = gcf;fig_hand.Color = 'w'; set(gcf,'Position',[680   326   880   652])
    l1 = legend('Location','northwest');
    title('S2 values With Laser');    xlabel('R1 time \musec');    ylabel('S2 value (norm. FL.)')
    plot(data(i).s2_time,data(i).S2_sig,'.-','MarkerSize',12,'DisplayName',data(i).name)
    hold on

    figure(4)
    ax = gca; ax.FontSize = 15; fig_hand = gcf;fig_hand.Color = 'w'; set(gcf,'Position',[680   326   880   652])
    l2 = legend();
    title('Ramsey with different drive with laser');    xlabel('R1 time \musec');    ylabel('S2 value (norm. FL.)');


    plot(data(i).raw_x,data(i).raw_y,'.-','MarkerSize',8,'DisplayName',data(i).name)
    hold on


     Complete_data_With_laser = data;
end