%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% FUNCTION: gen_pic_mat
%
%   Calculation of the total diffuse magnetic scattering function S(q)
%   off a planar molecule with N spins having nearest-neighbour anisotropic
%   Heisenberg magnetic interactions at temperature T and in a magnetic
%   field h perpendicular to the plane of the molecule.
%
%   The scattering vector q is assumed to be in the plane of the molecule.
%
% INPUT:
%
%   r_vec   N x 2 matrix giving the positions of all N atoms
%           forming the molecule (the atoms are assumed to be on
%           the xy plane and their positions are given in Cartesian
%           coordinates)
%
%   Gamma   Real number giving the in-plane anisotropy of the spin-spin
%           interactions (for Delta = 0, Gamma=0 is the XY model,
%           Gamma=1 is the Ising model)
%
%   Delta   Real number giving the out-of-plane anisotropy of the
%           spin-spin interactions (for Gamma = 0, Delta = 0 is the XY model,
%           Delta = 1 is the Ising model)
%
%   h       Applied magnetic field, as a real number (field assumed to be
%           in the z direction)
%
%   T       Temperature, as a real number
%
%   Nk      Parameters giving the values taken by the scattering vector
%
%   q_max   q=[qx,qy]. Each component qx,qy takes 2*Nk uniformly-spaced
%           values between -q_max and q_max, inclusive (this automatically
%           avoids q=[0,0], whose corresponding unit vector is not
%           well-defined).
%
% OUTPUT:
%
%   pic_mat Nk x Nk matrix giving the values of the scattering function S(q)
%           at each value of q. Note the values of q are not stored in the
%           matrix - only the values of S(q) are.
%
% USAGE EXAMPLE:
%
%   octave:11> source "functionsHex_v02-JQ.m";
%   octave:12> N=6;Gamma=0.5;Delta=0.0;h=0.0;T=0.1;q_max=2.5*pi;Nk=30;
%   octave:13> pic_mat=gen_pic_mat(gen_r_vec(N),Gamma,Delta,h,T,q_max,Nk);
%   octave:14> save "test_03.dat" pic_mat
%
%   gnuplot> set pm3d; unset surface; set view map; set size ratio 1; unset key;
%   gnuplot> Nk=30;
%   gnuplot> set xtics ("-q_{max}a" 0,"0" (2*Nk-1)/2,"q_{max}a" 2*Nk-1);
%   gnuplot> set ytics ("-q_{max}a" 0,"0" (2*Nk-1)/2,"q_{max}a" 2*Nk-1);
%   gnuplot> set title "(a = distance between n.n. atoms within the molecule)";
%   gnuplot> splot [0:2*Nk-1][0:2*Nk-1] "test_03.dat" matrix
%
function pic_mat=gen_pic_mat(N,Gamma,Delta,h,T,q_max,Nk)
%
    r_vec=gen_r_vec(N);
    N = length(r_vec);
    dk=2*q_max/(2*Nk-1);
    qx=(-q_max:dk:q_max);
    qy=qx;
    sigmaz=[1,0;0,-1];
%
   [states_array,energies_vec]=DiagpbHmat(N,Gamma,Delta,h);
   partZ=Z(T,energies_vec);
%
   SQxx=zeros(length(qx),length(qy));
   SQyy=zeros(length(qx),length(qy));
   SQzz=zeros(length(qx),length(qy));
   SQxy=zeros(length(qx),length(qy));
   SQyx=zeros(length(qx),length(qy));
%
       for delta=1:N
          for deltap=1:N
              thetad=theta(delta,N);
              thetadp=theta(deltap,N);
              sigmax1=sigmaxp(thetad);
              sigmay1=sigmayp(thetad);
              sigmax2=sigmaxp(thetadp);
              sigmay2=sigmayp(thetadp);
              FCorrxx(delta,deltap)=finiteCorr(delta,deltap,sigmax1,sigmax2,N,states_array,energies_vec,T,partZ);
              FCorryy(delta,deltap)=finiteCorr(delta,deltap,sigmay1,sigmay2,N,states_array,energies_vec,T,partZ);
              FCorrzz(delta,deltap)=finiteCorr(delta,deltap,sigmaz,sigmaz,N,states_array,energies_vec,T,partZ);
              FCorrxy(delta,deltap)=finiteCorr(delta,deltap,sigmax1,sigmay2,N,states_array,energies_vec,T,partZ);
              FCorryx(delta,deltap)=finiteCorr(delta,deltap,sigmay1,sigmax2,N,states_array,energies_vec,T,partZ);
         endfor
      endfor
%
   for xx=1:length(qx)
       for yy=1:length(qy)
           Sqxx=0;
           Sqyy=0;
           Sqzz=0;
           Sqxy=0;
           Sqyx=0;
           for delta=1:N
              for deltap=1:N
                  vec=[qx(xx),qy(yy)]*(r_vec(delta,:)-r_vec(deltap,:))';
                  Sqxx=Sqxx+(FCorrxx(delta,deltap))*exp(i*vec);
                  Sqyy=Sqyy+(FCorryy(delta,deltap))*exp(i*vec);
                  Sqzz=Sqzz+(FCorrzz(delta,deltap))*exp(i*vec);
                  Sqxy=Sqxy+(FCorrxy(delta,deltap))*exp(i*vec);
                  Sqyx=Sqyx+(FCorryx(delta,deltap))*exp(i*vec);
                  qxhat=xhat(qx(xx),qy(yy));
                  qyhat=xhat(qy(yy),qx(xx));
                  SQxx(yy,xx)=(1-qxhat^2)*Sqxx;
                  SQyy(yy,xx)=(1-qyhat^2)*Sqyy;
                  SQzz(yy,xx)=Sqzz;
                  SQxy(yy,xx)=-(qxhat*qyhat)*Sqxy;
                  SQyx(yy,xx)=-(qyhat*qxhat)*Sqyx;
              endfor
           endfor
       endfor
   endfor
%
   pic_mat=real(SQxx)+real(SQyy)+real(SQzz)+real(SQxy)+real(SQyx);
%
endfunction
