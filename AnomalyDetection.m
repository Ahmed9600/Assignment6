ds = datastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
yPrice = table2array(T(:,3:21));
y = T(:,4:21);
x = table2array(y);
%TrainingSet = x(1:10800,:);
%TestSet = x(10801:17999,:);
val = x(9999,:);

%z = gaussian(x);
[m, n] = size(x);
mu = zeros(n, 1);
sigma = zeros(n, 1);

mu=mean(x);
%sigma = var(TrainingSet)*(m-1)/m;
sigma = std(x);
%for i=1:18
N = normcdf(val,mu,sigma);
F = normpdf(val,mu,sigma);
%end
%p = mvncdf(x,mu,sigma);
epsilon = 0.001;
anom = prod(N);


AnomDetection = (anom>=epsilon) || (anom<epsilon);


%F = selectThreshold(y, p);
%q = max(p)
%[row,col] = find(p==q)
%stepsize = 0.01;
%for epsilon = min(x):stepsize:max(x)
    
    %if min(p) < epsilon 
     %   MinThreshold = min(p);
    %end
    
   % if max(p(:)) > 1-epsilon
  %      MaxThreshold = max(p(:));
 %   end
%end



% Assume that any value is smaller than min threshold or bigger than 
% max threshold is an anomaly

    
    
    