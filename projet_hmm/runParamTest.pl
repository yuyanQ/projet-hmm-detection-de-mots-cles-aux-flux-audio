#!/usr/local/bin/perl

$HCOPY="HCopy";
$hcopyConf="configs/hcopyWAV";
$LOC="radio04";
$LEX="lex1.txt";

&HCopy("lists/$LEX", "donnees/$LOC/", "wav/test", "param/test");

   
#-------------------------------------------------------------------------
# HCopy: Appel de HCopy pour param�triser des fichiers audio  
#-------------------------------------------------------------------------
sub HCopy {
   local($fileList, $refDir, $signal, $param)=@_;
   
	open(FILELIST, $fileList);
	open(FILEPARAM, ">$refDir$fileList");
	while(<FILELIST>) {  
		chop($_);
		@liste = split(/ /,$_);
	    system("$HCOPY  -C $hcopyConf -D $refDir$signal/$liste[0].wav $refDir$param/$liste[0].mfc");
	    print FILEPARAM ("$refDir$param/$liste[0].mfc\n");
	}
	close(FILELIST);
	close(FILEPARAM);
}
