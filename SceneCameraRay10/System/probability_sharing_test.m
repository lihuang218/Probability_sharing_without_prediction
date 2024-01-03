% 导入轨迹
load trajectory_30-31
load trajectory_30-32
load trajectory_30-33
load trajectory_30-34
load trajectory_30-35
load trajectory_3031
load trajectory_3032
load trajectory_3033
load trajectory_3034
load trajectory_3035
load trajectory_30-3321
mPath1 = p3035;
mPath2 = p3034;
mPath3 = p3033;
mPath4 = p3032;
mPath5 = p3031;
mPath6 = pn3031;
mPath7 = pn3032;
mPath8 = pn3033;
mPath9 = pn3034;
mPath10 = pn3035;
hPath = pn303321;
% 提取每个变量的数据并存储在新的变量中
allPathX= zeros(2001, 10);
allPathY= zeros(2001, 10);
allPathYaw= zeros(2001, 10);
for i = 1:10
    columnName = eval(sprintf('mPath%d', i));
    allPathX(:, i) = columnName(:, 1);
    allPathY(:, i) = columnName(:, 2);
    allPathYaw(:, i) = columnName(:, 3);
end

cPath = zeros(10, 1); % 智能系统每条轨迹的成本
pPath = zeros(10, 1); % 智能系统每条轨迹与驾驶员轨迹之间的差值
c1 = 1; % 平滑成本的系数
c2 = 1; % 参考线成本的系数
c3 = 1; % 障碍物成本的系数
w1 = 1; % 参考线成本一阶导的系数
w2 = 1; % 参考线成本二阶导的系数
w3 = 1; % 参考线成本三阶导的系数
gamma = 1;
for i = 1:10
    dy = diff(allPathYaw(:, i), 1);
    d2y = diff(allPathYaw(:, i), 2);
    d3y = diff(allPathYaw(:, i), 3);
    cSmooth = w1 * sum(dy .^ 2) +w2 * sum(d2y .^ 2) + w3 * sum(d3y .^ 2);
    cRef = sum(allPathY(:, i).^2); % 参考线为0
    % cObs = ; % 障碍物坐标为（90，0）
    % cPath(i, 1) = c1 * cSmooth + c2 * cRef + c3 * cObs;
    cPath(i, 1) = c1 * cSmooth + c2 * cRef;
    pPath(i, 1) = exp(-gamma*sum((hPath(:, 2) - allPathY(:, i)).^2)) * cPath(i, 1);
end
% 计算联合概率
% 联合概率最大的轨迹作为输出轨迹
[maxValue, index] = max(pPath);
path5 = horzcat(allPathX(:, index), allPathY(:, index), allPathYaw(:, index));
