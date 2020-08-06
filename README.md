<b>Raw_Lum </b> is an ImageJ macro.

It is designed for re-analysis of time-lapse checmiluminescence detection images obtained using SAM (Signal Accumulation Mode of the Bio-Rad ChemiDoc machine).

The macro modifies file names for correct sorting, creates an image stack with a time-stamp, color-codes the signal intensity, removes noise. The original SAM time-lapse stack is saved and a copy of it is used to subtract intensitties of a previous slice from the following slice in the whole stack, thus reverting accumulated signal back into raw intensity for each time point.

<p align="center">
  <img src="https://github.com/AlyonaMinina/Raw_Lum/blob/master/README%20files/Substack%20(17-97).gif" height="300" title="Example">
</p>

All files are saved in three folders: 
 - Original files
 - Relabled files 
 - Results.
