Updated 8/20/24 by Chuong Tran

UCI X Energy Labs
email: chuondt1@uci.edu
__________________________________________________________Before running the main code (PT_code_REV3.m), here are some instructions:

1. Check any disclaimers and warnings at the end of this README.

2. When you run the main code, add-on any extensions needed (lvm and pdist2). These help with importing and graphically processing data.

3. There are hardcoded parameters in parameters.m, you can change them however you like.

4. The name of the data is programmed as the name of the .lvm file without the .lvm extension.
__________________________________________________________
Running the code:

1. Enter the .lvm file

2. The transducer split graphs and the velocity graph should pop out first.

3. Now, YOU have the option to quit the script by typing "0" in the dialogue box, or change any transducer peak pick by typing the transducer # (like '1').

4. These step is if you like to change a transducer peak pick.

Left-click which of the filtered points as your "wave" point. The command window in MATLAB will show you the point that you clicked. EXIT (ctrl + w) the figure to lock in your point.


5. MATLAB will now process all your points and calculate the detonation velocity graph!

Repeat Steps 3-5 for any more correction. 
__________________________________________________________Things to add in:

- Saving feature for all graphs (can be done manually)
- Saving feature for data points (most likely spreadsheet or CSV for python)
- Organization and comments (done)
- Refresh Transducer Split after every correction (or close it)
__________________________________________________________
WARNING: Script FAILS on PD_06_06_24_1313.lvm
Possible Reasons: 

1. Some transducer readings are unclear and their peaks aren't so obvious or significantly outstanding from noise.
2. The hardcoded parameters aren't refined enough to process this data's peak patterns.
3. The script may be too "strict" and came up short in finding peaks.

DISCLAIMER: MATLAB scripts is NOT final and are subject to change from additional feedback.