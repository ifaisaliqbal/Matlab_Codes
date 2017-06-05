src = dir(['D:\trainXML\','*.xml']);
it = 1;
for i=it:length(src)
    if (i<10)
        nam = ['00000',sprintf('%i',i),'.xml'];
    elseif i<100
        nam = ['0000',sprintf('%i',i),'.xml'];
    elseif i<1000
        nam = ['000',sprintf('%i',i),'.xml'];
    else
        nam = ['00',sprintf('%i',i),'.xml'];
    end
    if(nam == src(i).name)
        i
    else
        break;
    end
    
end