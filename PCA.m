% ------ PCA --------------
ds = datastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',25000);
T = read(ds);
yPrice = table2array(T(:,3:21));
y = T(:,4:21);
x = table2array(y);
Corr_x = corr(x);
x_cov = cov(x);
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

R = U(:,1:k).' * x.';
Z = R.';
ApproximateData = Z * U(1:k,1:k);

Error = 1/4 * sum(ApproximateData-Z);

% ------- Linear Regression--------
Alpha=.05;
TrainingSet = Z(1:16000,:);
TestSet = Z(16001:17999,:);

mTrain=length(TrainingSet(:,1));
mTest=length(TestSet(:,1));

XTrain=[ones(mTrain,1) TrainingSet];
Xtest=[ones(mTest, 1) TestSet];
nTrain=length(XTrain(1,:));
nTest=length(Xtest(1,:));
for w=2:nTrain
    if max(abs(XTrain(:,w)))~=0
    XTrain(:,w)=(XTrain(:,w)-mean((XTrain(:,w))))./std(XTrain(:,w));
    end
end

for p=2:nTest
    if max(abs(Xtest(:,p)))~=0
    Xtest(:,p)=(Xtest(:,p)-mean((Xtest(:,p))))./std(Xtest(:,p));
    end
end
Ytrain=yPrice(1:16000,1)/mean(yPrice(1:16000,1));
Ytest=yPrice(16001:17999,3)/mean(yPrice(16001:17999,3));
Theta=zeros(nTrain,1);
t=1;

Etrain(t)=(1/(2*mTrain))*sum((XTrain*Theta-Ytrain).^2);
Rtrain=1;
while Rtrain==1
%Alpha=Alpha*1;
Theta=Theta-(Alpha/mTrain)*XTrain'*(XTrain*Theta-Ytrain);
t=t+1
Etrain(t)=(1/(2*mTrain))*sum((XTrain*Theta-Ytrain).^2);
if Etrain(t-1)-Etrain(t)<0
    break
end 
qTrain=(Etrain(t-1)-Etrain(t))./Etrain(t-1);
if qTrain <.0001;
    Rtrain=0;
end
end


g=1;
Etest(g)=(1/(2*mTest))*sum((Xtest*Theta-Ytest).^2);
Rtest=1;
while Rtest==1
    g=g+1;
    Etest(g)=(1/(2*mTest))*sum((Xtest*Theta-Ytest).^2);
if Etest(g-1)-Etest(g)<0
    break
end
qTest=(Etest(g-1)-Etest(g))./Etest(g-1);
if qTest <.0001;
    Rtest=0;
end
end






