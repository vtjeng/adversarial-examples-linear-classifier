# adversarial-examples-linear-classifier
Finding adversarial examples for a linear classifier.

# Quickstart
  + Gurobi
    + You will need the Gurobi solver to run `find_adversarial_example.m`. 
    + Remember to setup Gurobi following the instructions [here](https://www.gurobi.com/documentation/7.0/quickstart_mac/matlab_setting_up_gurobi_f.html) before attempting to run the code.
    + Alternatively, you can add the Gurobi MATLAB folder to your `startup.m` file (run `which startup` in MATLAB to determine where it is). The appropriate command is of the form `addpath 'C:\gurobi702\win64\matlab'`.
  + Entrypoint
    + Start with `main.m` - this should give you an example of how to 1) find an example linear classifier, 2) find adversarial examples for a given example and linear classifier, and 3) how to visualize the original and perturbed images.
