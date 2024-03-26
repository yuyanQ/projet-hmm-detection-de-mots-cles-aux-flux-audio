#!/usr/local/bin/perl

$HCOPY="HCopy";
$hcopyConf="configs/hcopyWAV";
$LOC="radio04";
$LEX="lex0.txt";

&HCopy("lists/$LEX", "donnees/$LOC/", "wav/apprentissage", "param/apprentissage");

#-------------------------------------------------------------------------
# HCopy: Appel de HCopy pour param�triser des fichiers audio  
# @liste = split(/ /,$_); = 
# $refDir$signal = donnees/$LOC/wav/apprentissage
# T2 sil l a p l a zz sil a l a s i rr k y l a s j o# sil l a v n y a t l a# t i k a ee f ee rr m e o z o t o m o b i l sil e o# l ee s sil
#/$liste[0].wav  = T1.wav
#-------------------------------------------------------------------------
sub HCopy {
   local($fileList, $refDir, $signal, $param)=@_;
   
	open(FILELIST, $fileList);
	open(FILEPARAM, ">$refDir$fileList");
	while(<FILELIST>) {  
		# 循环lists/lex0Fr178.txt的每一行，
		chop($_);
		@liste = split(/ /,$_);
		print ("$liste[0]");
		#$_代表当前行内容，既一个transcription
	    system("$HCOPY  -C $hcopyConf -D $refDir$signal/$liste[0].wav $refDir$param/$liste[0].mfc");
	    print FILEPARAM ("$refDir$param/$liste[0].mfc\n");
	}
	close(FILELIST);
	close(FILEPARAM);
}

#HCopy -C configs/hcopyWAV -D donnees/radio04/wav/apprentissage/synthRadio04_2.wav donnees/radio04/param/apprentissage/synthRadio04_2.mfc