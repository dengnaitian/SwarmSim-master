clear all;
close all;
no_gp  = readtable('error_no_gp.csv');
with_gp = readtable('error_with_gp.csv');


error_no_gp = table2array(no_gp)';
error_with_gp = table2array(with_gp)';
X = error_no_gp(1,:);
X_confidence = [X,fliplr(X)];

i=2;
Y_no_gp = error_no_gp(i,:);
std_no_gp = error_no_gp(i+4,:);

y_up = Y_no_gp + std_no_gp;
y_dowm = Y_no_gp - std_no_gp;
Y_no_gp_confidence = [y_up, fliplr(y_dowm)];

gp = fill(X_confidence,Y_no_gp_confidence,[26/255 105/255 174/255]);%�����������
gp.FaceAlpha = (0.3);%��������������ɫ      
gp.EdgeColor = 'none';%��������߽�������ɫ���˴�������
hold on

plot(X, Y_no_gp,'--', 'color', [26/255 105/255 174/255], 'linewidth',1);
hold on;

Y_with_gp = error_with_gp(i,:);
std_with_gp = error_with_gp(i+4,:);

y_up = Y_with_gp + std_with_gp;
y_dowm = Y_with_gp - std_with_gp;
Y_with_gp_confidence = [y_up, fliplr(y_dowm)];

wgp = fill(X_confidence,Y_with_gp_confidence,[67/255 161/255 152/255]);%�����������
wgp.FaceAlpha = (0.5);%��������������ɫ      
wgp.EdgeColor = 'none';%��������߽�������ɫ���˴�������
hold on

no_gp_plot =plot(X, Y_with_gp,'--', 'color', [67/255 161/255 152/255], 'linewidth',1);
hold on; 

i=3;
Y_no_gp = error_no_gp(i,:);
std_no_gp = error_no_gp(i+4,:);

y_up = Y_no_gp + std_no_gp;
y_dowm = Y_no_gp - std_no_gp;
Y_no_gp_confidence = [y_up, fliplr(y_dowm)];

gp = fill(X_confidence,Y_no_gp_confidence,[26/255 105/255 174/255]);%�����������
gp.FaceAlpha = (0.3);%��������������ɫ      
gp.EdgeColor = 'none';%��������߽�������ɫ���˴�������
hold on

plot(X, Y_no_gp,'*-', 'color', [26/255 105/255 174/255], 'linewidth',1);
hold on;

Y_with_gp = error_with_gp(i,:);
std_with_gp = error_with_gp(i+4,:);

y_up = Y_with_gp + std_with_gp;
y_dowm = Y_with_gp - std_with_gp;
Y_with_gp_confidence = [y_up, fliplr(y_dowm)];

wgp = fill(X_confidence,Y_with_gp_confidence,[67/255 161/255 152/255]);%�����������
wgp.FaceAlpha = (0.5);%��������������ɫ      
wgp.EdgeColor = 'none';%��������߽�������ɫ���˴�������
hold on

with_gp_plot = plot(X, Y_with_gp,'*-', 'color', [67/255 161/255 152/255], 'linewidth',1);
hold on; 



% for i = 2:3
%     Y_no_gp = error_no_gp(i,:);
%     std_no_gp = error_no_gp(i+4,:);
%     
%     y_up = Y_no_gp + std_no_gp;
%     y_dowm = Y_no_gp - std_no_gp;
%     Y_no_gp_confidence = [y_up, fliplr(y_dowm)];
%     
%     gp = fill(X_confidence,Y_no_gp_confidence,[26/255 105/255 174/255]);%�����������
%     gp.FaceAlpha = (0.3);%��������������ɫ      
%     gp.EdgeColor = 'none';%��������߽�������ɫ���˴�������
%     hold on
%     
%     plot(X, Y_no_gp,'--', 'color', [26/255 105/255 174/255], 'linewidth',1);
%     hold on;
%     
%     Y_with_gp = error_with_gp(i,:);
%     std_with_gp = error_with_gp(i+4,:);
%     
%     y_up = Y_with_gp + std_with_gp;
%     y_dowm = Y_with_gp - std_with_gp;
%     Y_with_gp_confidence = [y_up, fliplr(y_dowm)];
%     
%     gp = fill(X_confidence,Y_with_gp_confidence,[67/255 161/255 152/255]);%�����������
%     gp.FaceAlpha = (0.5);%��������������ɫ      
%     gp.EdgeColor = 'none';%��������߽�������ɫ���˴�������
%     hold on
%     
%     plot(X, Y_with_gp,'--', 'color', [67/255 161/255 152/255], 'linewidth',1);
%     hold on;   
% end
% legend({'no uncertainty','with uncertainty'},'Location','northwest','fontsize',12)
legend([gp wgp no_gp_plot with_gp_plot],{'no gp','with gp','x','y'},'fontsize',12,'NumColumns',2)

