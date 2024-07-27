clear
close all
load sampledata.mat
hr=Acceleration.Timestamp.Hour;
min=Acceleration.Timestamp.Minute;
sec=Acceleration.Timestamp.Second;

uniq_sec=(hr*3600)+(min*60)+sec;
final_matrix=[uniq_sec Acceleration.X Acceleration.Y Acceleration.Z];
plot(final_matrix(:,1),final_matrix(:,2:4));
legend('X','Y','Z');
xlabel('Relative time (s)');
ylabel('Acceleration (m/s^2)');

x=final_matrix(:,2);
y=final_matrix(:,3);
z=final_matrix(:,4);
mag=sqrt(sum(x.^2 + y.^2+z.^2,2));

t=final_matrix(:,1);
figure
plot(t,mag);
xlabel('Time (m)');
ylabel('Acceleration (m/s^2)');

magNoG=mag-mean(mag);
figure
plot(t,magNoG);
xlabel('Time (m)');
ylabel('Acceleration (m/s^2)');
title('mean subtracted')

minPeakHeight = std(magNoG);

[pks,locs] = findpeaks(magNoG,'MINPEAKHEIGHT',minPeakHeight);
numSteps = numel(pks)
hold on;
plot(t(locs), pks, 'r', 'Marker', 'v', 'LineStyle', 'none');
title('Counting Steps');
xlabel('Time (s)');
ylabel('Acceleration Magnitude, No Gravity (m/s^2)');
hold off;
