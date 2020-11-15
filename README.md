# magneto

Octave functions to simulate diffuse magnetic neutron scattering from single-molecule magnets.

The original version of this software was written by Hannah Irons as part of the PhD work under the supervision of Jorge Quintanilla. This was part of a collaboration with Luigi Amico, Toby Perring and Gabriel Aeppli. Further development was carried out by Jorge Quintanilla as part of a subsequent collaboration with Stuart Gibson and Robert Twyman.

You can cite this code using the following DOI:

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4267893.svg)](https://doi.org/10.5281/zenodo.4267893)

The model and method the code implements are described in

> Hannah R. Irons, Jorge Quintanilla, Toby G. Perring, Luigi Amico, and Gabriel Aeppli,
"Control of entanglement transitions in quantum spin clusters",
Phys. Rev. B 96, 224408 (2017). DOI:10.1103/PhysRevB.96.224408 (full text is freely available from the Kent Academic Repository at https://kar.kent.ac.uk/61595/).

Please cite the above work too if you use this software. Thank you!

For licensing information, see COPYING.

## Requirements

A working installation of Octave (the software has been tested on Octave 3.4.3; the source code has comments explaining how it can be adapted for use on Matlab).

## Installation

Copy the .m files to your working directory.

## Usage

cd to your working directory.

Start Octave.

The new Octave functions will be available (their names are the same as the corresponding filenames, without the ".m").

The usage of each of the functions is documented in comments within its source code.

### Example

Let us use the functions in this package to create the magnetic diffuse neutron scattering function of our model for the case where there are `N=2` atoms in the mangetic cluster (magnetic dimer).

Start Octave first, then from the Octave prompt set the parameters:
```
N=6;Gamma=0.5;Delta=0.0;h=0.0;T=0.1;q_max=3*pi;Nk=8;
```
This means that we will be calculating the diffuse mangetic neutron scattering function *S*(**q**) for a planar molecule with `N=6` magnetic atoms, each interacting with its two nearest neighbours with an interaction of strength *J*, which we are using as our unit of energy, whose anisotropy is described by the parameters `Gamma` and `Delta`. There is no applied field (`h=0`) and the temperature is `T=0.1` (in units of *J*).

To compute *S*(**q**) we will use the function `gen_pic_mat`. This function assumes a ring-shaped molecule on the *x*-*y* plane, with all `N` (assumed even) magnetic atoms placed at the same distance from the origin of coordinates. The first atom is placed at an angle φ/2 to the vertical axis, where φ=2π/N is the angular distance between adjacent atoms (`gen_pic_mat` measures all distances in units of the distance *a* between nearest-neighbour atoms, as shown in the plot):

![Plot of atomic positions](/r_vec_comparison_v02.png)

The function assumes that the scattering vector **q**=(*q*<sub>x</sub>,*q*<sub>y</sub>) is within the plane of the molecule and that any applied field is perpendicular to that plane (in our case, though, the applied field is zero).

The parameters `q_max` and `Nk` specify the values of **q** for which *S*(**q**) will be evaluated: *q*<sub>x</sub>, which is measured in units of 1/*a*, will take `2*Nk=16` values between `-q_max` and `q_max`, inclusive, giving a `16 x 16 = 256`-pixel image (much higher resolutions are of course possible, but in this example we are trying to keep the output files deliberately small).

Let us call `gen_pic_mat` and store its output in the new variable `pic_mat` (the following command executed in approximatly 1.5 seconds on a Lenovo ThinkPad P1 Gen 2 with 64Gb of RAM running Octave 5.2.0 on Ubuntu 20.04):
```
pic_mat=gen_pic_mat(N,Gamma,Delta,h,T,q_max,Nk);
```
`pic_mat` contains the values of *S*(**q**) in the form of an array, with each element of the array corresponding to one of the values of **q**:
```
octave:20> pic_mat
pic_mat =

   5.6861   3.8585   1.9954   2.4922   3.2834   4.0104   3.9964   2.6440   2.6440   3.9964   4.0104   3.2834   2.4922   1.9954   3.8585   5.6861
   4.7142   2.8436   2.8416   3.7175   3.3831   3.1210   2.7972   1.9720   1.9720   2.7972   3.1210   3.3831   3.7175   2.8416   2.8436   4.7142
   2.8019   2.8004   4.1760   3.4225   2.6085   3.1589   2.4433   1.7297   1.7297   2.4433   3.1589   2.6085   3.4225   4.1760   2.8004   2.8019
   2.6922   2.8676   3.3331   2.2848   3.6982   6.0215   4.1811   2.2684   2.2684   4.1811   6.0215   3.6982   2.2848   3.3331   2.8676   2.6922
   2.8143   2.3129   1.8476   1.7935   3.3696   4.3912   3.0210   2.5750   2.5750   3.0210   4.3912   3.3696   1.7935   1.8476   2.3129   2.8143
   3.8070   3.0678   1.7432   1.7418   2.3066   2.6063   2.9551   2.9060   2.9060   2.9551   2.6063   2.3066   1.7418   1.7432   3.0678   3.8070
   4.1848   2.7506   2.3735   2.8059   2.5018   2.6960   3.0712   2.7766   2.7766   3.0712   2.6960   2.5018   2.8059   2.3735   2.7506   4.1848
   3.6083   2.5661   4.7318   4.8948   2.6484   3.2012   2.4909   1.8016   1.8016   2.4909   3.2012   2.6484   4.8948   4.7318   2.5661   3.6083
   3.6083   2.5661   4.7318   4.8948   2.6484   3.2012   2.4909   1.8016   1.8016   2.4909   3.2012   2.6484   4.8948   4.7318   2.5661   3.6083
   4.1848   2.7506   2.3735   2.8059   2.5018   2.6960   3.0712   2.7766   2.7766   3.0712   2.6960   2.5018   2.8059   2.3735   2.7506   4.1848
   3.8070   3.0678   1.7432   1.7418   2.3066   2.6063   2.9551   2.9060   2.9060   2.9551   2.6063   2.3066   1.7418   1.7432   3.0678   3.8070
   2.8143   2.3129   1.8476   1.7935   3.3696   4.3912   3.0210   2.5750   2.5750   3.0210   4.3912   3.3696   1.7935   1.8476   2.3129   2.8143
   2.6922   2.8676   3.3331   2.2848   3.6982   6.0215   4.1811   2.2684   2.2684   4.1811   6.0215   3.6982   2.2848   3.3331   2.8676   2.6922
   2.8019   2.8004   4.1760   3.4225   2.6085   3.1589   2.4433   1.7297   1.7297   2.4433   3.1589   2.6085   3.4225   4.1760   2.8004   2.8019
   4.7142   2.8436   2.8416   3.7175   3.3831   3.1210   2.7972   1.9720   1.9720   2.7972   3.1210   3.3831   3.7175   2.8416   2.8436   4.7142
   5.6861   3.8585   1.9954   2.4922   3.2834   4.0104   3.9964   2.6440   2.6440   3.9964   4.0104   3.2834   2.4922   1.9954   3.8585   5.6861

```
We can now save this array to a file
```
save "pic_mat.dat" pic_mat
```
Once there, it can easily be plotted, using, for instance, GNUplot:
```
gnuplot> set pm3d; unset surface; unset key; set size ratio 1; set view map; splot "pic_mat_hires.dat" matrix
```

![Plot of neutron scattering function](/pic_mat.png)

Alhtough in this example the resolution is low, we can just about appreciate the 6 anti-ferromagnetic scattering peaks. Note that GNUplot does not know the values of the *q*<sub>x</sub> and *q*<sub>y</sub> axes, as it has only been provided with an array containign values of *S*(**q**). In reality, the plot spans values of  *q*<sub>x</sub> and *q*<sub>y</sub> from -3π to 3π, in units of 1/*a*. For a publication-ready plot, we would need to tell GNUPLOT to re-label the axes appropriately.

In this example we have ket the number of pixels in the image being calculated deliberately low so that the calculation would be practically instantaneous. One can get much prettier pictures by using higher values of `Nk`. For instance, setting `Nk=50` yields the following 2.5k-pixel image (the calculation took 38 seconds in the same system used above):

![Plot of neutron scattering function](/pic_mat_hires.png)

If we change the field from `h=0.0` to `h=2.0` then the ground state changes to one with ferromagnetic alignment between the spins and the anti-ferromagnetic peaks are replaced with ferro-magnetic ones:

![Plot of neutron scattering function](/pic_mat_hires_hifield.png)

This is related to an entanglement transition in this model - if you want to know more, you can find it here: https://kar.kent.ac.uk/61595/.

## To do

* Make into a package.
* Write stand-alone documentation for each function (currently functions are documented in comments within their source codes).
* Expunge spurious legacy functions.
