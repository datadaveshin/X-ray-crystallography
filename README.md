#X-ray-crystallography
##Repository of scripts for X-ray crystallography
###mr_model_setup.tcsh
This is a tcsh shell script that will set up your input search model files for molecular replacement. The input coordinate files should be contained in their own directory with a .pdb extension. The program runs in three parts:


Note, that it uses PyMol for some of the heavy lifting. This means that upon running this script, a new script is written and PyMol is called during the process to do some of the work. PyMol thus must be in your $PATH as 'pymol' (can edit the file if you have a different alias or method to call PyMol. tsch was used because my version of PyMol uses tcsh to run on the command line.


