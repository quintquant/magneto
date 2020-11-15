% FUNCTION: gsCorr
%           Evaluates the correlators in pair for a given temperature T. calls in pureCorr.
% INPUT:... delta   Positive Integer. Position i
%           deltap  Positive Integer. Position j
%           sigma_1 and sigma_2 pauli matrices. what type of correlator do you want? xx, xy etc
%           N       Positive Integer. size of Finite system.
%           state   Vector (2**N) the groundstate
% OUTPUT:...gsCorrelator. Groundstate correlator value for pair of delta deltap.
function gsCorrelator=gsCorr(delta,deltap,sigma_1,sigma_2,N,state)
   correlatorPair=corrPair(delta,deltap,sigma_1,sigma_2,N);
   gsCorrelator=(conj(state'))*(correlatorPair*state);
end
