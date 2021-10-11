//Convert all files to nerdtype
#@ File (label = "Input directory", style = "directory") input
#@ String (label = "File suffix", value = ".czi") suffix

setBatchMode(true);
processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list); 
	for (i = 0; i < list.length; i++) { 
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, list[i]);
	}
}

function processFile(input, file) {
	print("Processing: " + input + File.separator + file);
	run("Bio-Formats Windowless Importer", "open=" + input + File.separator + file);
	run ("Split Channels");
	selectWindow("C1-" + file);
	run("Nrrd ... ", "nrrd=" + input + File.separator + file + ".nrrd");
}

