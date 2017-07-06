%%
%%The purpose of this program is to compare the performence of polynom with
%%different power exponent.
%%finally we got the power=5 performs better than the others.
%%
close all;
clear;
clc;
data = csvread('output.csv');
X =data(:,1:end-1);
y = csvread('max_and_min_shear_angle.csv');



%add power item for X
cor_coe = [];
error_mean = [];
error_abs_sum = [];
X_power = X;
for power = 2:10
    for m = 1:size(X,2)
        for m1 = 2:power
            X_power = [X_power,X(:,m).^m1,X(:,m).^(1/m1)];
        end
    end
    X_power = [ones(size(X,1),1),X_power];
    theta = X_power \ y;
    y_predict = X_power*theta;
    delta_y = abs(y -y_predict);
    r = corrcoef(y,y_predict);
    cor_coe(end +1) = r(2);
    %error_mean(end + 1) = mean(delta_y);
    %error_abs_sum(end+1) = sum(delta_y);
    X_power = X;
end

figure(1)
plot(2:10,cor_coe,'o-');
xlabel('power exponent');
ylabel('correlation coefficient value');
title('Correlation coefficient');
figure(2)
plot(2:10,error_mean,'o-');
xlabel('power exponent');
ylabel('error mean value');
title('Error mean');
figure(3)
plot(2:10,error_abs_sum,'o-');
xlabel('power exponent');
ylabel('error sum');
title('Error sum');

%add c_0=[1...1]' als first column
% X_power = [ones(size(X,1),1),X_power];
% 
% 
% theta = X_power \ y;
% y_predict = X_power*theta;
% delta_y = y -y_predict;


%plot X with power item
% theta = X \ y;
% y_predict = X*theta;
% delta_y = y -y_predict;
% figure(1);
% a = linspace(-3,3,10);
% b = a;
% hold on;
% plot(a,b);
% plot(y_predict1,y,'r*');
% grid on;
% xlabel('Predicted value');
% ylabel('True value');
% title('X with power item');
% hold off;
