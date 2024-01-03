本代码属于基础程序，不包含预测程序。驾驶员的轨迹和智能系统的多条轨迹提前生成并存入代码中。
可用于纯仿真实验，驾驶员在环需要进一步考虑。


SCRReferenceApplication用于生成驾驶员驾驶yaw
SCRReferenceApplication_machine用于仿真人机共驾联合概率方法，得到人机共驾后的驾驶轨迹和yaw

其中，probability_path_MPC_Controller_dynamic.m修改为casadi优化求解，但没有约束。

程序运行前添加casadi的路径，在命令行中输入addpath('F:\casadi\casadi-3.6.4-windows64-matlab2018b')