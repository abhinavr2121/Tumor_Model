function LogNumCell = getLogNumCell(Time,logNumCellInit,lambda,c)
    LogNumCell = logNumCellInit + lambda *(1.0 - exp(-c*Time));
end
