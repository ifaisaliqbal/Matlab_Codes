srcIMG='E:\Edge based method\match_shape_based_release\test 25\Test\TestMugs';
dstIMG='E:\Edge based method\match_shape_based_release\test 25\Test\new name';
src = dir([srcIMG,'\*.2AS']);

for l=1:length(src)
    copyfile([srcIMG,'\',src(l).name],[dstIMG,'\00',sprintf('%i',l1),'.jpg']);
end