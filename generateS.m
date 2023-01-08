function [Sx,Sy,Sz] = generateS()
    Sx = [0,1;1,0]/2;
    Sy = [0,-1i;1i,0]/2;
    Sz = [1,0;0,-1]/2;
    
    Sx = [0,1;1,0];
    Sy = [0,-1i;1i,0];
    Sz = [1,0;0,-1];
end