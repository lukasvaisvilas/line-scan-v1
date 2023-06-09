
//Open folder with .tiff files
dir = getDirectory("desktop/230404_Test_6-3X-TPH2_10-35-34");

//Open folder for saving raw data
dir1 = getDirectory("desktop/data");


list = getFileList(dir);

setBatchMode(true); 
for (i = 0; i < list.length; i++){   
    processImage(dir,list[i]);
}
setBatchMode("exit and display");

function processImage(dir,image){
    open(dir+image);
    fileNoExtension = File.nameWithoutExtension;
    
//Requires FeatureJ plug-in

    run("FeatureJ Hessian", "largest absolute smoothing=0.5");
    run("Brightness/Contrast...");
	setMinAndMax(657, 3507);run("Close");
    	
 //Parallel line scans
 
     	makeLine(1140, 1348, 1540, 1348);
     	profile = getProfile();
	for (i=0; i<profile.length; i++)
  		setResult("par1", i, profile[i]);
		
		makeLine(1140, 1548, 1540, 1548);
	profile = getProfile();
	for (j=0; j<profile.length; j++)
  		setResult("par2", j, profile[j]);
		
		makeLine(1140, 1748, 1540, 1748);
	profile = getProfile();
	for (k=0; k<profile.length; k++)
  		setResult("par3", k, profile[k]);
  
  //Perpendicular line scans
  
  		makeLine(1140, 1348, 1140, 1748);
		profile = getProfile();
	for (j=0; j<profile.length; j++)
  		setResult("perp1", j, profile[j]);
    	
    	makeLine(1340, 1348, 1340, 1748);
     	profile = getProfile();
	for (i=0; i<profile.length; i++)
  		setResult("perp2", i, profile[i]);
		
		makeLine(1540, 1348, 1540, 1748);
	profile = getProfile();
	for (k=0; k<profile.length; k++)
  		setResult("perp3", k, profile[k]);
	
	updateResults(); 
    saveAs("Results", dir1+"Processed_"+fileNoExtension+".csv");

}

	close("*");
	close("Results");
