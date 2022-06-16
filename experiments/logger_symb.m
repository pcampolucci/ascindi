%% file to generate logger list from csv file

% read the header of the log
log_name = "06_01_22_fix_issues/test_fo_6p5.csv";
fid = fopen(log_name, 'r');
header = textscan(fid,'%s',1);
fclose(fid);

header_list = split(header{1,1}{1,1},",");

header_length = length(header_list);
spacing = 30;

for i = 1:header_length
    fprintf("out.%s %*s = log(interval,%d);\n",header_list{i,1},spacing-length(header_list{i,1})," ",i);
end