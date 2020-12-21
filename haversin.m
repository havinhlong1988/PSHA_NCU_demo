function d=haversin(lat0,long0,lat1,long1)
% Calculate distance betwen 2 point of lattitude and longitude
R = 6371 ;% Earth radius in km
% Convert to radian
phi1 = deg2rad(lat0); phi2 = deg2rad(lat1);
deltaphi = deg2rad(lat1-lat0);
deltatheta = deg2rad(long1 - long0);
% Calculate other parameter
a = (sin(deltaphi/2)^2)+(cos(phi1)*cos(phi2)*(sin(deltatheta/2)^2));
c = 2*atan2(sqrt(a),sqrt(1-a));
d = R * c;
end