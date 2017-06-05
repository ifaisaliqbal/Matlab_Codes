th = 1;
val = sc(1);
for x = 1: size(sc,1)-1
if(abs(val-sc(x+1))>th)
val = sc(x+1);
end
store(x) = val;
end
store = store';
sore(1:size(sc,1))=0;
store1(1:size(sc,1))=0;
store1(2:end)=store(1:end);
store1=store1';
store1(1) = 805.1;
diff = sc-store1;
diff = abs(diff);
pdiff = diff./sc;
pdiff = pdiff*100;