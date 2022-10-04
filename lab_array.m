function [storeDataStruct] = lab_array(fileName)
%LABTOARRAY Puts .lab files into a structure
%   Detailed explanation goes here

fid = fopen(fileName,'rt');
ind = 0;
% Read column 1
textCol1 = fscanf(fid,'%i',1);
while (textCol1~=1)
 % Read column 2
 textCol2 = fscanf(fid,'%i',1);
 textCol3 = fscanf(fid,'%s',1);

 % Store the data into a structure array
 ind = ind+1;
 storeDataStruct(ind).start = textCol1;
 storeDataStruct(ind).end = textCol2;
 storeDataStruct(ind).phoneme = textCol3;

 % Read column 1 - next row
 textCol1 = fscanf(fid,'%i',1);
end

fclose(fid);

end

