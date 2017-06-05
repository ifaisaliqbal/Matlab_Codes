info = imaqhwinfo('kinect')
info.DeviceInfo(2);
colorvid = videoinput('kinect',1,'RGB_640x480');
%preview(colorvid)

info.DeviceInfo(2);
depthvid = videoinput('kinect',2,'Depth_640x480');
%preview(depthvid)
depthimage = getsnapshot(depthvid);
colorimage = getsnapshot(colorvid);