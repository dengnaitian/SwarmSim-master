function data = read_data()
% data_list = {'D:\robInfLib-matlab-master\data7\data_record_0903110030.csv','D:\robInfLib-matlab-master\data7\data_record_0903110138.csv','D:\robInfLib-matlab-master\data7\data_record_0903110212.csv','D:\robInfLib-matlab-master\data7\data_record_0903110246.csv','D:\robInfLib-matlab-master\data7\data_record_0903110323.csv'}

m = csvread('D:\robInfLib-matlab-master\data7\data_record_0903110030.csv', 80,1);
m = m(1:800,1:5);
Data(1:800,:) = m;
m = csvread('D:\robInfLib-matlab-master\data7\data_record_0903110138.csv', 80,1);
m = m(1:800,1:5);
Data(801:1600,:) = m;
m = csvread('D:\robInfLib-matlab-master\data7\data_record_0903110212.csv', 80,1);
m = m(1:800,1:5);
Data(1601:2400,:) = m;
m = csvread('D:\robInfLib-matlab-master\data7\data_record_0903110246.csv', 80,1);
m = m(1:800,1:5);
Data(2401:3200,:) = m;
m = csvread('D:\robInfLib-matlab-master\data7\data_record_0903110323.csv', 80,1);
m = m(1:800,1:5);
Data(3201:4000,:) = m;
data = Data';



