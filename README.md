<b>Raw_Lum </b> is an ImageJ macro.

It is designed for re-analysis of time-lapse checmiluminescence detection images obtained using "accumulation" function of Bio-Rad ChemiDoc machine.

The macro modifies file names for correct sorting, creates an image stack with a time-stamp, colo-codes the signal intensity, removes noise and subtracts intensities of previous slice from the next slice, thus reverting accumulated signal back into raw intensity for each time point.

<p align="center">
  <img src="https://github.com/AlyonaMinina/Raw_Lum/blob/master/README%20files/Substack%20(17-97).gif" height="300" title="Example">
</p>

All files are saved in three folders: 
 - Original files
 - Relabled files 
 - Results.
