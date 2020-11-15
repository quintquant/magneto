%%%%%%%%%%
% FUNCTION: corrPair
%           Constructs a realspace correlator operator for a given pair in a finite system.
%           To be called in by pureCorrPoint
% INPUT:... delta   Positive Integer. Position i
%           deltap  Positive Integer. Position j
%           sigma_1 and sigma_2 pauli matrices. what type of correlator do you want? xx, xy etc
%           N       Positive Integer. size of Finite system.
% OUTPUT... correlatorPair   matrix (2^N,2^N) for a set correlation between i and j sites.
%
function correlatorPair=corrPair(delta,deltap,sigma_1,sigma_2,N)
  corr_1=zeros((2^N),(2^N));   % initiate
  corr_2=zeros((2^N),(2^N));
  corr_1(:,:)=kron(eye(2^(delta-1),2^(delta-1)),(kron(0.5*sigma_1,eye(2^(N-delta),2^(N-delta)))));        % position i
  corr_2(:,:)=kron(eye(2^(deltap-1),2^(deltap-1)),(kron(0.5*sigma_2,eye(2^(N-deltap),2^(N-deltap)))));       % position j
  correlatorPair(:,:)=corr_1(:,:)*corr_2(:,:);
end
