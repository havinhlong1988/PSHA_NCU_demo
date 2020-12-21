close all; clear all; clc;
% -------------------------------------------------------------------------
%              Seismic Hazard Assessment by Chung-Han Chan
%              Home work assignment 1 for 2020-12-15 class 
% Model the seismicity rate as a function of magnitude according to 
%                   the catalogue: CWB catalog (1900-2016).xlsx
%   Code date: 2020 - 12 - 20
% -------------------------------------------------------------------------
filename = 'CWB catalog (1900-2016).xlsx';  
mkdir figures
% - soft the input catalog
% Only use for 1st time run; if run 2nd time comment line below
%select_cat(1994,2,9,24.967,121.194,100,filename,1);
% - Select 1 of 2 catalog below
% for all catalog
load('cat_out.mat','cat_select');
yq=cat_select(:,2);xq=cat_select(:,3);zq=cat_select(:,4);mq=cat_select(:,5);
% for radius 100km away from NCU catalog
%load('cat_radius.mat','cat_100');
%yq=cat_100(:,2);xq=cat_100(:,3);zq=cat_100(:,4);mq=cat_100(:,5);
save('cat_out.dat','cat_select','-ascii');
%
S=[];A=[];B=[];GRLAW=[];
sourcename={'S01' 'S02' 'S03' 'S04' 'S05A' 'S05B' 'S06' 'S07' 'S08A' 'S08B'...
    'S09' 'S10' 'S11' 'S12' 'S13' 'S14A' 'S14B' 'S14C' 'S15' 'S16' 'S17A'...
    'S17B' 'S18A' 'S18B' 'S19A' 'S19B' 'S20' 'S21'};
for i=1:length(sourcename)
% Select data in polygon
[la,lo,dp,mag]=select_cata_polygon(xq,yq,zq,mq,sourcename{i});
% compute the GL law
[a,b]=GRLaw(mag,sourcename{i});
S=[S sourcename{i}];
A=[A a];B=[B b];
end
GRLAW=[GRLAW A' B'];
save('GR_law.mat','GRLAW');
movefile *.png figures
close all; clear all; clc;