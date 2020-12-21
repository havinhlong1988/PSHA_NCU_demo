close all; clear all; clc;

%
load('cat_radius.mat');
lo=cat(:,2);la=cat(:,3);
% load all the source polygon and plot the catalog
sourcename={'S01' 'S02' 'S03' 'S04' 'S05A' 'S05B' 'S06' 'S07' 'S08A' 'S08B'...
    'S09' 'S10' 'S11' 'S12' 'S13' 'S14A' 'S14B' 'S14C' 'S15' 'S16' 'S17A'...
    'S17B' 'S18A' 'S18B' 'S19A' 'S19B' 'S20' 'S21'};
h=figure('Name','NCU-EQ','visible','on','Units','normalized','Position',[0 0 0.7 1]);
hold on;grid on;
plot(121.194,24.967,'V','MarkerSize',7,'MarkerEdgeColor',[0.0,0.8,0.0],...
    'MarkerFaceColor',[0.0,0.8,0.0]);
plot(la,lo,'.r');
for i=1:length(sourcename)
% Select data in polygon
sourcename1=['area_source/',sourcename{i},'.txt']; % load source polygon
inp=importdata(sourcename1);inp=inp.data;
xv=inp(:,1);yv=inp(:,2);
plot(xv,yv,'b','LineWidth',1.5); 
end
%axis square
axis ([120 122.5 24 26])
xlabel('Latitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Longitude','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
legend('NCU location','Selected Earthquake location','Source polygon','Location','best');