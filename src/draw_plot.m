function output = draw_plot(n, data_mat, rows, cols, range)
    INDEX = 1;
    for j = 1 : 16
        subplot(rows, cols, j);
        output = imagesc(data_mat(:, :, j, n), range);
        title(['z = ', num2str(j)]);
        if(j == INDEX && j ~= 13)
            INDEX = INDEX + rows;
            set(gca, 'xtick', [], 'ytick', 10 : 10 : 40);
        elseif(j == 13)
            set(gca, 'xtick', 0 : 20 : 60, 'ytick', 10 : 10 : 40);
        elseif(ismember(j, 13 : 16))
            set(gca, 'xtick', 0 : 20 : 60, 'ytick', []);
        else
            set(gca, 'xtick', [], 'ytick', []);
        end
    end
end