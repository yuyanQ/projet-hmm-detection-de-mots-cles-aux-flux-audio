#!/usr/local/bin/perl

$HVITE="HVite";
$HPARSE="HParse";
$hviteConf="-y alg lists/SampaToHTK.dic lists/phonesRadio04HTK";
$LOC="radio04";
$LEX="lex0.txt";

&Segmentation("lists/$LEX", "donnees/$LOC", "param/apprentissage", "hmms/hmm.3/HMMmacro");
   

#-------------------------------------------------------------------------
# Segmentation: Segmentation d'un fichier de param�tres  
#-------------------------------------------------------------------------
sub Segmentation {
    local($fileList, $refDir, $param, $hmm)=@_;
  
	open(FILELIST, $fileList);
	while(<FILELIST>) {  
		chop($_);
		@liste = split(/ /,$_);
		open(FILENET, ">tmp/net1");
		print FILENET "([sil] ";
		for ($i=1;$i<=$#liste;$i++) {
			print FILENET ("$liste[$i] ");
		} 
		print FILENET "[sil])";
		close(FILENET);
        system("$HPARSE tmp/net1 tmp/net2");		
	    system("$HVITE -T 1 -H $refDir/$hmm -l $refDir/lab -w tmp/net2 $hviteConf $refDir/$param/$liste[0].mfc");
	    &Transcodage("$refDir/lab/$liste[0].alg", "$refDir/lab/$liste[0].lab");
	}
	close(FILELIST);
}


#-------------------------------------------------------------------------
# Transcodage: Modification du jeux d'�tiquettes   
#-------------------------------------------------------------------------
sub Transcodage {
    local($fileAlg, $fileLab)=@_;
  	my @Label1 = ("R","E","O","S","Z","H","J","A");
  	my @Label2 = ("#rr","ee","oo","ss","zz","hh","jj","aa");
  
  
	open(FILEALG, $fileAlg);
	open(FILELAB, ">$fileLab");
	while(<FILEALG>) {  
		chop($_);
		@liste = split(/ /,$_);
		print FILELAB "$liste[0] $liste[1] ";
		for ($i=0;$i<=$#Label1;$i++) {
			$liste[2] =~ s/$Label1[$i]/$Label2[$i]/;
		}
		print FILELAB "$liste[2] ";
		print FILELAB "$liste[3]\n";
	}
	close(FILEALG);
	close(FILELAB);
}

 
