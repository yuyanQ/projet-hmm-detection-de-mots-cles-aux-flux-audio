#!/usr/local/bin/perl

$HVITE="HVite";
$hviteConf="-T 1";
$HPARSE="HParse";
$LOC="radio04";
$DIC="keywords.dic";#"keywords.dic";
$NET="keywords.net";#"keywords.net";
$TEST="lex1.txt";


#"lists/$TEST",
&HVite("lists/$DIC", "lists/$NET", "lists/phonesRadio04HTK", "donnees/$LOC", "donnees/radio04/param/test/synthRadio04_3.mfc", "hmms/hmm.3/HMMmacro");
# ,  

#-------------------------------------------------------------------------
# HVite: D�codage � l'aide des mod�les de Markov  
#-------------------------------------------------------------------------
sub HVite {
    local($fileDic, $fileNet, $hmmList, $refDir, $paramList, $HMM)=@_;
    
    system("$HPARSE $fileNet tmp/net1");		
	system("$HVITE $hviteConf -H $refDir/$HMM  -w tmp/net1 $fileDic $hmmList $paramList");
    }


#-S $refDir/$paramList 
