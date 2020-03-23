clear;

%-------------- LDA --------------%
x1 = [2 3 3 4 5 5 6 6;6 4 5 3 2 4 0 1];
x2 = [6 6 7 8 8 9 9 10;4 5 3 2 4 0 2 1];

num_of_samples = 16;

%Mean for class x1
total_x1 = [0;0];
for i = 1:num_of_samples/2
    total_x1(:,1) = x1(:,i)+total_x1(:,1);
end
mean_x1 = (1/(num_of_samples/2))*total_x1;

%Mean for class x2
total_x2 = [0;0];
for i = 1:num_of_samples/2
    total_x2(:,1) = x2(:,i)+total_x2(:,1);
end
mean_x2 = (1/(num_of_samples/2))*total_x2;


%Demean for class x1
for i = 1:num_of_samples/2
    de_x1(:,i) = x1(:,i)-mean_x1;
end
%Demean for class x2
for i = 1:num_of_samples/2
    de_x2(:,i) = x2(:,i)-mean_x2;
end


%Within-class scattering matrix S1, S2
S_1 = de_x1*de_x1';
S_2 = de_x2*de_x2';
Sw = S_1 + S_2;
Sw_inv = inv(Sw);

%Projection vector of LDA
w = Sw_inv*(mean_x1-mean_x2);

%Project data to w
projected_x1 = w'*x1;
projected_x2 = w'*x2;

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

% Consider q(4,6) as a query point
q = [4;6];
classify = w'*q;

distance_x1 = abs(classify - mean_1);
distance_x2 = abs(classify - mean_2);

if(distance_x1<distance_x2)
    disp('Query point belongs to class x1')
else
    disp('Query point belongs to class x2')
end
