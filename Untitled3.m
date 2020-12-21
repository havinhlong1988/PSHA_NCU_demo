close all; clear all; clc;

%
load('cat_radius.mat');
lo=cat(:,2);la=cat(:,3);
% load all the source polygon and plot the catalog
sourcename={'S01' 'S02' 'S03' 'S04' 'S05A' 'S05B' 'S06' 'S07' 'S08A' 'S08B'...
    'S09' 'S10' 'S11' 'S12' 'S13' 'S14A' 'S14B' 'S14C' 'S15' 'S16' 'S17A'...
    'S17B' 'S18A' 'S18B' 'S19A' 'S19B' 'S20' 'S21'};
h=figure('Name','NCU-EQ','visible','on');
hold on;grid on;
for i=1:length(sourcename)
% Select data in polygon
sourcename1=['area_source/',sourcename{i},'.txt']; % load source polygon
inp=importdata(sourcename1);inp=inp.data;
xv=inp(:,1);yv=inp(:,2);
plot(xv,yv,'b','LineWidth',1.5); 
end
axis square
plot(la,lo,'.r');
