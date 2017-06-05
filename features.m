function feat=features (im, sbin)
% #include <math.h>
% #include "mex.h"
% 
% // small value, used to avoid division by zero
eps = 0.0001;
%// unit vectors used to compute gradient orientation
uu = [1.0000 0.9397	0.7660 0.500 0.1736	-0.1736	-0.5000	-0.7660	-0.9397];
vv = [0.0000 0.3420	0.6428 0.8660 0.9848 0.9848	0.8660 0.6428 0.3420];
dims = size(im);

  if (length(dims) ~= 3 || dims(3) ~= 3 ||  ~isa(im,'double'))
    disp('Invalid input');
  end
  
  blocks(1) = round(dims(1)/sbin);
  blocks(2) = round(dims(2)/sbin);
  histg(blocks(1)*blocks(2)*18+3000)=0;
  normm(blocks(1)*blocks(2))=0;
  double(normm);
  double(histg);
  out(1) = max(blocks(1)-2, 0);
  out(2) = max(blocks(2)-2, 0);
  out(3) = 27+4;
  feat(out(1)*out(2))=0;
  double(feat);
  feat = reshape(feat,out(1),out(2));
  feat = cat(3,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat,feat);
  visible(1) = blocks(1)*sbin;
  visible(2) = blocks(2)*sbin;
  
  for x = 1: visible(2)-2
    for y = 1: visible(1)-2 
      %// first color channel
      
      s = (min(x, dims(2)-2)*dims(1) + min(y, dims(1)-2));
      double(s);
      dy = (im(s+1)) - (im(s-1));
      double(dy);
      dx = (im(s+dims(1))) - (im(s-dims(1)));
      double(dx);
      v = dx*dx + dy*dy;
      double(v);
      %// second color channel
      s =s+ dims(1)*dims(2);
      dy2 = (im(s+1)) - (im(s-1));
      double(dy2);
      dx2 = (im(s+dims(1))) -(im(s-dims(1)));
      double(dx2);
      v2 = dx2*dx2 + dy2*dy2;
      double(v2);

      %// third color channel
      s =s+ dims(1)*dims(2);
      dy3 = (im(s+1)) - (im(s-1));
      double(dy3);
      dx3 = (im(s+dims(1))) - (im(s-dims(1)));
      double(dx3);
      v3 = dx3*dx3 + dy3*dy3;
      double(v3);
      %// pick channel with strongest gradient
      if v2 > v
        v = v2;
        dx = dx2;
        dy = dy2;
      end
      
      if v3 > v
        v = v3;
        dx = dx3;
        dy = dy3;
      end
      
      %// snap to one of 18 orientations
      best_dot = 0;
      double(best_dot);
      best_o = 0;
      for o = 1:9
        dot = uu(o)*dx + vv(o)*dy;
        if dot > best_dot
            best_dot = dot;
            best_o = o-1;
        elseif -dot > best_dot
            best_dot = -dot;
            best_o = o+8;
        end
      end
	
      
      
      %// add to 4 histograms around pixel using linear interpolation
      xp = (x+0.5)/sbin - 0.5;
      yp = (y+0.5)/sbin - 0.5;
      ixp = floor(xp);
      iyp = floor(yp);
      vx0 = xp-ixp;
      vy0 = yp-iyp;
      vx1 = 1.0-vx0;
      vy1 = 1.0-vy0;
      v = sqrt(double(v));
      dbstop if error       
      if (ixp >= 0 && iyp >= 0) 
	histg(ixp*blocks(1) + iyp + best_o*blocks(1)*blocks(2)+1) = histg(ixp*blocks(1) + iyp + best_o*blocks(1)*blocks(2)+1) + vx1*vy1*v;
      end

      if (ixp+1 < blocks(2) && iyp >= 0) 
	histg((ixp+1)*blocks(1) + iyp + best_o*blocks(1)*blocks(2)+1) = histg((ixp+1)*blocks(1) + iyp + best_o*blocks(1)*blocks(2)+1)+ vx0*vy1*v;
      end

      if (ixp >= 0 && iyp+1 < blocks(1)) 
	histg(ixp*blocks(1) + (iyp+1) + best_o*blocks(1)*blocks(2)+1) = histg(ixp*blocks(1) + (iyp+1) + best_o*blocks(1)*blocks(2)+1)+vx1*vy0*v;
      end

      if (ixp+1 < blocks(2) && iyp+1 < blocks(1)) 
	histg((ixp+1)*blocks(1) + (iyp+1) + best_o*blocks(1)*blocks(2)+1) = histg((ixp+1)*blocks(1) + (iyp+1) + best_o*blocks(1)*blocks(2)+1)+ vx0*vy0*v;
      end
      
    end
  end
    for o=1:9
    src1 = ((o-1)*blocks(1)*blocks(2));
    src2 = ((o+8)*blocks(1)*blocks(2));%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dst = 1;
    endd = blocks(2)*blocks(1);
    while (dst < endd)
      normm(dst)= (histg(src1+1)+ histg(src2+1)) * (histg(src1+1)+ histg(src2+1));
      dst = dst+1;
      src1=src1+1;
      src2=src2+1;
    end
    end
    
    for x = 1:out(2)-1
    for y = 1:out(1)-1
      dst = (x-1)*out(1) + y;

      p = (x-1+1)*blocks(1) + y+1+1;
      n1 = 1.0 / sqrt(normm(p) + normm(p+1) + normm(p+blocks(1)) + normm(p+blocks(1)+1) + eps);
      p = (x-1+1)*blocks(1) + y+1;
      n2 = 1.0 / sqrt(normm(p) + normm(p+1) + normm(p+blocks(1)) + normm(p+blocks(1)+1) + eps);
      p = (x-1)*blocks(1) + y+1+1;
      n3 = 1.0 / sqrt(normm(p) + normm(p+1) + normm(p+blocks(1)) + normm(p+blocks(1)+1) + eps);
      p = (x-1)*blocks(1) + y+1;      
      n4 = 1.0 / sqrt(normm(p) + normm(p+1) + normm(p+blocks(1)) + normm(p+blocks(1)+1) + eps);

      t1 = 0;
      t2 = 0;
      t3 = 0;
      t4 = 0;

      %// contrast-sensitive features
      src = (x-1+1)*blocks(1) + (y+1);
      for o = 1:18
        h1 = min(histg(src) * n1, 0.2);
        h2 = min(histg(src) * n2, 0.2);
        h3 = min(histg(src) * n3, 0.2);
        h4 = min(histg(src) * n4, 0.2);
        feat(dst) = 0.5 * (h1 + h2 + h3 + h4);
        t1 =t1+ h1;
        t2 = t2+h2;
        t3 = t3+h3;
        t4 =t4+ h4;
        dst =dst + out(1)*out(2);
        src =src+ blocks(1)*blocks(2);
      end

      %// contrast-insensitive features
      src = (x-1+1)*blocks(1) + (y+1);
      for o = 1:9
        sum = histg(src) + histg(src + 9*blocks(1)*blocks(2));
        h1 = min(sum * n1, 0.2);
        h2 = min(sum * n2, 0.2);
        h3 = min(sum * n3, 0.2);
        h4 = min(sum * n4, 0.2);
        feat(dst) = 0.5 * (h1 + h2 + h3 + h4);
        dst =dst+ out(1)*out(2);
        src =src+ blocks(1)*blocks(2);
      end

      %// texture features
      feat(dst) = 0.2357 * t1;
      dst =dst+ out(1)*out(2);
      feat(dst) = 0.2357 * t2;
      dst =dst+ out(1)*out(2);
      feat(dst) = 0.2357 * t3;
      dst =dst+ out(1)*out(2);
      feat(dst) = 0.2357 * t4;
     
    end
    end
    
  
    
  
