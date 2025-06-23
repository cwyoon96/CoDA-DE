function handles = terlabel3_new(label1, label2, label3, fontSize)
%FUNCTION HANDLES = TERLABEL(LABEL1, LABEL2, LABEL3) adds labels to a ternary 
% plot. Note that the order of labels must be the same as in the vectors in
% the ternaryc function call.
% The labels can be modified through the handle vector HANDLES.
%
% Uli Theune, Geophysics, University of Alberta
% 2005
%

if nargin < 4
    fontSize = 12; % Default font size if not provided
end

if nargout >= 1
    handles = ones(3, 1);
    handles(1) = text(0.5, -0.07, label2, 'HorizontalAlignment', 'center', 'FontSize', fontSize); % Adjusted y-coordinate for 'Protain'
    handles(2) = text(0.15, sqrt(3)/4 + 0.05, label1, 'HorizontalAlignment', 'center', 'Rotation', 60, 'FontSize', fontSize);
    handles(3) = text(0.85, sqrt(3)/4 + 0.05, label3, 'HorizontalAlignment', 'center', 'Rotation', -60, 'FontSize', fontSize);
else
    text(0.5, -0.07, label2, 'HorizontalAlignment', 'center', 'FontSize', fontSize); % Adjusted y-coordinate for 'Protain'
    text(0.15, sqrt(3)/4 + 0.05, label1, 'HorizontalAlignment', 'center', 'Rotation', 60, 'FontSize', fontSize);
    text(0.85, sqrt(3)/4 + 0.05, label3, 'HorizontalAlignment', 'center', 'Rotation', -60, 'FontSize', fontSize);
end