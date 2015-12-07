#!/bin/tcsh
# Copyright (c) Tue Dec  1 20:20:03 PST 2015, David Shin
# Description: 
# Modified from: 
# Usage: 
# Example: 
##############

### PART 1: Extract and save chain A from each .pdb file

foreach i (*pdb)
	# set up pymol script
	echo create chainA, chain A >> pym-separate-chainA.tmp_script
	echo save {$i:r}_A.pdb, chainA, 0, pdb >> pym-separate-chainA.tmp_script

	# run pymol from command line (-c), open your file, and run (-d) the pymol script
	# tcsh #pymol runs via tcsh from my commandline, but it is commented here as
	# #!/bin/tcsh is used above
	pymol -c -d open $i -d @pym-separate-chainA.tmp_script
	# remove the pymol script if you want, can uncomment to keep
	rm -f pym-separate-chainA.tmp_script
end


### PART 2: Extract and save just the atoms, set B-factors to supplied value

foreach i (*_A.pdb)
    grep ^ATOM $i > toto
    awk '{printf("%s\n",substr($0,0,60)" 15.00"substr($0,67))}' toto > toto2 #change the bfactor here,
    mv -f toto2 $i
    rm -f toto
end 


### PART 3: Align all chain A copies for visualization purposes 

set top_pdb = `ls -l *_A.pdb | awk '{print $9}' | head -1 | sed 's/....$//'`
foreach i (*_A.pdb)
    echo load $i >> pym-align.tmp_script
    echo align $i:r, $top_pdb:r  >> pym-align.tmp_script
    echo save {$i:r}_aln.pdb, {$i:r}, 0, pdb >> pym-align.tmp_script
    pymol -c -d open $top_pdb.pdb -d @pym-align.tmp_script
    rm -f pym-align.tmp_script
end



