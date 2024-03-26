#!/usr/local/bin/perl

$HINIT="HInit";
$hinitConf="-T 2 -i 10 -H configs/HMMmacro";
$LOC="radio04";
$LEX="lex0.txt";
$PHO="phonesRadio04HTK";
&HInit("lists/$PHO", "donnees/$LOC", "lists/$LEX", "hmms/hmm.0");


#-------------------------------------------------------------------------
# HInit: Initialisation des mod�les de Markov  
#$LOC="radio04";

##HInit -T 10 -i 10 -H configs/HMMmacro -L donnees/radio04/lab -l rr -M donnees/radio04/hmms/hmm.0 -S donnees/radio04/lists/lex0.txt  configs/HMMproto
#$LEX="lex0Fr178.txt";
#$PHO="phonesRadio04HTK"; #phonesHTK
#HInit -T 2 -i 10 -H configs/HMMmacro lists/phonesRadio04HTK -L donnees/radio04/lab -l phonesRadio04HTK -M donnees/radio04/hmms/hmm.0 -S donnees/radio04/lists/lex0.txt  configs/HMMproto
#-------------------------------------------------------------------------
sub HInit {
    local($hmmList, $refDir, $paramList, $destHMM)=@_;

    open(HMMLIST, $hmmList);
	while(<HMMLIST>) {  
	    chop($_);
	    system("$HINIT $hinitConf -L $refDir/lab -l $_ -o $_ -M $refDir/$destHMM -S donnees/radio04/param/apprentissage/T.scp  configs/HMMproto");
	}
	close(HMMLIST);
    }
	#$refDir/$paramList
    #$refDir/$paramList = donnees/radio04/lists/lex0Fr178.txt

