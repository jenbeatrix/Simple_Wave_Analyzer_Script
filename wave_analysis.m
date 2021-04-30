%Wave Analysis 
%by: Jen Beatrix Maristela

conn = sqlite('E:\MATLAB\database\sql_wavenetwork.db','connect')
sqlquery1 =['DELETE FROM wave_data;'];
deletecurs = exec(conn, sqlquery1)
close(deletecurs);
sqlquery2 = "DELETE FROM SQLITE_SEQUENCE WHERE name='wave_data';";
truncatecurs = exec(conn, sqlquery2);
close(truncatecurs);

curs = exec(conn, "SELECT * FROM sensor_data;");
curs = fetch(curs);
data = curs.Data;
cell2numdata = data{:,3:10}; %accelerometer to gyroscope only

waterlevel = cell2numdata(:,2);
[pks,locs] = findpeaks(waterlevel);
datetime = data{locs,2};
waveheight = data{locs,4};
imu = data{locs,5:10}; 
accex = imu(:,1);
accey = imu(:,2);
accez = imu(:,3);
gyrox = imu(:,4);
gyroy = imu(:,5);
gyroz = imu(:,6);


peaktime = data{locs,3};

a = length(peaktime);
    for n = 1:1:a
        if n < a;
            if mod(a,2) ~=0;
                res(n,:) = [peaktime(n+1,1)-peaktime(n,1)];
                waveperiod = [zeros(1); res]
                
                if n == 1;
                    tablename = "wave_data";
                    data1 = table(datetime(n,:),waveperiod(n,:),waveheight(n,:),accex(n,:),accey(n,:),accez(n,:),gyrox(n,:),gyroy(n,:),gyroz(n,:),'VariableNames',{'date_and_time' 'wave_period' 'wave_height' 'acce_x' 'acce_y' 'acce_z' 'gyro_x' 'gyro_y' 'gyro_z'}); %accelerometer to gyroscope only
                    sqlwrite(conn,tablename,data1)
                    
                    data2 = table(datetime(n+1,:),waveperiod(n+1,:),waveheight(n+1,:),accex(n+1,:),accey(n+1,:),accez(n+1,:),gyrox(n+1,:),gyroy(n+1,:),gyroz(n+1,:),'VariableNames',{'date_and_time' 'wave_period' 'wave_height' 'acce_x' 'acce_y' 'acce_z' 'gyro_x' 'gyro_y' 'gyro_z'}); %accelerometer to gyroscope only
                    sqlwrite(conn,tablename,data2)
                
                else
                    tablename = "wave_data";
                    data1 = table(datetime(n+1,:),waveperiod(n+1,:),waveheight(n+1,:),accex(n+1,:),accey(n+1,:),accez(n+1,:),gyrox(n+1,:),gyroy(n+1,:),gyroz(n+1,:),'VariableNames',{'date_and_time' 'wave_period' 'wave_height' 'acce_x' 'acce_y' 'acce_z' 'gyro_x' 'gyro_y' 'gyro_z'});
                    sqlwrite(conn,tablename,data1)
                end
                
            else mod(a,2) ==0;
                res(n,:) = [peaktime(n+1,1)-peaktime(n,1)];
                waveperiod = [zeros(1); res]
                
                if n == 1;
                    tablename = "wave_data";
                    data1 = table(datetime(n,:),waveperiod(n,:),waveheight(n,:),accex(n,:),accey(n,:),accez(n,:),gyrox(n,:),gyroy(n,:),gyroz(n,:),'VariableNames',{'date_and_time' 'wave_period' 'wave_height' 'acce_x' 'acce_y' 'acce_z' 'gyro_x' 'gyro_y' 'gyro_z'});
                    sqlwrite(conn,tablename,data1)
                    
                    data2 = table(datetime(n+1,:),waveperiod(n+1,:),waveheight(n+1,:),accex(n+1,:),accey(n+1,:),accez(n+1,:),gyrox(n+1,:),gyroy(n+1,:),gyroz(n+1,:),'VariableNames',{'date_and_time' 'wave_period' 'wave_height' 'acce_x' 'acce_y' 'acce_z' 'gyro_x' 'gyro_y' 'gyro_z'});
                    sqlwrite(conn,tablename,data2)
                
                else
                    tablename = "wave_data";
                    data1 = table(datetime(n+1,:),waveperiod(n+1,:),waveheight(n+1,:),accex(n+1,:),accey(n+1,:),accez(n+1,:),gyrox(n+1,:),gyroy(n+1,:),gyroz(n+1,:),'VariableNames',{'date_and_time' 'wave_period' 'wave_height' 'acce_x' 'acce_y' 'acce_z' 'gyro_x' 'gyro_y' 'gyro_z'});
                    sqlwrite(conn,tablename,data1)
                end
                
            end
        else
            if n > a;
                close(conn)
                break
            end
        end
    end