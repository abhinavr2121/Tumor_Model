close all;
% LOAD DATA
data = load('.././data/cells.mat');
DATA_MAT = cell2mat(struct2cell(data));

% INDEPENDANT CONSTANTS
TIME_INTERVALS = 10 : 2 : 22;
FIGURE_HEIGHT = 900;
FIGURE_WIDTH = 1350;
FIGURE_X = 0;
FIGURE_Y = 0;
X_LABEL = 'Voxel Number in X Direction';
Y_LABEL = 'Voxel Number in Y Direction';
MIN_DATA_VALUE = 0;
MAX_DATA_VALUE = 4e4;
COLOR_BAR_AXIS = [MIN_DATA_VALUE MAX_DATA_VALUE];
COLOR_BAR_FONT_SIZE = 10;
COLOR_BAR_LABEL = 'Tumor Cell Count per Voxel';
N_SUBPLOTS = 16;
N_ROWS = 4;
N_SYMMETRIC = N_ROWS + 2;
N_COLS = 4;
ASPECT_RATIO = FIGURE_WIDTH / FIGURE_HEIGHT;

for i = 7 : -1 : 1 %i = length(TIME_INTERVALS) : -1: 1
    f = figure('Position', [FIGURE_X FIGURE_Y FIGURE_HEIGHT FIGURE_WIDTH]);
    draw_plot(i, DATA_MAT, N_ROWS, N_COLS, COLOR_BAR_AXIS);
    text(-(FIGURE_WIDTH / N_SYMMETRIC), -FIGURE_HEIGHT / ((N_ROWS - 1) * ASPECT_RATIO), ['Time = ', num2str(TIME_INTERVALS(i)), '.0 days. Brain MRI slices along Z-direction, Rat W09. No radiation treatment.'], 'FontSize', 13); 
    xl = xlabel(X_LABEL);
    yl = ylabel(Y_LABEL);
    set(xl, 'Position', [-FIGURE_HEIGHT / (N_SUBPLOTS - ASPECT_RATIO * N_ROWS), FIGURE_HEIGHT / (N_SUBPLOTS - 1)]);
    set(yl, 'Position', [-FIGURE_WIDTH / (N_SYMMETRIC - 1) -FIGURE_HEIGHT / N_SUBPLOTS]);
       
    c = colorbar('Position', [0.93 10 * N_SUBPLOTS / FIGURE_WIDTH N_SUBPLOTS / FIGURE_HEIGHT 0.81]);
    c.Label.String = COLOR_BAR_LABEL;
    c.Label.FontSize = COLOR_BAR_FONT_SIZE;
    caxis(COLOR_BAR_AXIS);
    saveas(f, ['.././results/tumor_plot', num2str(i)], 'png');
end