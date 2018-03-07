% data setup
global logNumCellInit Time LogNumCell ndata
load('.././data/cells.mat')
numCellInit = 100000;
logNumCellInit = log(numCellInit);
Time = [0,10,12,14,16,18,20,22];
ndata = length(Time);
NumCell = zeros(ndata,1);
LogNumCell = zeros(ndata,1);
Error = zeros(ndata,1);
for itime = 2:ndata
    NumCell(itime) = sum(sum(sum(cells(:,:,:,itime-1))));
    for z = 1:16
        boundary = bwboundaries(cells(:,:,z,itime-1));
        if length(boundary) == 1
           Error(itime) = Error(itime) + length(boundary{1});
        end
    end

    LogNumCell(itime) = log( NumCell(itime));
end

%data fitting
%order of parameters: lamba,c,sigma
ParamInit = [10,0.1,1];
ParamOptimal = fminsearch(@getLogLikeFinal, ParamInit);


idealtime = 0:.1:25;
NumCellModel = exp(getLogNumCell(idealtime,logNumCellInit,ParamOptimal(1),ParamOptimal(2)));

Error = Error * 20000;

errorbar(Time...
    ,NumCell...
    ,Error ...
    ,'linewidth',3 ...
    ,'markerfacecolor', 'blue' ...
    )

hold on;

plot(idealtime...
    , NumCellModel...
    ,'linewidth',3 ...
    ,'markersize',30 ...
    ,'markerfacecolor', 'red' ...
    )

axis([0 25 0 200000000]) 
xlabel('Time [days]','fontsize',13);
ylabel('Tumor Cell Count','fontsize', 13);
title('Gompertzian Fit to Rat''s Brain Tumor Growth') 
legend('Experimental Data','Gompertzian Fit','Location','northwest')


saveas(gcf, '.././results/gompertzian.png')
