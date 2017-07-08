# Matlab_Linear_Regression_multi_output

in the repository Matlab_Linear_Regression i use the absolute maximun as single output.

but in fact the maximum shear angle and the minimum shear angel all of them are important.

because the plus or minus represebtative only direction of the shear angle.

so we take both of them as multi-output [max_shear_angle, min_shear_angle].

after the same step, we can see that the results are much much better than before.


the next steps i think are as follows:(my own opinion)

1. add regulatization item.

2. try to plot the learn curve, to find either overfittign or underfitting occurs, then we can try to 
delete features or increase sample to improve the performance.

3. there are regression toolbox in the new Matlab version, man can use this toolbox to build a modell through 
just some clicks.


