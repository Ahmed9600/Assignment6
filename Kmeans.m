ds = datastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
yPrice = table2array(T(:,3:21));
y = T(:,4:21);
X = table2array(y); 
Corr_x = corr(X);
x_cov = cov(X);
[U S V] = svd(x_cov);
EigenValues = max(S);
k=0;
b = 0;
while b==0
    alpha = 1-(sum(EigenValues(1:k))/sum(EigenValues));
    if(alpha<=0.001)
        break;
    end
        k=k+1;
end

R = U(:,1:k).' * X.';
Z = R.';
K = 8;

max_iterations = 10;
centroids = initCentroids(X, K);
CentroidsReducedData = initCentroids(Z, K);
numberOfClusters = [1,2,3,4,5,6,7,8];
NumberOfClustersReduced = [1,2,3];
%for counter=1:10
for i=1:max_iterations
  indices = getClosestCentroids(X, centroids);
  centroids = computeCentroids(X, indices, K);
end


%J(counter)=0;
for i=1:K
    J(i) = 1/i * sum(X(i)-centroids(i))^2;
end
%numberOfClusters(counter)=counter;


for i=1:K
  indicesReducedData = getClosestCentroids(Z, CentroidsReducedData);
  CentroidsReducedData = computeCentroids(Z, indicesReducedData, K);
end

for i=1:K
    JReducedData(i) = 1/i * sum(Z(i)-CentroidsReducedData(i))^2;
end
%Figure(2)
%title('reduced');
%plot(NumberOfClustersReduced,JReducedData);
%end
plot(numberOfClusters,J);
