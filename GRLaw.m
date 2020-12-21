function [a,b]=GRLaw(mag,sourcename)
% Statis tic the value in array
edges = unique(mag);
%edges = flipud(edges); % revese the array for positive a value
mag = flipud(mag);
% Count the 
counts = histc(mag(:), edges);
c = polyfit(edges,log10(counts),1);
xfit=(min(edges):0.1:max(edges));xfit=xfit';
ycal = polyval(c,xfit);
% Softout the values
i = find(edges >= 3.0 & edges < 7.0);
%
xsoft = edges(i); ysoft = counts(i);
%
c1 = polyfit(xsoft,log10(ysoft),1);
yfit2 = polyval(c1,xsoft);
a=c1(2);b=c(1);
%%
%
h=figure('Name',['PHSA model for ',sourcename],'Numbertitle','off','visible','off','Units','normalized','Position',[0 0 1 1]);
subplot(1,2,1);
semilogy(edges,counts,'o','LineWidth',1,'MarkerSize',7,...
    'MarkerEdgeColor',[0.0,0.0,0.5],...
    'MarkerFaceColor',[0.0,0.0,0.5]);grid on; hold on;
semilogy(xfit,10.^ycal,'r.-','MarkerSize',15,'LineWidth',1);
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Annual rate R^2','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
legend('observation data','linear fitting model')
title('Origin catalog','FontSize',14,'color','blue','FontName',...
    'Times New Roman','Fontweight','Bold')
axis([min(edges)*0.9 max(edges)*1.1 min(counts)*0.9 max(counts)*1.1]);
%
subplot(1,2,2);
semilogy(xsoft,ysoft,'o','LineWidth',1,'MarkerSize',7,...
    'MarkerEdgeColor',[0.0,0.0,0.5],...
    'MarkerFaceColor',[0.0,0.0,0.5]);grid on; hold on;
semilogy(xsoft,10.^yfit2,'r.-','MarkerSize',15,'LineWidth',1);
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Annual rate R^2','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
legend('observation data','linear fitting model')
title('Revised catalog','FontSize',14,'color','blue','FontName',...
    'Times New Roman','Fontweight','Bold')
txt ={'a-value = ',a,"; b-value=",b};
text(((min(xsoft)+max(xsoft))/2+0.1),((min(ysoft)+max(ysoft))/2+0.2),txt,"FontSize",17)
axis([min(xsoft)*0.9 max(xsoft)*1.1 min(ysoft)*0.9 max(ysoft)*1.1]);
suptitle(['Best fit model with input catalog for Zone ',sourcename])
modfig=[sourcename,'.PSHA_model.png'];
%print['-dtiff','-r100','.PSHA_model.tiff'];
saveas(gcf,modfig);
close(h);
%
h1=figure('Name',['Annual rate',sourcename],'Numbertitle','off','visible','off','Units','normalized');
bar(edges,counts,'FaceColor','flat');grid on;
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Number of event','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
title(['Data distribution with magnitude of Zone ',sourcename],...
    'FontSize',18,'color','blue','FontName',...
    'Times New Roman','Fontweight','Bold')
catfig=[sourcename,'.Catalog_statistic.png'];
%print('-dtiff','-r100',cat_fig);
saveas(gcf,catfig);
close(h1);
end