from __future__ import division
import numpy as np
import os
import pandas as pd
from matplotlib import pyplot as plt
import scipy.io as scio
from sklearn.gaussian_process import GaussianProcessRegressor
from sklearn.gaussian_process.kernels import (RBF, Matern, RationalQuadratic,
                                              ExpSineSquared, DotProduct,
                                              ConstantKernel)
class gpr():
	def __init__(self):
		kernel = 1.0 * Matern(length_scale=1.0, length_scale_bounds=(1e-1, 10.0),nu=1.5)
		self.gp = GaussianProcessRegressor(kernel=kernel)
	def load_data(self):
		# path = ["demo1.mat","demo2.mat","demo3.mat","demo4.mat","demo5.mat"]
		# path = ["demo1.mat","demo2.mat","demo3.mat","demo4.mat","demo5.mat",
		# 		"demo6.mat","demo7.mat","demo8.mat","demo9.mat","demo10.mat"]
		path = ["demo11.mat","demo12.mat","demo13.mat","demo14.mat","demo15.mat",
				"demo16.mat","demo17.mat","demo18.mat","demo19.mat","demo20.mat"]				
		demo = np.zeros([1,8])
		for  i in  range(len(path)):
		    data_path= path[i]
		    data = scio.loadmat(data_path)
		    demo1 = data.get('input_data')
		    demo = np.concatenate((demo,demo1.T),axis=0)
		demo = demo[1:,:]
		return demo
	def fit(self):
		print("begin gpr fit...")
		data = self.load_data()
		X = data[:,0:5]
		Y = data[:,5:8]
		self.gp.fit(X,Y)
		print("finish gpr_model_fit")
	def prediction(self,X_):
		predict_input = np.array(X_)

		y_mean = self.gp.predict( predict_input.reshape([1,predict_input.size]) ,return_std=False)
		return y_mean
 
	
def main():
    my_gpr = gpr() 
    my_gpr.fit()
    predict_input = [[0.9  , 8.443, 9.243, 5.67 , 9.197 ]]
    result = my_gpr.prediction(predict_input)
    print(result)
if __name__=="__main__":
	main()




