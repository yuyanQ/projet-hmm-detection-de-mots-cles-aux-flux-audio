# Define the path toTextGrid file and the tier to extract annotations from projetYuyan/test2webMAUS/*.TextGrid
textgridPath$ = "/Users/yuyanq/Desktop/M2-1/UE2Parole/Module2_Reconnaissance_de_la_parole/projet/projetYuyan/test2webMAUS/synthRadio04_3.TextGrid"

# lire TextGrid
Read from file: textgridPath$

# praa version pourrait causer le problème de "command not available any more"
# 3ers tier des phonèmes 
numberOfIntervals = Get number of intervals: 3 

for interval from 1 to numberOfIntervals
    start = Get starting point: 3, interval
    end = Get end point: 3, interval
    label$ = Get label of interval: 3, interval
        # pour fichier .lab 
    	appendInfoLine: start*10000000," ",end*10000000," ", label$
endfor