ds = datastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
yPrice = table2array(T(:,3:21));
y = T(:,4:21);
x = table2array(y);

%z = gaussian(x);
[m, n] = size(x);
mu = zeros(n, 1);
sigma = zeros(n, 1);

mu=mean(x);
sigma = var(x)*(m-1)/m;
y = mvnpdf(x,mu,sigma);
p = mvncdf(x,mu,sigma);

%F = selectThreshold(y, p);
q = max(p)
%[row,col] = find(p==q)
stepsize = 0.01;
for epsilon = min(x):stepsize:max(x)
    
    if min(p) < epsilon 
        MinThreshold = min(p);
    end
    
    if max(p(:)) > 1-epsilon
        MaxThreshold = max(p(:));
    end
end



% Assume that any value is smaller than min threshold or bigger than 
% max threshold is an anomaly

    
    
    