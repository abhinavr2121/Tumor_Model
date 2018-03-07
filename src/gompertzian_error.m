load('.././data/cells.mat');
Time = [0 10 12 14 16 18 20 22];
ndata = length(Time);
NumCell = zeros(ndata,1);
NumCell(1) = 100000;
NumCellErr = zeros(ndata,1);
NumCellErr(1) =  10000;

binCells = cells;
binCells(binCells~=0) = 1;

for itime = 2:ndata
    NumCell(itime) = sum(sum(sum(cells(:,:,:,itime-1))));
end

for itime = 2:ndata
    for izslice = 1:length(cells(1,1,:,itime-1))
        BCell =  bwboundaries(binCells(:,:,izslice,itime-1));
        for iobject = 1:length(BCell)
            for irow = 1:length(BCell{iobject})
                NumCellErr(itime) = NumCellErr(itime) + cells(BCell{iobject}(irow,1),BCell{iobject}(irow,2),izslice,itime-1);
            end
        end
    end
end
NumCellErr = 0.5*NumCellErr;%to match graph online
figure();
hold on;
E = errorbar(Time,NumCell,NumCellErr,...         
         '.-',...
         'color','blue',...
         'markersize',30,...
         'linewidth',3,...
         'MarkerFaceColor','blue',...
         'MarkerEdgeColor','blue');
yticks([0,2e7,4e7,6e7,8e7,10e7,12e7,14e7,16e7]);
xticks([0,5,10,15,20]);
title('Gompertzian Fit to Rat''s Brain Tumor Growth');
[lgnd, Cells] = legend('Experimental Data','Location','northwest');
xlabel('Time [ days ]');
ylabel('Tumor Cell Count');
hold off;