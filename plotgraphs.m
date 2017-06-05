    a = plot(rec,prec,'b-','LineWidth',2);
    xlim([0 1]);
    ylim([0 1]);
    grid;
    xlabel 'recall'
    ylabel 'precision'
    title(sprintf('class: %s, subset: %s, AP = %.3f',cls,VOCopts.testset,ap));
