srcXML='D:\dataset\testXML 75';
dstXML='D:\dataset\combinedXML';
src = dir([srcXML,'\*.xml']);

for l=1:length(src)
    l1=1200+l;
    copyfile([srcXML,'\',src(l).name],[dstXML,'\00',sprintf('%i',l1),'.xml']);
end