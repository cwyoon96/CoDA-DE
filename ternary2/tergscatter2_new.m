function [hd]=tergscatter2_new(c1,c2,c3,g,symbol,size,alpha,color)
%FUNCTION H=TERNARYC(C1,C2,C3,D,SYMBOL) plots the four data vectors C1,C2,C3, 
% and D color-coded in a ternary plot. The optional parameter SYMBOL
% determines the symbol used in the scatter plot.
% The first three vectors define the position of a data value within the
% ternary diagram, and the fourth vector will be plotted as a coloured
% symbol according to its magnitude. The marker symbol can be optionally
% defined by the marker parameter. If then, note that the marker symbol
% must be enclosed in single quotes (e.g., 'o'). If no symbol is specified
% a dot will be used.
%
% Calling the function with only the first three vectors, i.e.,
%      h=ternaryc(c1,c2,c3);
% results in a standard ternary plot. The data are plotted as a scatter
% plot in a ternary diagram with constant symbols (a blue diamond is the
% default value). To change the symbol (especially when plotting several
% data in one diagram) you can use the set command:
%      set(h,'markerfacecolor','r','marker','+')
%
% The ternary axis system must be created before using the terplot
% function. Axis label can be added using the terlabel function.
% The function returns two handels: hd can be used to modify the data
% points, and hcb is the handle of the colorbar.
%
% See also terplot, tersurf, terlabel, tercontour, and termain for a sample
% program showing the use of the ternary functions.
%
% Example:
%   close all;clear all
%   warning off MATLAB:griddata:DuplicateDataPoints
%   load limestone
%   % (The data file comes with the zip file).
%   figure
%   % Plot the ternary axis system
%   [h,hg,htick]=terplot;
%   % Plot the data
%   % First set the colormap (can't be done afterwards)
%   colormap(jet)
%   [hd,hcb]=ternaryc(A(:,1),A(:,2),A(:,3),A(:,4),'o');
%   %   or
%   [hd]=ternaryc(A(:,1),A(:,2),A(:,3));
%   %   for a constant value ternary plot.
%   % Add the labels
%   hlabels=terlabel('Limestone','Water','Air');
%
% Uli Theune, Geophysics, University of Alberta
% 2002 - 2005
%

% May 2005: added constant data plot option

if max(c1+c2+c3)>1
    c1=c1./(c1+c2+c3);
    c2=c2./(c1+c2+c3);
    c3=c3./(c1+c2+c3);
end

% Plot the points

x=0.5-c1*cos(pi/3) + c2/2;
y=0.866-c1*sin(pi/3)-c2*cot(pi/6)/2;


hd=scatter(x,y,size,g,symbol, 'filled','MarkerFaceAlpha', alpha, 'MarkerFaceColor', color);
axis image

%grid on
%set(get(h,'title'),'string',string,'fontweight','bold')

end
