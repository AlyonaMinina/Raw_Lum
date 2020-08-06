//Step1. Relabel the original files for correct sorting

 ///Select the directory with files
 dir = getDirectory( "Choose the Directory" );

 ///List all files in the directory with original files
 list1 = getFileList(dir);
 

//create a folder for relabeled files
 reldir = dir + "/Relabeled files/";
 File.makeDirectory(reldir);

 
 //relabel the files
 for ( i=0; i<list1.length; i++ ) {
 	  setBatchMode(true); 
      open( dir + list1[i] );
      original_name = getTitle();
      exposure = substring(original_name, 40);
      dotIndex = indexOf(exposure, ".");
      sec = substring(exposure, 0, dotIndex);
      new_name = IJ.pad(sec, 5);    
      saveAs("png", reldir + new_name + ".png");
      close();
}



//Step2. Create a stack from relabeled files and save the data for SAM (singal accumulation mode of BioRad ChemiDoc)

 ///List all files in the Relabeled directory
 list2 = getFileList( reldir );

 ///Loop the open command for all files in the list
 for ( i=0; i<list2.length; i++ ) {
    open( reldir + list2[i] );
 }

///Create a stack
run("Images to Stack", "name=Stack title=[] use");
///remove noise
run("Remove Outliers...", "radius=1 threshold=5 which=Bright stack");


///create the results fodler
 resdir = dir + "/Results/";
 File.makeDirectory(resdir);

///Duplicate stack
 run("Duplicate...", "duplicate");

///color coding
run("royal");

///get the number of slices that should be labeled
n = getSliceNumber();
///add the time stamp to all slices. sic! the interval is fixed to 72 seconds for our experiments, correct if needed
run("Label...", "format=00:00:00 starting=0 interval=72 x=5 y=20 font=18 text=h:min:sec range=1-n");

//Save the processed stack
save(resdir + "SAM Intensity");







//Step3. Subtract the slices to get raw intensity for each esposure, instead of cumulative intensity

 ///Duplicate stack
 run("Duplicate...", "duplicate");

 ///Modify the stack copy
 selectWindow("Stack-1");
 ///Add an empty slice to the stack-1
 setKeyDown("alt");
 run("Add Slice");
 ///To keep the number of slices in stack-1 the same as in the original stack, delete the last slice from stack-1
 selectWindow("Stack-1");
 n=nSlices();
 setSlice(n);
 run("Delete Slice");

///Subtract stack-1 from the original stack
run("Calculator Plus", "i1=[Stack] i2=[Stack-1] operation=[Subtract: i2 = (i1-i2) x k1 + k2] k1=50 k2=0 create");
selectWindow("Stack");
run("Close");
selectWindow("Stack-1");
run("Close");
///remove the first slice that was modified without subtraction
setSlice(1);
run("Delete Slice");


//Step3. Color-code the intensity using Royal LUT and remove noise

///color coding
run("royal");

///remove noise
run("Remove Outliers...", "radius=1 threshold=5 which=Bright stack");

//Step4. Add time stamp

///get the number of slices that should be labeled
n = getSliceNumber();

///add the time stamp to all slices. sic! the interval is fixed to 72 seconds for our experiments, correct if needed
run("Label...", "format=00:00:00 starting=72 interval=72 x=5 y=20 font=18 text=h:min:sec range=1-n");


//Step5.  Save the results in a new folder

///create the results fodler
 resdir = dir + "/Results/";
 File.makeDirectory(resdir);

//Save the processed stack
save(resdir + "Raw Intensity");


 //create a folder for original files
 oridir = dir + "/Original files/";
 File.makeDirectory(oridir);

 //move the original files to their folder
 for ( i=0; i<list1.length; i++ ) {
 	  File.rename(dir + list1[i], oridir + list1[i]);
 	  }

//Close all files
run("Close All");

