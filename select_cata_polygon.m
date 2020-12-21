function [la,lo,dp,mg]=select_cata_polygon(xq,yq,zq,mq,sourcename1) 
%close all; clear all; clc;
%
%sourcename='S01';
curdir=pwd;
sourcename=['area_source/',sourcename1 '.txt']; % load source polygon
%load('out_cat.mat','cat_select');
%load('cat_radius.mat','cat');
%cat_select=cat;
%xq=cat_select(:,2);yq=cat_select(:,3);
%
inp=importdata(sourcename);inp=inp.data;
xv=inp(:,1);yv=inp(:,2);
% remove Nan's from the data 
%xv = polygon1_y ; yv = polygon1_x ; 
xv(isnan(xv)) = [] ;
yv(isnan(yv)) = [] ;
%
[in,on] = inpolygon(xq,yq,xv,yv); % Logical Matrix
inon = in | on; % Combine ‘in’ And ‘on’
idx = find(inon(:)); % Linear Indices Of ‘inon’ Points
la = xq(idx);
lo = yq(idx);
dp = zq(idx);
mg = mq(idx);
%
catname=[sourcename,'-catalog'];
h=figure('Name',catname,'visible','off');
plot(xv,yv,'b'); hold on; grid on;
plot(la,lo,'*r')
%axis([min(xq) max(xq) min(i])
axis square
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Number of event','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
title(['Catalog of source ',sourcename1,' (',num2str(length(la)),' events)'],...
    'FontSize',14,'color','blue','FontName',...
    'Times New Roman','Fontweight','Bold')
saveas(gcf,[curdir,'/',sourcename1,'.png']);
close(h);
end