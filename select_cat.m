function select_cat(ymin,magmin,magmax,clat,clong,radius,inxls,tab)
% Select catalog from xls file based on center location latitude, longitude
% and radius from center piont (in Km). And write out file name "out_cat.mat"
% - Input: + ymin: start year; + ymax: end year of the catalog
% + magmin: minimum magnitude sort-out; + magmax: maximum magnitude sort-out
% + clat: latitude of the center point;+ clong: longitude of the center point;
% + radius: The radius in kilometer from center point to select the catalog
% + inxls: excel file name; + tab: the tab of excel file to read the data
%%
data = xlsread(inxls,tab);
y= data(:,1);% m = data(:,2); d = data(:,3); h = data(:,4); mi = data(:,5);
lat = data(:,7);long = data(:,8);dep = data(:,9);mag = data(:,10);
% Remove the nan values
lat = lat(~isnan(lat)); long = long(~isnan(long)); 
dep = dep(~isnan(dep)); mag = mag(~isnan(mag));
% Softout the catalog by the time and magnitude based on the catalog
% completeness information
%%
i = find(y >= ymin & y <= max(y));
y1=y(i,:); lat1=lat(i,:); long1=long(i,:); dep1=dep(i,:); mag1=mag(i,:);
i1 = find(mag1 >= magmin & mag1 <= magmax);
y=y1(i1,:);lat=lat1(i1,:); long=long1(i1,:); dep=dep1(i1,:); mag=mag1(i1,:);
%
cat_select=[];
cat_select=[cat_select y lat long dep mag];
%
edges = unique(mag);
counts = histc(mag(:), edges);
% loading the center point latitude
lat0=clat; long0=clong;
%
cat_100 = [];
for i=1:length(mag)
    % Calculate distance using haversin formula
    d(i) = haversin(lat0,long0,lat(i),long(i));
    if (d(i) <= radius) % Select event < 50 km from center point
    cat_100 = [cat_100 ; y(i) lat(i) long(i) dep(i) mag(i)];
    end
end
edges1 = unique(mag);
counts1 = histc(mag(:), edges1);
% save data into file
save('cat_out.mat','cat_select')%,'-ascii')
save('cat_radius.mat','cat_100')%,'-ascii')
%% Plot the catalog statistic
h1=figure('Name','Annual','Numbertitle','off',...
    'Units','normalized','Position',[0 0 1 1],'visible','on');
bar(edges,counts,'FaceColor','flat');grid on;
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Number of event','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
title('Data distribution with magnitude','FontSize',18,'color','blue','FontName',...
    'Times New Roman','Fontweight','Bold')
saveas(gcf,'01.Catalog_select_statistic.png')
close(h1);
% Plot the catalog selected within the radius
h1=figure('Name','Annual','Numbertitle','off',...
    'Units','normalized','Position',[0 0 1 1],'visible','on');
subplot(1,2,1);
plot(lat0,long0,'r+',"LineWidth",3); grid on; hold on;
plot(cat_100(:,2),cat_100(:,3),'o','LineWidth',1,'MarkerSize',2.5,...
    'MarkerEdgeColor',[0.0,0.0,0.5],...
    'MarkerFaceColor',[0.0,0.0,0.5]);grid on; hold on;
axis square
xlabel('Latitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Longitude','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
legend('NCU location','Selected Earthquake location','Location','best');
title(['Event selected from CWB catalog (',num2str(length(data(:,1))),') events'],'FontSize',14,'color','blue','FontName',...
    'Times New Roman','Fontweight','Bold')
subplot(1,2,2)
bar(edges1,counts1,'FaceColor','flat');grid on;
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Number of event','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
title('Data distribution with magnitude','FontSize',18,'color','blue','FontName',...
    'Times New Roman','Fontweight','Bold')
saveas(gcf,'02.Catalog_radius_statistic.png')
close(h1);
end