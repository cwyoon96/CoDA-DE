function [hg, htick] = tersurf2_new(c1, c2, c3, d)
%FUNCTION [HG,HTICK,HCB]=TERSURF(C1,C2,C3,D) plots the values in the vector d 
% as a pseudo color plot in a ternary diagram.
% The three vectors c1,c2,c3 define the position of a data value within the
% ternary diagram.
% The ternary axis system is created within the function.
% Axis label can be added using the terlabel function.
% The function returns three handles: hg can be used to modify the grid lines,
% htick must be used to access the tick label properties, and hcb is the handle
% for the colorbar.
%
% Uli Theune, Geophysics, University of Alberta
% 2002 - ...
%

%{
ternary plot의 축에 표시된 숫자의 방향을 반대로 바꾸려면, htick 텍스트 객체의 위치와 값을 조정하면 됩니다. 
아래의 코드는 기존의 htick 텍스트 객체 생성 부분을 수정하여 축의 숫자가 반대로 표시되도록 합니다.

이 코드는 각 축의 숫자가 반대로 표시되도록 텍스트 객체의 값을 1 - l(i)로 변경합니다.
 text 함수 호출 시 각 숫자의 위치는 그대로 두되, 값만 반대로 바꿔줍니다.
%}

if nargin < 4
    error('Error: Not enough input arguments.');
    return
end
if (length(c1) + length(c2) + length(c3)) / length(c1) ~= 3
    error('Error: all arrays must be of equal length.');
    return
end

% Check if the data need to be normalized
if max(c1 + c2 + c3) > 1
    for i = 1:length(c1)
        c1(i) = c1(i) / (c1(i) + c2(i) + c3(i));
        c2(i) = c2(i) / (c1(i) + c2(i) + c3(i));
        c3(i) = c3(i) / (c1(i) + c2(i) + c3(i));
    end
end

hold on
% Calculate the position of the data points in the ternary diagram
x = 0.5 - c1 * cos(pi/3) + c2 / 2;
y = 0.866 - c1 * sin(pi/3) - c2 * cot(pi/6) / 2;

% Create short vectors for the gridding
tri = delaunay(x, y);
trisurf(tri, x, y, d);
shading interp

% Add the axis system now
d1 = cos(pi/3);
d2 = sin(pi/3);
l = linspace(0, 1, 6);
zmax = max(d);
for i = 2:length(l) - 1
    hg(i-1, 3) = plot3([l(i)*d1 1-l(i)*d1], [l(i)*d2 l(i)*d2], [zmax zmax]*1.1, ':k', 'linewidth', 0.25);
    hg(i-1, 1) = plot3([l(i) l(i)+(1-l(i))*d1], [0 (1-l(i))*d2], [zmax zmax]*1.1, ':k', 'linewidth', 0.25);
    hg(i-1, 2) = plot3([(1-l(i))*d1 1-l(i)], [(1-l(i))*d2 0], [zmax zmax]*1.1, ':k', 'linewidth', 0.25);
end
plot([0 1 0.5 0], [0 0 sqrt(3)/2 0], 'k', 'linewidth', 1)

% Make x-tick labels
for i = 1:length(l)
    htick(i, 1) = text(l(i), -0.025, num2str(1 - l(i))); % 수정된 부분
    htick(i, 3) = text(1 - l(i) * cos(pi/3) + 0.025, l(i) * sin(pi/3) + 0.025, num2str(1 - l(i))); % 수정된 부분
    htick(i, 2) = text(0.5 - l(i) * cos(pi/3) - 0.06, sin(pi/3) * (1 - l(i)), num2str(1 - l(i))); % 수정된 부분
end

hold off
axis image
axis off
caxis([min(d) max(d)])
view(2)