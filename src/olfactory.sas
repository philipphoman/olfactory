/********
/*
/*
/* Olfactory data analysis
/*
/* PH
/*
/*********

/* Import data */
/* preprocessing and merging stuff */
proc import datafile="../data/olfactory.xlsx" 
out=olfacselfreport
dbms=xlsx replace;
sheet="olfacselfreport";
run;

proc import datafile="../data/olfactory.xlsx" 
out=olfactaskfull
dbms=xlsx replace;
sheet="olfactaskfull";
run;

proc import datafile="../data/olfactory.xlsx" 
out=olfactaskattr
dbms=xlsx replace;
sheet="olfactaskattr";
run;

proc import datafile="../data/olfactory.xlsx" 
out=olfactaskbetas
dbms=xlsx replace;
sheet="olfactaskbetas";
run;


proc import datafile="../data/olfactory.xlsx" 
out=olfactasklosobetas
dbms=xlsx replace;
sheet="olfactasklosobetas";
run;

proc import datafile="../data/olfactory.xlsx" 
out=olfactaskitems
dbms=xlsx replace;
sheet="olfactaskitems";
run;

proc import datafile="../data/olfactory.xlsx" 
out=visualselfreport
dbms=xlsx replace;
sheet="visualselfreport";
run;

proc import datafile="../data/olfactory.xlsx" 
out=visualtaskfull
dbms=xlsx replace;
sheet="visualtaskfull";
run;

proc import datafile="../data/olfactory.xlsx" 
out=visualtaskattr
dbms=xlsx replace;
sheet="visualtaskattr";
run;

proc import datafile="../data/olfactory.xlsx" 
out=visualemg
dbms=xlsx replace;
sheet="visualemg";
run;

proc import datafile="../data/olfactory.xlsx" 
out=olfacvisual
dbms=xlsx replace;
sheet="olfacvisual";
run;

/*---------------------------------------------------------------*/
/*------------------------end import-----------------------------*/


/*---------------------------------------------------------------*/
/*--------------------------graphics-----------------------------*/

proc template;
 define style olfactory;
 parent=styles.statistical;

class GraphFloor /
		contrastcolor=black
		background=black;

class GraphLegendBackground /
		Color=white;
		
class GraphHeaderBackground /
		Color=white;

	
class GraphBorderLines /
		contrastcolor=white
		linethickness=0;

class GraphBoxMean /
		markersymbol = "diamond"
		ContrastColor = black
		Color = black;

class GraphBoxMedian /		
		ContrastColor = black
		Color = black;				
		
class GraphBoxWhisker /
		ContrastColor = black
		Color = black;

/* switch off all frames by setting
frameborder = off */	
class GraphWalls /
		ContrastColor=white		
		Color=white
		frameborder = off
		linethickness = 0;

/* x and y axis only by setting
ContrastColor = black */
class GraphAxisLines /
		LineThickness = 2
		Color = black
		ContrastColor=black;

class GraphGridLines /
		linethickness = 1
		ContrastColor=CXC0C0C0; 
		
/*
class GraphError /
		Color = black
		linethickness = 2
		ContrastColor = black;		
*/		

class GraphError /
		Color = black
		ContrastColor = black;		
		


class GraphFonts /
  		'GraphDataFont' = ("Arial",15pt)
        'GraphUnicodeFont' = ("Arial",15pt,bold)
        'GraphValueFont' = ("Arial",15pt,bold)
        'GraphLabelFont' = ("Arial",15pt,bold)
        'GraphTitleFont' = ("Arial",17pt,bold)
        'GraphAnnoFont' = ("Arial",15pt)
		'GraphFootNoteFont' = ("Arial",15pt);



style GraphDataDefault /		
		color = H000BF00
		color = CX4D7EBF
		color = CX90B0D9
		color = CX13478C
		color = CX4D7EBF
		color = white
		LineStyle = 1
		Linethickness= 1
		markersymbol = "circlefilled"	
		markersize = 18
		contrastcolor = black;

style GraphData2 /		
		color = H000BF00
		color = CX4D7EBF
		color = white
		color = H000BF00
		LineStyle = 2
		Linethickness= 1
		markersymbol = "circlefilled"	
		markersize = 18
		contrastcolor = green;

style GraphData1 /	
		color = white
		color = CX4D7EBF
		color = CXBFBFBF
		color = CX4D7EBF
		color = CX13478C
		color = white
		LineStyle = 1
		Linethickness= 1	
		markersymbol = "circlefilled"
		markersize = 18	
		contrastcolor = blue;

style GraphData3 /		
		color = black
		markersymbol = "circlebold"
		markersize = 14	
		contrastcolor = black;


/*
class GraphData2 /
		LineStyle = 2
		markersymbol = "circle"
		markersize = 12
		color = white
		contrastcolor = black;

class GraphData1 /
		LineStyle = 1
		markersymbol = "circlefilled"
		markersize = 12
		color=CXC0C0C0
		contrastcolor = black;
*/	
class GraphPrediction /
		Contrastcolor=black;

class GraphPredictionLimits /
		Color=CXC0C0C0
		Color=CXBFBFBF;
		
class GraphConfidence /
		Color=CXC0C0C0
		Color=CXBFBFBF;	
		
class GraphConfidence2 /
		Color=CXC0C0C0
		Color=CXBFBFBF;	

class GraphFit /
		ContrastColor=black
		LineThickness=3
		Color=CXC0C0C0
		Color=CXBFBFBF;	
		
class GraphFit2 /
		ContrastColor=black
		LineThickness=3
		Color=CXC0C0C0
		Color=CXBFBFBF;	
	
end;
run;

proc template;
 define style olfactory2;
 parent=olfactory;

class GraphFloor /
		contrastcolor=black
		background=black;

/* x and y axis only by setting
ContrastColor = black */
class GraphAxisLines /
		LineThickness = 2
		Color = black
		ContrastColor=white;
end;
run;

/*---------------------------------------------------------------*/
/*----------------------end graphics-----------------------------*/
/*---------------------------------------------------------------*/
/*----------------------end graphics-----------------------------*/

/*---------------------------------------------------------------*/
/*-----------------------start preproc---------------------------*/

data olfacselfreport;
set olfacselfreport;
avscore=mean(dddisg,ddangr,ddanx,ddsad,-ddhap);
run;

data olfacselfreportsmall;
set olfacselfreport;
if time eq "After" or stim eq "CS+" or emotion not eq 'disgusted' then delete;
run;


data olfacselfreportsmall;
set olfacselfreportsmall(keep=id ddispsit smelldisgusting smellintens smellnegpos avscore ddangr ddanx dddisg ddhap ddsad);
*if time not in (1) and stim not in (0) and emotion not eq 'disgusted' then delete;
run;

data olfactaskfull;
merge olfactaskfull olfacselfreportsmall;
by id;
run;

data olfactaskfull;
set olfactaskfull;
if run = 1 then obs = trial;
if run = 2 then obs = trial + 16;
run;

data visualtaskfull;
set visualtaskfull;
if behav_resp = 9 then behav_resp = 8;
if behav_resp = 0 then behav_resp = .;
if behav_resp = . then attribtype = .;
if behav_resp > 4 then attribtype=2;
if behav_resp < 5 and not missing (behav_resp) and not behav_resp = 0 then attribtype=1;
run;

proc sort data=visualselfreport; by id period stim;
proc transpose data=visualselfreport out=visualselfreportlong(rename=(col1=selfreport _NAME_=emotion) drop=_LABEL_);
by id period stim; 
var Disgust	Anxious	Angry	Sad	Happy;
run;

proc sort data=visualselfreport; by id sex;
data sex;
set visualselfreport(keep=id sex);
by id;
if not first.id then delete;
run;

data visualselfreportlong;
merge visualselfreportlong sex;
by id;
run;

proc sort data=visualselfreport; by id;
proc transpose data=visualselfreport 
out=visualselfreportwide
(rename=
(_NAME_=emotion ps1=Period1_CSm 
ps2=Period1_CSp ps3=Period2_CSm 
ps4=Period2_CSp) drop=_LABEL_) 
prefix=ps;
by id;
var disgust angry anxious sad happy;
run;

data visualselfreportwide;
set visualselfreportwide;
dCSm = Period2_CSm-Period1_CSm;
dCSp = Period2_CSp-Period1_CSp;
ddCS = dCSp-dCSm;
run;

proc transpose data=visualselfreportwide out=visualselfreportwidewide(drop=_NAME_) prefix=dd;
by id;
id emotion;
var ddCS;
run;


proc sort data=visualtaskattr; by id;
data visualtaskattr;
merge visualtaskattr visualselfreportwidewide;
by id;
run;

data visualtaskattr;
set visualtaskattr;
avscore=mean(dddisgust,ddangry,ddanxious,ddsad);
run;


data visualtaskfull;
set visualtaskfull;
if behav_resp = 9 then behav_resp = 8;
if behav_resp = 0 then behav_resp = .;
if behav_resp = . then attribtype = .;
if behav_resp > 4 then attribtype=2;
if behav_resp < 5 and not missing (behav_resp) and not behav_resp = 0 then attribtype=1;
length data attribtypec $25;
if attribtype = 1 then attribtypec = "Situational";
if attribtype = 2 then attribtypec = "Dispositional";
run;


data olfactaskitems;
set olfactaskitems;
obs=origitem;
run;

data tmp;
set olfactaskfull(keep=id obs type exporder);
where type eq 'behav';
run;

proc sort data=tmp; by exporder obs;
proc sort data=olfactaskitems; by exporder obs;
data tmp;
merge tmp olfactaskitems;
by exporder obs;
run;

data tmp2;
set tmp(keep=id exporder obs item);
run;

proc sort data=olfactaskfull; by id obs;
proc sort data=tmp2; by id obs;
data olfactaskfull;
merge olfactaskfull tmp2;
by id obs;
run;

data olfactaskfull;
set olfactaskfull;
obs = obs-1;
run;


/* add predictor for real observation that considers order of questions */
proc print data=olfactaskfull;
var q1type q2type q3type qorder;
run;


proc sort data=olfactaskfull; by id obs type; run;
/* now sorted by id and obs, type is sorted by behav like moral */
data olfactaskfull;
set olfactaskfull;
by id;
if first.id then realobs = 0;
else realobs + 1;
run;

data olfactaskfull;
set olfactaskfull;
if qorder = 1 and type eq 'moral' then realobs = realobs-2;
if qorder = 1 and type eq 'like' then realobs = realobs;
if qorder = 1 and type eq 'behav' then realobs = realobs+2;
if qorder = 2 and type eq 'moral' then realobs = realobs-2;
if qorder = 2 and type eq 'like' then realobs = realobs+1;
if qorder = 2 and type eq 'behav' then realobs = realobs+1;
if qorder = 3 and type eq 'moral' then realobs = realobs;
if qorder = 3 and type eq 'like' then realobs = realobs-1;
if qorder = 3 and type eq 'behav' then realobs = realobs+1;
if qorder = 4 and type eq 'moral' then realobs = realobs-1;
if qorder = 4 and type eq 'like' then realobs = realobs-1;
if qorder = 4 and type eq 'behav' then realobs = realobs+2;
if qorder = 5 and type eq 'moral' then realobs = realobs;
if qorder = 5 and type eq 'like' then realobs = realobs;
if qorder = 5 and type eq 'behav' then realobs = realobs;
if qorder = 6 and type eq 'moral' then realobs = realobs-1;
if qorder = 6 and type eq 'like' then realobs = realobs+1;
if qorder = 6 and type eq 'behav' then realobs = realobs;
run;

proc sort data=olfactaskfull; by id realobs;
run;

data olfacselfreportsmall;
set olfacselfreportsmall;
ddunhap = 0 - ddhap;
smellav = 9 - smellnegpos;
avscoreavoid = mean(ddanx,dddisg,ddangr,ddsad);
avscoreavoidhr = mean(ddanx,dddisg,ddangr,ddsad,-ddhap);
avscoreavoidh = mean(ddanx,dddisg,ddangr,ddsad,ddhap);
avscorereprod = mean(dddisg,ddunhap);
diffavappr = mean(dddisg,ddanx,ddangr,ddsad) - ddhap;
run;



proc sort data=olfactaskbetas; by id;
data olfacppi;
merge olfactaskbetas olfacselfreportsmall;
by id;
run;


/* merge olfactory and visual selfreport data for regression */
data v;
set visualtaskattr(keep=id dispperc 
ddDisgust ddAngry ddAnxious ddSad ddHappy avscore valence stim);
length group $20;
group='visual';
where valence eq 'Pos' and stim eq 'CS+';
run;

data o;
set olfacselfreportsmall(keep=id ddispsit 
ddDisg ddAngr ddAnx ddSad ddHap avscoreavoid);
length group $20;
group='olfactory';
ddDisgust = ddDisg;
ddAngry = ddangr;
ddAnxious = ddanx;
ddSad = ddsad;
ddHappy = ddHap;
dispperc = ddispsit * 100;
avscore = avscoreavoid;
run;

data o;
set o(keep=id dispperc group
ddDisgust ddAngry ddAnxious ddSad ddHappy avscore);
run;

data ov;
set o v(drop=valence stim);
run;

/*-----------------------------------------------------------*/
/*----------------end data preprocessing-------------------- */
/*-----------------------------------------------------------*/
/*----------------start inference--------------------------- */
/*-----------------------------------------------------------*/

/* compare olfac and visual */
/* include higher order interaction */
proc mixed data=olfacvisual plots=residualpanel;
class id stim valence group;
model dispperc = group|stim|valence / s ddfm=kr;
random int stim valence / subject=id*group;
where id not in (1001 2002 2009);
run;

/* compare olfac and visual */
/* 3-way interaction dropped*/
proc mixed data=olfacvisual plots=residualpanel;
class id stim valence group;
model dispperc = group|stim / s ddfm=kr;
random int stim / subject=id;
where id not in (1001 2002 2009);
run;


/* compare olfac and visual regression */
proc glm data=ov plots=ancovaplot;
class group;
model dispperc = avscore|group/ solution clparm;
where id not in (1001 2002 2009) ;
run;

/* linear regression plot with avscore as predictor of trait attributions */
ods listing gpath='../output/figures' 
style=olfactory image_dpi=300;
ods graphics on /imagefmt=pdf;
proc sgplot data=ov;
reg x=avscore y=dispperc /  name='scatter' group=group;
yaxis label='Difference in % Trait Attributions';
xaxis label ='Difference in Negative Emotions' ;
keylegend 'scatter' / position=top;  
run;
ods graphics off;
ods listing close;



proc mixed data=visualtaskattr plots=residualpanel;
class id stim valence;
model dispperc = stim|valence / s ddfm=kr;
repeated / subject=id type=cs;
run;

proc mixed data=visualemg plots=residualpanel;
class id stim;
model emg = trial|stim / s ddfm=kr;
random int trial stim / subject=id;
lsmeans stim / adjust=tukey;
run;

proc mixed data=visualtaskfull plots=residualpanel;
class id stim valence attribtypec;
model moral_resp = valence|stim|attribtypec / s ddfm=kr;
random int stim valence / subject=id;
run;

proc mixed data=visualtaskfull plots=residualpanel;
class id stim valence attribtypec;
model like_resp = valence|stim|attribtypec / s ddfm=kr;
random int stim valence / subject=id;
run;

/* visual study trait attributions dot chart */
ods listing style=olfactory gpath='../output/figures' image_dpi=300;
ods graphics on /imagefmt=pdf  reset=index;
proc sgplot data=visualtaskattr noautolegend;
vline valence / response=dispperc stat=mean limitstat=stderr 
group=stim groupdisplay=cluster grouporder=ascending name="stim" clusterwidth=0.5 markers;
xaxis label=" ";
yaxis label="% Trait Attributions";
keylegend "stim" / position=top;
run; 
title;
ods graphics off;
ods listing close;


/* visual study morality ratings */
proc sort data=visualtaskfull;
by id attribtypec valence stim;
run;
proc summary data=visualtaskfull mean;
by id attribtypec valence stim;
var moral_resp;
output out=meanvisualmoral mean=meanresp;
run;

ods listing style=olfactory gpath='../output/figures' image_dpi=300;
ods graphics on /imagefmt=pdf;
proc sgpanel data=meanvisualmoral noautolegend;
title;
panelby attribtypec / novarname sort=ascending;
vline valence / response = meanresp stat=mean markers
limitstat=stderr group=stim groupdisplay=cluster clusterwidth=0.5
grouporder=ascending name="stim";
colaxis values=("Neg" "Pos") valuesdisplay=('Neg' 'Pos') label=" ";
rowaxis max=7 label='Morality Ratings';
keylegend "stim" / position=bottom;
run;
title;
ods graphics off;
ods listing close;


/* visual study likability ratings */
proc sort data=visualtaskfull;
by id attribtypec valence stim;
run;
proc summary data=visualtaskfull mean;
by id attribtypec valence stim;
var like_resp;
output out=meanvisuallike mean=meanresp;
run;


ods listing style=olfactory gpath='../output/figures' image_dpi=300;
ods graphics on /imagefmt=pdf;
proc sgpanel data=meanvisuallike noautolegend;
title;
panelby attribtypec / novarname sort=ascending;
vline valence / response = meanresp stat=mean markers
limitstat=stderr group=stim groupdisplay=cluster clusterwidth=0.5 
grouporder=ascending name="stim";
colaxis values=("Neg" "Pos") valuesdisplay=('Neg' 'Pos') label=" ";
rowaxis max=7 label='Likability Ratings' ;
keylegend "stim" / position=bottom;
run;
title;
ods graphics off;
ods listing close;


/* visual study manipulation check barchart */
data vsl;
set visualselfreportlong;
if period eq "Before" then t=0;
if period eq "After" then t=1;
run;

ods listing style=olfactory gpath='../output/figures' image_dpi=300;
ods graphics on /imagefmt=pdf ;
proc sgpanel data=visualselfreportlong noautolegend;
title;
panelby emotion / novarname layout=columnlattice onepanel
colheaderpos=top rows=1 headerattrs=(size=13.5);
vline period / response=selfreport stat=mean limitstat=stderr markers
group=stim groupdisplay=cluster grouporder=ascending name="stim";
rowaxis label='Mean Rating';
colaxis values=("Before" "After") valuesdisplay=("Before" "After") label=' ';
keylegend "stim" / position=bottom;
run;
title;
ods graphics off;
ods listing close;

/* visual study line chart emg */
ods listing style=olfactory gpath='../output/figures' image_dpi=300;
ods graphics on /imagefmt=pdf ;
proc sgplot data=visualemg noautolegend;
vline trial / response=emg stat=mean limitstat=stderr 
group=stim markers name="stim";
xaxis label="Trial";
yaxis label="EMG Response (mV)";
keylegend "stim" / position=top;
where stim not eq "CS+" and stim not eq "CS-";
run; 
title;
ods graphics off;
ods listing close;

/* visual barchart emg */ 
ods listing style=olfactory gpath='../output/figures' image_dpi=300;
ods graphics on /imagefmt=pdf ;
proc sgplot data=visualemg noautolegend;
vbar stim / response=emg stat=mean limitstat=stderr name="stim";
xaxis label="Trial";
yaxis label="EMG Response (mV)";
keylegend "stim" / position=top;
run;
title;
ods graphics off;
ods listing close;

/* test crombach's alpha for all emotion deltas*/
/* re-code happiness */
data olfacselfreportsmall2;
set olfacselfreportsmall;
ddhaprev = -ddhap;
run;

proc corr data=olfacselfreportsmall2 spearman pearson alpha plots=matrix;
var dddisg ddangr ddanx ddsad ddhap;
where id not in (1001 2002 2009);
run;

/* test crombach's alpha for all emotion deltas but happiness*/
proc corr data=olfacselfreportsmall spearman pearson alpha plots=matrix;
var dddisg ddangr ddanx ddsad;
where id not in (1001 2002 2009);
run;

/* test glm with avscore as predictor of trait attributions */
proc glm data=olfacselfreportsmall plots=ancovaplot;
model ddispsit = avscoreavoid/ solution clparm;
where id not in (1001 2002 2009);
run;

/* linear regression plot with avscore as predictor of trait attributions */
ods listing gpath='../output/figures' style=olfactory image_dpi=300;
ods graphics on /imagefmt=pdf;
proc sgplot data=olfacselfreportsmall;
reg x=avscoreavoid y=ddispsit /  name='scatter' lineattrs=(color=black thickness=4) clm clmattrs=(clmfillattrs=CXBFBFBF) jitter;
yaxis label='Difference in % Trait Attributions' values=(-0.2 0 0.2 0.4) valuesdisplay=("-20" "0" "20" "40");
xaxis label ='Difference in Negative Emotions' ;
keylegend 'scatter' / position=top;  
run;
ods graphics off;
ods listing close;

/* olfactory manipulation check, odor */
proc means data=olfacselfreportsmall;
var smelldisgusting smellintens smellnegpos;
where id not in (2002 2009);
run;

/* olfactory manipulation check dot plots */
ods listing style=olfactory gpath='../output/figures' image_dpi=300;
ods graphics on /imagefmt=pdf ;
proc sgpanel data=olfacselfreport noautolegend;
title;
panelby emotion / novarname  layout=columnlattice onepanel
colheaderpos=top rows=1 spacing=0 noborder
headerattrs=(size=13.5);
vline time / response=selfreport  stat=mean limitstat=stderr markers 
group=stim groupdisplay=cluster grouporder=ascending name="stim" ;
rowaxis label='Mean Rating';
colaxis values=("Before" "After") valuesdisplay=("Before" "After") label=' ';
keylegend "stim" / position=bottom;
run;
title;
ods graphics off;
ods listing close;


/* manipulation check in olfactory study */
proc mixed data=olfacselfreport covtest plots=residualpanel;
class id stim time emotion;
model selfreport = stim|time|emotion / s ddfm=kr;
random int emotion stim time / subject=id;
*random int / subject=paradigm;
*random int /subject=emotionn;
repeated / subject=id type=csh;

lsmestimate stim*time*emotion 
'ang' 1  0  0 0  0 -1  0 0  0  0 -1 0  0  0  0 1,
'anx' 0  1  0 0  0  0 -1  0 0  0  0 -1 0  0  0  0 1,
'dis' 0  0  1  0 0  0  0 -1  0 0  0  0 -1 0  0  0  0 1,
'hap' 0  0  0  1  0 0  0  0 -1  0 0  0  0 -1 0  0  0  0 1,
'sad' 0  0  0  0  1  0 0  0  0 -1  0 0  0  0 -1 0  0  0  0 1
/adjdfe=row adjust=bon elsm;

lsmestimate stim*time*emotion 
'ang>hap' 1  0  0  -1  0  -1   0  0  1  0  -1  0  0  1  0  1  0  0  -1  0,
'anx>hap' 0  1  0  -1  0   0  -1  0  1  0   0 -1  0  1  0  0  1  0  -1  0,
'dis>hap' 0  0  1  -1  0   0   0 -1  1  0   0  0 -1  1  0  0  0  1  -1  0,
'sad>hap' 0  0  0  -1  1   0   0  0  1 -1   0  0  0  1 -1  0  0  0  -1  1

 /adjdfe=row adjust=bon elsm;

 
*where id not in (1001 2002 2009);
where id not in (1001 2002 2009);
run;


/* olfactory trait attribution barchart */
ods listing style=olfactory gpath='../output/figures' image_dpi=300;
ods graphics on /imagefmt=pdf ;
proc sgplot data=olfactaskattr;
vbar val / response=dispsitv stat=mean limitstat=stderr group=stim  
groupdisplay=cluster grouporder=ascending name='bar';
yaxis label='% Trait Attributions';
xaxis label = '  ';
keylegend 'bar' / position=top;  
where id not in (1001 2002 2009);
run;
title;
ods graphics off;
ods listing close;


/* olfactory trait attribution dotplot */
ods listing style=olfactory gpath='../output/figures' image_dpi=300;
ods graphics on /imagefmt=pdf ;
proc sgplot data=olfactaskattr;
vline val / response=dispsitv stat=mean limitstat=stderr group=stim  
groupdisplay=cluster grouporder=ascending name='bar' markers clusterwidth=0.5;
yaxis label='% Trait Attributions';
xaxis label = '  ';
keylegend 'bar' / position=top;  
where id not in (1001 2002 2009);
run;
title;
ods graphics off;
ods listing close;

/* olfactory trait attribution dotplot, collapsed */
/* A completely unnecessary exercise */
data otmp1;
set olfactaskattr;
gr=1;
run;

data otmp2;
set olfactaskattr;
gr=2;
run;

data otmp;
set otmp1 otmp2;
run;

ods listing style=olfactory gpath='../output/figures' image_dpi=300;
ods graphics on /imagefmt=pdf;
proc sgplot data=otmp;
vline gr / response=dispsitv stat=mean limitstat=stderr lineattrs=(thickness=0) group=stim  
groupdisplay=cluster grouporder=ascending name='bar' markers clusterwidth=0.5  CATEGORYORDER=RESPASC;
yaxis label='% Trait Attributions';
xaxis label = '  ';
keylegend 'bar' / position=top;  
where id not in (1001 2002 2009);
run;
title;
ods graphics off;
ods listing close;


/* create 2 new variables: sum up negative emotions */
data olfacselfreportsmall;
set olfacselfreportsmall;
smellaversive = 9-smellnegpos;
avem = mean(ddangr,ddanx,dddisg,ddsad);
run;


proc corr data=olfacselfreportsmall pearson spearman alpha plots=matrix;
var smellintens smellnegpos smelldisgusting smellaversive avem;
where id not in (2002 2009 1001);
run;


proc sort data=olfactaskattr; by id;
proc sort data=olfacselfreportsmall; by id;
data olfactaskattr2;
merge olfactaskattr olfacselfreportsmall;
by id;
run;

/* test olfactory trait attributions as a function of valence */
proc mixed data=olfactaskattr2 covtest plots=residualpanel;
class id stim val;
model dispsitv = stim|val  / s ddfm=kr cl;
random int stim val / subject=id;
lsmestimate stim 'cs+ > cs-' -1 1 / adjdfe=row elsm cl;
where id not in (2002 2009 1001);
ods output FitStatistics=Fit2 (rename=(value=model2));
run; 


/* olfactory response times  */
proc mixed data=olfactaskfull covtest plots=residualpanel;
class id type stim valence exporder item trialtype;
model rt = realobs stim valence type / s cl ddfm=kr;
random int type / subject=item;
random int realobs type stim valence / subject=id(exporder);
lsmestimate type
'behav>like'  1 -1 0,
'behav>moral' 1 0 -1,
'moral>like'  0 1 -1 / cl elsm adjdfe=row adjust=bon;
where id not in (1001 2002 2009);
ods output FitStatistics=Fit11 (rename=(value=model11));
run;

/* olfactory morality ratings dot */
/* prepare data set */
data olfactaskfull2;
set olfactaskfull;
length val $3;
if valence eq "Positive Scenario" then val = "Pos";
if valence eq "Negative Scenario" then val = "Neg";
run;
proc sort data=olfactaskfull2;
by id type trialtype val stim trial;
proc summary data=olfactaskfull2 mean;
by id type trialtype val stim;
var resp;
output out=meanolf mean=meanresp;
where type not eq "behav";
run;



ods listing gpath='../output/figures' style=olfactory image_dpi=300;
ods graphics on /imagefmt=pdf;
proc sgpanel data=meanolf noautolegend;
title;
panelby trialtype / novarname sort=ascending;
vline val / response = meanresp stat=mean 
limitstat=stderr group=stim groupdisplay=cluster clusterwidth=0.5 markers 
grouporder=ascending name="stim";
colaxis label=" ";
rowaxis min=3 max=7 values=(3 4 5 6 7) label='Morality Ratings';
keylegend "stim" / position=bottom;
where id not in (1001 2002 2009) and type eq 'moral';
run;
ods graphics off;
ods listing close;


ods listing gpath='../output/figures' style=olfactory image_dpi=300;
ods graphics on /imagefmt=pdf;
proc sgpanel data=meanolf noautolegend;
title;
panelby trialtype / novarname sort=ascending;
vline val / response = meanresp stat=mean 
limitstat=stderr group=stim groupdisplay=cluster clusterwidth=0.5 markers 
grouporder=ascending name="stim";
colaxis label=" ";
rowaxis min=3 max=7 values=(3 4 5 6 7) label='Liking Ratings';
keylegend "stim" / position=bottom;
where id not in (1001 2002 2009) and type eq 'like';
run;
ods graphics off;
ods listing close;





/* olfactory morality ratings */
proc mixed data=olfactaskfull covtest plots=residualpanel;
class id stim valence exporder trialtype item;
model resp = obs trialtype|valence|stim / s ddfm=kr cl;
*random int  / subject=item;
random int trialtype*valence  / subject=id;
lsmestimate trialtype*valence 'disp>sit' -1 1 1 -1, 
                              'pos>neg, disp' -1 0 1,
                              'pos>neg, sit' 0 -1 0 1 
/ adjdfe=row adjust=bon elsm cl;
where id not in (1001 2002 2009) and type eq 'moral';
ods output FitStatistics=Fit3 (rename=(value=model3));
run;

/* olfactory likeability ratings */
proc mixed data=olfactaskfull covtest plots=residualpanel;
class id stim valence exporder trialtype item;
model resp = obs trialtype|valence|stim / s ddfm=kr cl;
*random int  / subject=item;
random int trialtype*valence / subject=id;
lsmestimate trialtype*valence 'disp>sit' -1 1 1 -1, 
                              'pos>neg, disp' -1 0 1,
                              'pos>neg, sit' 0 -1 0 1 
/ adjdfe=row adjust=bon elsm cl;
where id not in (1001 2002 2009) and type eq 'like';
run;

/* olfactory behavioral ratings (continuous) */
proc mixed data=olfactaskfull covtest plots=residualpanel;
class id stim valence exporder item;
model resp = valence|stim / s ddfm=kr;
random int / subject=item;
random int valence stim / subject=id(exporder);
where id not in (1001 2002 2009) and type eq 'behav';
run;


/* test betas for roi and condition */
proc mixed data=olfactaskbetas covtest plots=residualpanel;
class id roi cond;
model beta = roi|cond / ddfm=kr s cl;
repeated / subject=id type=csh;
random int / subject=id type=un;
lsmeans cond / adjust=tukey;
lsmestimate cond 'attr>enc'   0 2 0 -1 -1,
                 'attr>eval' -1 2 -1 0 0,
                 'attr>mor'  -1 1 0 0 0,
                 'attr>lik'   0 1 -1 0 0
/ adjdfe=row adjust=bon elsm cl; 
where (
	roi eq "PCC" or
	roi eq "LAG" or
	roi eq "DMPFC" or
	roi eq "RAG" or
	roi eq "VMPFC"
	) and
	(
	cond eq "BehavEnc" or
	cond eq "SitEnc" or
	cond eq "Attr" or
	cond eq "Moral" or
	cond eq "Like"
	) and
	id not in (1001 2002 2009);
run;
		

/* ppi analysis with average negative affect */
proc glm data=olfacppi;
model beta = avscore / solution clparm;
where id not in (1001 2002 2009) and cond eq "PPI" and roi eq "VMPFC-RFG";
run;

/* ppi analysis with happiness */
proc glm data=olfacppi;
model beta = ddhap / solution clparm;
where id not in (1001 2002 2009) and cond eq "PPI" and roi eq "VMPFC-RFG";
run;

/* show ppi plot */
ods listing style=olfactory gpath='../output/figures' image_dpi=300;
ods graphics on /imagefmt=pdf ;
proc sgplot data=olfacppi;
reg x=ddhap y=beta /  name='scatter' lineattrs=(color=black thickness=4) clm clmattrs=(clmfillattrs=CXBFBFBF) jitter;
yaxis label='Difference in VMPFC-RFG connectivity';
xaxis label ='Difference in Happiness' ;
keylegend 'scatter' / position=top;  
where id not in (1001 2002 2009) and cond eq "PPI" and roi eq "VMPFC-RFG";
run;
title;
ods graphics off;
ods listing close;

proc sort data=olfactaskbetas; by id roi cond;
proc sort data=olfacselfreportsmall; by id;
data olfactaskbetasext;
merge olfactaskbetas olfacselfreportsmall;
by id;
run;

proc sort data=olfactaskbetasext; by cond roi;
proc corr data=olfactaskbetasext pearson spearman;
by cond roi;
var beta smelldisgusting smellintens smellnegpos smellav diffavappr avscoreavoid;
where id not in (1001 2002 2009);
run;



proc sort data=olfactasklosobetas;
by method;
ods listing gpath='../output/figures' style=olfactory image_dpi=300;
ods graphics on /imagefmt=pdf;
%sganno;
data sgannodata;
%sgtext (width=100, x1=0, y1=58, label="CS+ minus CS-", justify="center", rotate=90, textweight="bold");
%sgtext (width=100, x1=4, y1=58, label="Beta Estimates (a.u.)", justify="center", rotate=90, textweight="bold");
data olfactasklosobetas;
set olfactasklosobetas;
length roiupper $6;
if roi eq "vmpfc" then roiupper="VMPFC";
if roi eq "rag" then roiupper="RAG";

proc sgpanel data=olfactasklosobetas noautolegend sganno=sgannodata;
title;
panelby roiupper / novarname sort=ascending spacing=30 noborder;
vline cond / response = beta stat=mean 
limitstat=stderr markers name="stim" lineattrs=(thickness=0) markerattrs=(size=12);
colaxis values=("behav" "sit" "attrib" "moral" "like") label=" ";
rowaxis label=' '; *display=(noline);
refline 0 / axis=y lineattrs=(pattern=2 color="black" thickness=1.2);
*keylegend "stim" / position=bottom;
*where id not in (1001 2002 2009) and type eq 'like';
run;
ods graphics off;
ods listing close;



proc sort data=olfactasklosobetas;
by method;
ods listing gpath='../output/figures' style=olfactory image_dpi=300;
ods graphics on /imagefmt=pdf;
%sganno;
data sgannodata;
%sgtext (width=100, x1=0, y1=58, label="CS+ minus CS-", justify="center", rotate=90, textweight="bold");
%sgtext (width=100, x1=4, y1=58, label="Beta Estimates (a.u.)", justify="center", rotate=90, textweight="bold");
data olfactasklosobetas;
set olfactasklosobetas;
length roiupper $6;
if roi eq "vmpfc" then roiupper="VMPFC";
if roi eq "rag" then roiupper="RAG";

proc sgpanel data=olfactasklosobetas noautolegend sganno=sgannodata;
title;
panelby roiupper / novarname sort=ascending spacing=30 noborder;
vbar cond / response = beta stat=mean 
limitstat=stderr name="stim" fillattrs=(color="ligrybr");
colaxis values=("behav" "sit" "attrib" "moral" "like") label=" ";
rowaxis label=' '; *display=(noline);
refline 0 / axis=y lineattrs=(pattern=2 color="black" thickness=1.2);
*keylegend "stim" / position=bottom;
*where id not in (1001 2002 2009) and type eq 'like';
run;
ods graphics off;
ods listing close;

proc sort data=olfactasklosobetas;
by roi id;
run;
proc mixed data=olfactasklosobetas covtest;
by roi;
class id cond roi method;
model beta = cond/ s;
*random int cond / subject=id;
repeated / subject=id type=csh;
where id not in (1001 2002 2009) and method eq "loso";
lsmeans cond / adjust=tukey;
*lsmestimate cond 'attr>enc'   0 2 0 -1 -1;
run;

proc print data=olfactasklosobetas;
run;

proc sort data=olfactasklosobetas; by id;
proc sort data=o; by id;
data ob;
merge olfactasklosobetas o;
by id;
run;

proc print data=ob;
run;

ods graphics on;
proc sort data=ob; by roi;
proc corr data=ob pearson spearman plots=all;
by roi;
var beta ddanxious ddsad dispperc avscore dddisgust ddangry ddhappy;
where id not in (1001 2002 2009) 
and cond eq "attrib" and method eq "loso";
run;
ods graphics off;
