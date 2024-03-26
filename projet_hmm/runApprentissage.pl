#!/usr/local/bin/perl

$HINIT="HInit";
$hinitConf="-T 2 -i 10 -H configs/HMMmacro";
$LOC="radio04";
$LEX="lex0.txt";
$PHO="phonesRadio04HTK"; #phonesHTK
&HInit("lists/$PHO", "donnees/$LOC", "lists/$LEX", "hmms/hmm.0");

$HREST="HRest";
$hrestConf="-T 1 -i 10 -H configs/HMMmacro";
&HRest("lists/$PHO", "donnees/$LOC", "lists/$LEX", "hmms/hmm.0", "hmms/hmm.1");

$HEREST="HERest";
$herestConf="-T 1 -H configs/HMMmacro";
&HERest("lists/$PHO", "donnees/$LOC", "lists/$LEX", "hmms/hmm.1", "hmms/hmm.2");

$HHED="HHEd";
$hhedConf="configs/divg.hed";
&HHEd("lists/$PHO", "donnees/$LOC", "hmms/hmm.2", "hmms/hmm.3");

#-------------------------------------------------------------------------
# HInit: Initialisation des mod�les de Markov  
#$LOC="radio04";
#$LEX="lex0Fr178.txt";
#$PHO="phonesRadio04HTK"; #phonesHTK
#HInit -T 2 -i 10 -H configs/HMMmacro lists/phonesRadio04HTK -L donnees/radio04/lab -l phonesRadio04HTK -M donnees/radio04/hmms/hmm.0 -S donnees/radio04/lists/lex0.txt  configs/HMMproto
#-------------------------------------------------------------------------
sub HInit {
    local($hmmList, $refDir, $paramList, $destHMM)=@_;

    open(HMMLIST, $hmmList);
	while(<HMMLIST>) {  
	    chop($_);
	    system("$HINIT $hinitConf -L $refDir/lab -l $_ -o $_ -M $refDir/$destHMM -S $refDir/$paramList  configs/HMMproto");
	}
	close(HMMLIST);
    }
	#donnees/radio04/param/apprentissage/T.scp
    #$refDir/$paramList = donnees/radio04/lists/lex0Fr178.txt
#-------------------------------------------------------------------------
# HRest: Apprentissage en mode isol� des mod�les de Markov  
#$LOC="radio04";
#$LEX="lex0Fr178.txt";
#$PHO="phonesRadio04HTK"; #phonesHTK
# &HRest("lists/$PHO", "donnees/$LOC", "lists/$LEX", "hmms/hmm.0", "hmms/hmm.1");
#-------------------------------------------------------------------------
sub HRest {
    local($hmmList, $refDir, $paramList, $srcHMM, $destHMM)=@_;

    open(HMMLIST, $hmmList);
	while(<HMMLIST>) {  
	    chop($_);
	    system("$HREST $hrestConf -L $refDir/lab -l $_ -M $refDir/$destHMM -S $refDir/$paramList  $refDir/$srcHMM/$_");
	}
	close(HMMLIST);
    }
    
#-------------------------------------------------------------------------
# HERest: Apprentissage en mode connect� des mod�les de Markov  
#$LOC="radio04";
#$LEX="lex0Fr178.txt";
#$PHO="phonesRadio04HTK"; #phonesHTK
#-------------------------------------------------------------------------
sub HERest {
    local($hmmList, $refDir, $paramList, $srcHMM, $destHMM)=@_;
    $nbIter = 5;
    
    if ($srcHMM ne $destHMM) {
	system("$HEREST $herestConf -L $refDir/lab -M $refDir/$destHMM -S $refDir/$paramList  -d $refDir/$srcHMM $hmmList");
    }
	for ($i = 0;$i < $nbIter;$i++) {
		system("$HEREST -T 1 -H $refDir/$destHMM/HMMmacro -L $refDir/lab -M $refDir/$destHMM -S $refDir/$paramList  $hmmList");
		}
    }
    
#-------------------------------------------------------------------------
# HHEd: Duplication des gaussiennes des machines de Markov  
#$LOC="radio04";
#$LEX="lex0Fr178.txt";
#$PHO="phonesRadio04HTK"; #phonesHTK
#-------------------------------------------------------------------------
sub HHEd {
    local($hmmList, $refDir, $srcHMM, $destHMM)=@_;
    
	system("$HHED -H $refDir/$srcHMM/HMMmacro -M $refDir/$destHMM $hhedConf $hmmList");
    }
    
