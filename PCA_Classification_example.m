clear;

%-------------- PCA --------------%
x1 = [2 3 3 4 5 5 6 6;6 4 5 3 2 4 0 1];
x2 = [6 6 7 8 8 9 9 10;4 5 3 2 4 0 2 1];

num_of_samples = 16;

total = [0;0];

%Calculate Mean Vector
for i = 1:num_of_samples/2
    total = x1(:,i)+total;
end
    
for i = 1:num_of_samples/2
    total = x2(:,i)+total;
end

mean = 1/num_of_samples*total;

%Demean x1 and x2
for i = 1:num_of_samples/2
   de_x1(:,i) = x1(:,i)-mean; 
end

for i = 1:num_of_samples/2
    de_x2(:,i) = x2(:,i)-mean;
end

%Covariance Matrix
Cov_Matrix = 1/16*(de_x1*de_x1' + de_x2*de_x2');

%Find eigenvectors and eigenvalues of covariance matrix
[EV,ED] = eig(Cov_Matrix);

%Always choose the eigenvector with largest eigenvalues for projection
projected_x1 = EV(:,2)'*de_x1;
projected_x2 = EV(:,2)'*de_x2;

%-------------- PCA is done --------------%


%-------------- Minimum distance classifier --------------%
total_1 = 0;
total_2 = 0;

mean_1 = 0;
mean_2 = 0;

for i = 1:num_of_samples/2
    total_1 = projected_x1(i)+total_1;
end
mean_1 = 1/((num_of_samples)/2)*total_1;
    
for i = 1:num_of_samples/2
    total_2 = projected_x2(i)+total_2;
end
mean_2 = 1/((num_of_samples)/2)*total_2;


%Classification of query point q(4,6)
q = [4,6];

de_q(:,1) = q(:,1) - mean(:,1);

prediction = EV(:,2)'*de_q;

Distance_class_x1 = abs(prediction - mean_1);
Distance_class_x2 = abs(prediction - mean_2);

%Classification result
%The query belongs to the class with smaller distance
if(Distance_class_x1<Distance_class_x2)
    disp('Query point q(4,6) belongs to class x1')
else
    disp('Query point q(4,6) belongs to class x2')
end











