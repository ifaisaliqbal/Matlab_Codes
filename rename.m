srcIMG='E:\Edge based method\match_shape_based_release\test 75\Test\TestMugs';
dstIMG='E:\Edge based method\match_shape_based_release\test 75\Test\new name';
src = dir([srcIMG,'\*.2AS']);

for l=1:length(src)
    copyfile([srcIMG,'\',src(l).name],[dstIMG,'\00',src(l).name]);
end

src = dir([srcIMG,'\*.jpg']);

for l=1:length(src)
    copyfile([srcIMG,'\',src(l).name],[dstIMG,'\00',src(l).name]);
end


src = dir([srcIMG,'\*.mat']);

for l=1:length(src)
    copyfile([srcIMG,'\',src(l).name],[dstIMG,'\00',src(l).name]);
end



src = dir([srcIMG,'\*.segments']);

for l=1:length(src)
    copyfile([srcIMG,'\',src(l).name],[dstIMG,'\00',src(l).name]);
end


src = dir([srcIMG,'\*.tif']);

for l=1:length(src)
    copyfile([srcIMG,'\',src(l).name],[dstIMG,'\00',src(l).name]);
end


src = dir([srcIMG,'\*.groundtruth']);

for l=1:length(src)
    copyfile([srcIMG,'\',src(l).name],[dstIMG,'\00',src(l).name]);
end