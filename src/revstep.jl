# Begin revstep

#=
MATLAB IMPLEMENTATION
function symbabintwo(h,tmax)
global GNEWT CASE MSCRIPT YEAR
% Good parameters: h=0.01, t=100 yrs
% Bulirsch--Stoer section did a part on centering of mass-- check
CASE = 1; %Mercurius is always WHD
% GNEWT = 39.4845;
GNEWT = 0.00029591220823221284; %gaussian
% YEAR = 365.25;
YEAR = 1;
MSCRIPT = 2; %WH choice is 1, RT is otherwise for WHJ
% Chambers choices

str = sprintf("data/fcons.txt");
fcons = fopen(str,'w');
t = 0;
[m,x,v] = in3boddunctwo(); %Period ~0.044 yrs
[Psum0] = calcm(v,m);
[Q,junk] = convertcart(m,x,v);
h0 = h;
dE = 0;

[rlev,hlev,steps,hsub] = initv(h);
[levc,vfunc] = calclevv(Q,v,m,rlev,h);
[E0,L0] = consqv(m,Q,v);   
nstep = 0;
[a1,em1] = calcorb(Q,v,m,2,3);
[a2,em2] = calcorb(Q,v,m,4,5);
% Fixing print statements next 11/28/23
fprintf(fcons,['%0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g\n'], ...
    t,E0,a1,a2,em1,em2,levc(2,3),levc(2,4),levc(2,5),levc(3,4),levc(3,5),levc(4,5),0);
t1 = cputime;
inc=0;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while(t < tmax)
    t/tmax
    nstep = nstep+1;
%     [Q,v] = mapv(Q,v,h,m);
%     [Q,v,levco] = SyMBAand(Q,v,m,levco,rlev,hlev,steps);
%     [Q,v,levc] = SyMBAsmooth(Q,v,m,rlev,hlev,hsub,levmax);
%     [Q,v,levc] = SyMBAsmoothfull(Q,v,m,rlev,hlev,hsub,rhill0);
%     [Q,v,levc,f1,vfunc,finc] = SyMBAdiscrete(Q,v,m,rlev,hlev,hsub,levc);
%     [Q,v,levc,loop] = globalstep(Q,v,m,hsub,levc,1,rlev,hlev);
    [Q,v,levc,loop] = globalstepirr(Q,v,m,hsub,levc,1,rlev,hlev);
%     levc
    t = t+h;
    [E,L] = consqv(m,Q,v);
    dE = (E - E0)/E0;
%     dE
%     blergh
    [a1,em1] = calcorb(Q,v,m,2,3);
    [a2,em2] = calcorb(Q,v,m,4,5);

fprintf(fcons,['%0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g %0.16g\n'], ...
    t,E,a1,a2,em1,em2,levc(2,3),levc(2,4),levc(2,5),levc(3,4),levc(3,5),levc(4,5),loop);

end
t2 = cputime;
dt = t2-t1;
dE = (E - E0)/E0;
dL = (L - L0)./L0;
dL(3)
dE
dt
fclose('all');



end

=#

function symbabintwo()
    gnewt = 0.00029591220823221284
    year = 1
    mscript = 2

    fcons = open("data/fcons.txt", "w")
    t = 0
    m, x, v = in3boddunctwo()
    psum0 = calcm(v, m)
    q, junk = convertcart(m, x, v)
    h0 = 0.01
    dE = 0

    rlev, hlev, steps, hsub = initv(h0)
    levc, vfunc = calclevv(q, v, m, rlev, h0)
    e0, l0 = consqv(m, q, v)
    nstep = 0
    a1, em1 = calcorb(q, v, m, 2, 3)
    a2, em2 = calcorb(q, v, m, 4, 5)

    println(fcons, "$t $e0 $a1 $a2 $em1 $em2 $levc[2,3] $levc[2,4] $levc[2,5] $levc[3,4] $levc[3,5] $levc[4,5] 0")

end