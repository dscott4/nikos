function [dataset] = load_npower_data( data_location)
%Sorry this is so messy
[dataset] = xlsread(data_location);
day_points = 480;
[m_old,n_old] = size(dataset);
[dataset] = [ones(m_old,2) dataset];
day_sequence = [7*ones(1,day_points),1*ones(1,day_points),2*ones(1,day_points),3*ones(1,day_points),4*ones(1,day_points),5*ones(1,day_points),6*ones(1,day_points)];
day_sequence = day_sequence';
day_sequence = repmat(day_sequence,[(round(m_old/(day_points*7))+1) 1]);
day_sequence = day_sequence(1:m_old,:);
dataset(:,2) = day_sequence;

leap_year = [1:1:365];
adjuster = 0;
for j = 1:2
    if j>1
        adjuster = 1;
    end
    for i = 1:(365-adjuster)
        year_sequence((j*(day_points*i-(day_points-1))):day_points*i*j,1)=leap_year(i);
    end
end

dataset(:,1) = year_sequence(1:m_old,:);

end

xlswrite(dataset,'interp_data.xlsx')