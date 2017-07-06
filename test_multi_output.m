%%multi output [max_shear_angle min_shear_angle]'

clear;
clc;
data = csvread('output.csv');
X =data(:,1:end-1);
y = csvread('max_and_min_shear_angle.csv');

%using only the left or right side spring.
% left_spring =[1:1:8 36:1:43 17:2:35];
% right_spring = [8:1:15 43:1:50 16:2:34];
% X_left =[];
% X_right = [];
% for j =1:numel(left_spring)
%     index = left_spring(j);
%     X_left = [X_left,X(:,index)];
% end
% for h =1:numel(right_spring)
%     index = right_spring(h);
%     X_right = [X_right,X(:,index)];
% end

%add square item for X
X_square= X;
for i=1:size(X,2)
    X_square = [X_square,X(:,i).^2];
end
% %add square item for X_left
% X_left_square = X_left;
% for k=1:size(X_left_square,2)
%     X_left_square = [X_left_square,X_left_square(:,k).^2];
%     %X_left = [X_left,X_left(:,i).*X_left(:,i+1)];
% end

%add power item for X
X_square1 = X_square;
for j=1:size(X,2)
    X_square1 = [X_square1,X(:,j).^0.5];
end
power = 5;
X_power = X_square1;
for m = 1:size(X,2)
    for m1 = 3:power
        X_power = [X_power,X(:,m).^m1,X(:,m).^(1/m1)];
    end
end
% %add power item for X_left
% power1 = 6;
% X_left_power = X_left_square;
% for p = 1:size(X_left,2)
%     for p1 = 3:power1
%         X_left_power = [X_left_power,X_left(:,p).^p1,X_left(:,p).^(1/p1),X_left(:,p).^0.5];
%     end
% end

%add c_0=[1...1]' als first column
X = [ones(size(X,1),1),X];
X_square = [ones(size(X_square,1),1),X_square];
% X_left = [ones(size(X_left,1),1), X_left];
% X_left_square = [ones(size(X_left_square,1),1),X_left_square];
X_power = [ones(size(X_power,1),1),X_power];
% X_left_power = [ones(size(X_left_power,1),1),X_left_power];
%=================================================================================
%X 50 feature
%delta =inv(X'*X)*X'*y;
%pinv(X*y);
theta = X \ y;
y_predict = X*theta;
delta_y = y -y_predict;

%plot all the predicted and true value both maximum and minimum.
%it is hard to differentiate.
figure(1);
hold on;
plot(1:586,y,'r.');
plot(1:586,y_predict,'.');
legend('True value','Predicted value');
xlabel('Modell');
ylabel('Shear angle value');
hold off;

%this below show better than 1st figure..
figure(2);
hold on;
plot(1:586,y(:,1),'r.');%true maximum value
plot(1:586,y_predict(:,1),'bo');%predicted maximum value
plot(1:586,y(:,2),'b.');%true minumum value
plot(1:586,y_predict(:,2),'ro');%predicted minimum value
legend('True maximum value','Predicted maximum value','True minimum value','Predicted minimum value');
xlabel('Model');
ylabel('Shear angle value');
hold off;

figure(3);
a = linspace(-2,2,10);
b = a;
hold on;
plot(a,b);
plot(y_predict(:,1),y(:,1),'r*');
plot(y_predict(:,2),y(:,2),'b*');
legend('True value = Predicted value','Maximum value point','Minimum value point');
grid on;
xlabel('Predicted value');
ylabel('True value');   
hold off;
% 
figure(4);
y_error = abs(delta_y);
hold on;
plot(1:586,y_error,'.');
legend('Maximum value point','Minimum value point');
grid on;
xlabel('Modell');
ylabel('Absolute error');
hold off;
%===============================================================================================
%===============================================================================================
%X with square items
theta_square = X_square \ y;
y_predict_square = X_square*theta_square;
delta_y_square = y -y_predict_square;

figure(5);
a = linspace(-2,2,10);
b = a;
hold on;
plot(a,b);
plot(y_predict_square(:,1),y(:,1),'r*');
plot(y_predict_square(:,2),y(:,2),'b*');
legend('True value = Predicted value','Maximum value point','Minimum value point');
grid on;
xlabel('Predicted value');
ylabel('True value');   
title('With square items');
hold off;

figure(6);
y_error_square = abs(delta_y_square);
hold on;
plot(1:586,y_error_square,'.');
legend('Maximum value point','Minimum value point');
grid on;
xlabel('Modell');
ylabel('Absolute error');
title('With square items');
hold off;
%==========================================================================
%X with power item
theta_power = X_power \ y;
y_predict_power = X_power*theta_power;
delta_y_power = y -y_predict_power;

figure(7);
a = linspace(-2,2,10);
b = a;
hold on;
plot(a,b);
plot(y_predict_power(:,1),y(:,1),'r*');
plot(y_predict_power(:,2),y(:,2),'b*');
legend('True value = Predicted value','Maximum value point','Minimum value point');
grid on;
xlabel('Predicted value');
ylabel('True value');   
title('With power items');
hold off;

figure(8);
y_error_power = abs(delta_y_power);
hold on;
plot(1:586,y_error_power,'.');
legend('Maximum value point','Minimum value point');
grid on;
xlabel('Modell');
ylabel('Absolute error');
title('With power items');
hold off;

figure(9);
hold on;
plot(1:586,y(:,1),'r.');%true maximum value
plot(1:586,y_predict_power(:,1),'bo');%predicted maximum value
plot(1:586,y(:,2),'b.');%true minumum value
plot(1:586,y_predict_power(:,2),'ro');%predicted minimum value
legend('True maximum value','Predicted maximum value','True minimum value','Predicted minimum value');
xlabel('Model');
ylabel('Shear angle value');
title('With power items');
hold off;



%==========================================================================
%plot with x square
% theta1 = X_square \ y;
% y_predict1 = X_square*theta1;
% delta_y1 = y -y_predict1;
% figure(4);
% a = linspace(-3,3,10);
% b = a;
% hold on;
% plot(a,b);
% plot(y_predict1,y,'r*');
% grid on;
% xlabel('Predicted value');
% ylabel('True value');
% title('X with square item');
% hold off;

%plot x_left
% theta2 = X_left \ y;
% y_predict2 = X_left*theta2;
% delta_y2 = y -y_predict2;
% figure(5);
% a = linspace(-3,3,10);
% b = a;
% hold on;
% plot(a,b);
% plot(y_predict2,y,'r*');
% grid on;
% xlabel('Predicted value');
% ylabel('True value');
% title('left side');
% hold off;

%plot X_left with square
% theta3 = X_left_square \ y;
% y_predict3 = X_left_square*theta3;
% delta_y3 = y -y_predict3;
% figure(6);
% a = linspace(-3,3,10);
% b = a;
% hold on;
% plot(a,b);
% plot(y_predict3,y,'r*');
% grid on;
% xlabel('Predicted value');
% ylabel('True value');
% title('left side with square item');
% hold off;

%plot X with power item
% theta4 = X_power \ y;
% y_predict4 = X_power*theta4;
% delta_y4 = y -y_predict4;
% figure(7);
% a = linspace(-3,3,10);
% b = a;
% hold on;
% plot(a,b);
% plot(y_predict4,y,'r*');
% grid on;
% xlabel('Predicted value');
% ylabel('True value');
% title('X with power item');
% hold off;

%plot X_left with power item
% theta5 = X_left_power \ y;
% y_predict5 = X_left_power*theta5;
% delta_y5 = y -y_predict5;
% figure(8);
% a = linspace(-3,3,10);
% b = a;
% hold on;
% plot(a,b);
% plot(y_predict5,y,'r*');
% grid on;
% xlabel('Predicted value');
% ylabel('True value');
% title('left side with power item');
% hold off;

% figure(9);
% hold on;
% plot(1:586,y,'r.');
% plot(1:586,y_predict4,'.');
% legend('True value','Prediction');
% xlabel('Modell');
% ylabel('Shear angle value');
% hold off;
% 
% figure(10);
% y_error1 = abs(y - y_predict4);
% hold on;
% plot(1:586,y_error1,'.');
% grid on;
% xlabel('Modell');
% ylabel('Absolute error');
% hold off;