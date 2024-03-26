#!/usr/local/bin/perl

$HVITE="HVite";
$hviteConf="-T 1";
$LOC="radio04";
$DIC="keywordsplus.dic";
$NET2="keywordsplus.net2";
$TEST="lex1.txt";


&HVite("lists/$DIC", "lists/$NET2", "lists/phonesRadio04HTK", "donnees/$LOC", "lists/$TEST", "hmms/hmm.3/HMMmacro");
   

#-------------------------------------------------------------------------
# HVite: D�codage � l'aide des mod�les de Markov  
#-------------------------------------------------------------------------
sub HVite {
    local($fileDic, $fileNet2, $hmmList, $refDir, $paramList, $HMM)=@_;
	system("$HVITE $hviteConf -H $refDir/$HMM -S donnees/radio04/param/test/T.scp -w $fileNet2 $fileDic $hmmList");
    }

#$refDir/$paramList
    
#HVite -T 1 -H donnees/radio04/hmms/hmm.3/HMMmacro -S donnees/radio04/lists/lex1.txt -w lists/keywordsplus.net2 lists/keywordsplus.dic lists/phonesRadio04HTK

#HVite -T 1 -H donnees/Fr178/hmms/hmm.3/HMMmacro -S donnees/radio04/param/test/T.scp -w lists/keywordsplus.net2 lists/keywordsplus.dic lists/phonesFr178HTK

#HResults -w -f lists/labelList.txt donnees/radio04/param/test/Test.rec