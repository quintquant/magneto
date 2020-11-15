% Wrapper function for gen_pic_mat wbhich takes the parameters in a single
% vector (for use with function gen_A in quintquant/jarvis):
%
function pic_mat=gen_pic_mat_wrapped(params)
    N=params(1);
    Gamma=params(2);
    Delta=params(3);
    h=params(4);
    T=params(5);
    q_max=params(6);
    Nk=params(7);
    pic_mat=gen_pic_mat(N,Gamma,Delta,h,T,q_max,Nk);
endfunction
