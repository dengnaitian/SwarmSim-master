bif="1.jpg"
mif="2.jpg"
import pygame,sys,time 
from pygame.locals import *
from sklearn.gaussian_process import GaussianProcessRegressor
from sklearn.gaussian_process.kernels import (RBF, Matern, RationalQuadratic,
                                              ExpSineSquared, DotProduct,
                                              ConstantKernel)
class Control():
	def __init__(self):
		self.x = 320
		self.y = 180
		self.movex = 0.0
		self.movey = 0.0
		self.vRef = 0.6
		self.wRef = 0.0
		self.target_vRef = 0.0
		self.target_wRef = 0.0
		pygame.init()
		self.screen=pygame.display.set_mode((640,360),0,32) 
		self.background=pygame.image.load(bif).convert() 
		self.mouse_c=pygame.image.load(mif).convert_alpha() 
	def control_leader(self):
		while(True):
			for event in pygame.event.get():
			  if event.type ==QUIT: 
			    pygame.quit() 
			    sys.exit() 
			  if event.type==KEYDOWN: 
			    if event.key==K_LEFT: 
			      self.movex=-1
			    if event.key==K_RIGHT: 
			      self.movex=+1
			    elif event.key==K_UP: 
			      self.movey=-1
			    elif event.key==K_DOWN: 
			      self.movey=+1
			  if event.type==KEYUP: 
			    if event.key==K_LEFT: 
			      self.movex=-1
			    if event.key==K_RIGHT: 
			      self.movex=+1
			    elif event.key==K_UP: 
			      self.movey=-1
			    elif event.key==K_DOWN: 
			      self.movey=+1
			  print('x = %f'%(self.x))
			  print('y = %f'%(self.y))
			  self.x+=self.movex 
			  self.y+=self.movey 
			  self.screen.blit(self.background,(0,0)) 
			  self.screen.blit(self.mouse_c,(self.x,self.y))
			  
	def control3(self):
		pygame.time.Clock().tick(100)
		for event in pygame.event.get():
		  if event.type ==QUIT: 
		    # pygame.quit() 
		    sys.exit()  
		if pygame.key.get_pressed()[pygame.K_UP]:
			self.movey=-1
			self.y+=self.movey
			self.vRef += 1

			# print('done_-x%f'%self.y)
		if pygame.key.get_pressed()[pygame.K_DOWN]:
			self.movey=+1
			self.y+=self.movey
			self.vRef -= 1


		keys = pygame.key.get_pressed()
		steer_increment = 0.3
		if keys[K_s]:
			self.movey=+0.1
			self.y += self.movey			
			if self.target_wRef > 0:
				self.target_wRef = 0
			else:
				self.target_wRef = -0.2
		elif keys[K_w]:
			self.movey=-1
			self.y += self.movey	
			if self.target_wRef < 0:
				self.target_wRef = 0
			else:
				self.target_wRef = 0.2
		else:
			self.target_wRef = 0

		if keys[K_d]:
			self.movex=+0.1
			self.x += self.movex			
			if self.target_vRef > 0:
				self.target_vRef = 0
			else:
				self.target_vRef = 0.2
		elif keys[K_a]:
			self.movex=-1
			self.x += self.movex	
			if self.target_vRef < 0:
				self.target_vRef = 0
			else:
				self.target_vRef = -0.2
		else:
			self.target_vRef = 0

		# if keys[K_w] :
		# 	self.movey=-0.1
		# 	self.y+=self.movey			
		# 	self.target_wRef =0.05
		# if keys[K_s] :
		# 	self.movey=+0.1
		# 	self.y+=self.movey			
		# 	self.target_wRef =-0.05

		# if keys[K_d]:
		# 	self.movex=+1
		# 	self.x += self.movex		
		# 	self.target_vRef =0.05

		# if keys[K_a]:
		# 	self.movex=-1
		# 	self.x += self.movex	
		# 	self.target_vRef =-0.05
	
		# if keys[K_w] :
		# 	self.movey=-1
		# 	self.y+=self.movey			
		# 	self.target_vRef +=0.5
		# if keys[K_s] :
		# 	self.movey=+1
		# 	self.y+=self.movey			
		# 	self.target_vRef -=0.5

		# if keys[K_d]:
		# 	self.movex=+1
		# 	self.x += self.movex			
		# 	if self.target_wRef > 0:
		# 		self.target_wRef = 0
		# 	else:
		# 		self.target_wRef -= steer_increment*20
		# elif keys[K_a]:
		# 	self.movex=-1
		# 	self.x += self.movex	
		# 	if self.target_wRef < 0:
		# 		self.target_wRef = 0
		# 	else:
		# 		self.target_wRef += steer_increment*20
		# else:
		# 	if self.target_wRef < 0:
		# 		self.target_wRef += steer_increment
		# 	if self.target_wRef > 0:
		# 		self.target_wRef -= steer_increment


		if keys[K_RIGHT] :
			if self.wRef > 0:
				self.wRef = 0
			else:
				self.wRef -= steer_increment*20
		elif keys[K_LEFT] :
			if self.wRef < 0:
				self.wRef = 0
			else:
				self.wRef += steer_increment*20
		else:
			if self.wRef < 0:
				self.wRef += steer_increment
			if self.wRef > 0:
				self.wRef -= steer_increment	



		self.screen.blit(self.background,(0,0)) 
		self.screen.blit(self.mouse_c,(self.x,self.y))
		self.vRef = min(10, max(0.001, self.vRef))
		self.wRef = min(3.14, max(-3.14, self.wRef))
		self.target_vRef = min(10, max(-10, self.target_vRef))
		# self.target_vRef = min(10, max(0.001, self.target_vRef))
		# self.target_wRef = min(3.14, max(-3.14, self.target_wRef))



	def update(self):
		pygame.display.update()

def main():
    control = Control()
    while(True):
    	control.control_leader()	
    	control.update()
    	print("vRef: %f wRef: %f"%(control.vRef,control.wRef))
if __name__=="__main__":
	main()



