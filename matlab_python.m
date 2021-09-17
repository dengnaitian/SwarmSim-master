clear classes
mod = py.importlib.import_module('myfun');
py.importlib.reload(mod);
pycontrol = py.myfun.Control;
for i = 1:10
    pycontrol.control3();
    pycontrol.update();
    w = pycontrol.wRef
    v = pycontrol.vRef
end
py.pygame.quit()
% 
% % 
% clear classes
% mod = py.importlib.import_module('gpr');
% py.importlib.reload(mod);
% my_gpr = py.gpr.gpr;
% my_gpr.fit()
% predict_input = [[0.9  , 8.443, 9.243, 5.67 , 9.197 ]]
% result = double(my_gpr.prediction(predict_input))

