%%%%%%%%%%%
% FUNCTION: Z
%           Evaluates the Partition Function for a given set of eigen values.
% INPUT:... T               Positive number. Temperature as a fraction of J.
%           energies_array  vector 2^N.      Eigenvalues of the system.
% OUTPUT:...partitionFunction Positive number.
%
function partitionFunction=Z(T,energies_array)
   [x,y] = size (energies_array);
   partitionFunction = 0;
    for ii=1:x
      partitionFunction = partitionFunction + exp(-(energies_array(ii)/T));
    endfor
end
