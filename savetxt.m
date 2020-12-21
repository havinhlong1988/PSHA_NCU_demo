close all; clear all; clc;
load('cat_radius.mat','cat_100');
yq=cat_100(:,2);xq=cat_100(:,3);zq=cat_100(:,4);mq=cat_100(:,5);
save('cat_out_100.dat','cat_100','-ascii');