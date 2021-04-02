* Stability of traits

* Kiss Hubert János - Szabó-Morvai Ágnes

* 2018-05-25

* Lasso to find which variables predict best LoC
* https://www.youtube.com/watch?v=efYBzFcKWn8&feature=youtu.be

* On the stata lasso packages:
* https://statalasso.github.io/docs/estimators/

global origdata "C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Adat\Eletpálya_adatok"
global newdata "C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Adat\Traitsdata"
global results "C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Eredmények\2021"
global graphlib "C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Paper_1\Graphs"
global graphlib2 "C:\Users\szabomorvai.agnes\Dropbox\Apps\Overleaf\Locus of control (Copy)"
global dolib "C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Do\Do_2020"
global overleaf "C:\Users\szabomorvai.agnes\Dropbox\Apps\Overleaf\Locus of control (Copy)"

clear

use $newdata\eletpalya_for_regs_vars_2021, clear

* Control varlist for LOC_2006
global varlist06 i.regio moth_* fath_* acognisc  aemotisc sleepwith_06* hhsize    social_disad* i.mothwork_06* i.fathwork_06* fin_dist* female /*i.t1ho*/  mother* father* snix sniszam letszam hhinc_06	childcare* tales* amkor* amkor_sq abuse_b14* /*height_06 height06Xfemale weight_06*/ divorce_06 roma_07 bw_u2500* sochome_06* stepparents* ed* parent_*

global channels06   subjhealth_06* emot_stability_06* self_esteem_06* bullying_06* sociable_06* objhealth*06* health*06* work_06* swork_06* retention_06 fire_06 age ret*
* Control varlist for LOC_2009
global varlist09 $varlist06 sleepwith_* abuse_a14* death_* accident_* illness_* /*height_12 height12Xfemale weight_**/ i.mothwork* i.fathwork*  hhinc_*

global channels09 $channels06 event_num pos_event_num  neg_event_num   subjhealth_*06* subjhealth_*08* emot_stability_*  bullying_* sociable_* objhealth* health* school_env_08* study_time*  swork_*06* swork_*07* swork_*08* work_*06* work_*07* work_*08*  lost_job_*07* lost_job_*08* /*unemp_**/  childbirth_*07* childbirth_*08*  new_job_*07* new_job_*08* posexp_gen_08* /*posexp_sch_08**/ drugenv_08* numfriend_08* sex_08* drug_08* bullying_08*    firstchild_age relig_07 lookgood_08*

global locvars loc_06 loc_09 
global cogn o m 
global effort study_time* sedul*07* sedul*08*  night_study* weekend_study*
global expect exp_*08*

global outlist maturex  univapp_plan uni_enrol univ_if_plan


*******************************************************************
*******************************************************************
*******************************************************************
/*
1. loc

2. exogenous + loc 

3. exogenous + loc + cogn

4. exogenous + loc + cogn+ effort

5. exogenous + loc + cogn + exp

6. exogenous + loc + cogn + effort + exp

7. exogenous + loc + cogn + effort + exp + channels
*/
global list1 
global list2 $varlist09 
global list3 $varlist09 $cogn 
global list4 $varlist09 $cogn $expect 
global list5 $varlist09 $cogn $effort 
global list6 $varlist09 $cogn $expect $effort 
global list7 $varlist09 $cogn $expect $effort $channels09
global list8 $varlist09 $cogn $channels09


******************************************
* TEST DIFF EXP EFF
* test using p14 of this: https://www.stata.com/manuals13/rsuest.pdf
********************************************

global uni_enrol_1		loc_09																														
global uni_enrol_2		loc_09		moth_lowed		moth_fath_educ		acognisc		abuse_b14		parent_ideal_06		parent_min_06																		
global uni_enrol_3		loc_09		moth_lowed		moth_fath_educ		acognisc		abuse_b14		parent_ideal_06		parent_min_06		o		m														
global uni_enrol_4		loc_09		moth_lowed		moth_fath_educ		acognisc		abuse_b14		parent_ideal_06		parent_min_06		o		m		exp_sal_avg_08		exp_sal_100net_08		exp_sal_200net_08								
global uni_enrol_5		loc_09		moth_lowed		moth_fath_educ		acognisc		abuse_b14		parent_ideal_06		parent_min_06		o		m		study_time_07		study_time_08		sedulity_07		sedulity_08						
global uni_enrol_6		loc_09		moth_lowed		moth_fath_educ		acognisc		abuse_b14		parent_ideal_06		parent_min_06		o		m		exp_sal_avg_08		exp_sal_100net_08		exp_sal_200net_08		study_time_07		study_time_08		sedulity_07		sedulity_08


global univapp_plan_1		loc_09																																		
global univapp_plan_2		loc_09		moth_lowed		moth_highed		moth_fath_educ		acognisc		letszam		abuse_b14		parent_ideal_06		parent_min_06		parent_pay_06																
global univapp_plan_3		loc_09		moth_lowed		moth_highed		moth_fath_educ		acognisc		letszam		abuse_b14		parent_ideal_06		parent_min_06		parent_pay_06		o		m												
global univapp_plan_4		loc_09		moth_lowed		moth_highed		moth_fath_educ		acognisc		letszam		abuse_b14		parent_ideal_06		parent_min_06		parent_pay_06		o		m		exp_sal_avg_08		exp_sal_100net_08		exp_sal_200net_08						
global univapp_plan_5		loc_09		moth_lowed		moth_highed		moth_fath_educ		acognisc		letszam		abuse_b14		parent_ideal_06		parent_min_06		parent_pay_06		o		m		study_time_08		sedulity_07		sedulity_08						
global univapp_plan_6		loc_09		moth_lowed		moth_highed		moth_fath_educ		acognisc		letszam		abuse_b14		parent_ideal_06		parent_min_06		parent_pay_06		o		m		exp_sal_avg_08		exp_sal_100net_08		exp_sal_200net_08		study_time_08		sedulity_07		sedulity_08


global dropout_age_1	loc_09																																																		
global dropout_age_2	loc_09		moth_lowed		acognisc		social_disad		i.fathwork_06		fin_dist_09		abuse_b14		ed_fa_mo_mid		parent_ideal_06		parent_pay_06		i.mothwork_09																														
global dropout_age_3	loc_09		moth_lowed		acognisc		social_disad		i.fathwork_06		fin_dist_09		abuse_b14		ed_fa_mo_mid		parent_ideal_06		parent_pay_06		i.mothwork_09		o		m																										
global dropout_age_4	loc_09		moth_lowed		acognisc		social_disad		i.fathwork_06		fin_dist_09		abuse_b14		ed_fa_mo_mid		parent_ideal_06		parent_pay_06		i.mothwork_09		o		m		exp_sal_avg_08		exp_empl_08		exp_sal_100net_08		exp_sal_200net_08																		
global dropout_age_5	loc_09		moth_lowed		acognisc		social_disad		i.fathwork_06		fin_dist_09		abuse_b14		ed_fa_mo_mid		parent_ideal_06		parent_pay_06		i.mothwork_09		o		m		study_time_07		study_time_08		sedulity_07		sedulity_08		sedulity_08_imp		night_study_08		night_study_08_imp		weekend_study_07_imp		weekend_study_08_imp								
global dropout_age_6	loc_09		moth_lowed		acognisc		social_disad		i.fathwork_06		fin_dist_09		abuse_b14		ed_fa_mo_mid		parent_ideal_06		parent_pay_06		i.mothwork_09		o		m		exp_sal_avg_08		exp_empl_08		exp_sal_100net_08		exp_sal_200net_08		study_time_07		study_time_08		sedulity_07		sedulity_08		sedulity_08_imp		night_study_08		night_study_08_imp		weekend_study_07_imp		weekend_study_08_imp



global maturex_1		loc_09																																														
global maturex_2		loc_09		moth_lowed		fath_lowed		fath_mided		acognisc		social_disad		snix		abuse_b14		roma_07		parent_ideal_06		parent_pay_06		i.mothwork_09																								
global maturex_3		loc_09		moth_lowed		fath_lowed		fath_mided		acognisc		social_disad		snix		abuse_b14		roma_07		parent_ideal_06		parent_pay_06		i.mothwork_09		o		m																				
global maturex_4		loc_09		moth_lowed		fath_lowed		fath_mided		acognisc		social_disad		snix		abuse_b14		roma_07		parent_ideal_06		parent_pay_06		i.mothwork_09		o		m		exp_sal_avg_08		exp_sal_100net_08		exp_sal_200net_08														
global maturex_5		loc_09		moth_lowed		fath_lowed		fath_mided		acognisc		social_disad		snix		abuse_b14		roma_07		parent_ideal_06		parent_pay_06		i.mothwork_09		o		m		study_time_07		study_time_08		sedulity_07		sedulity_08		night_study_08		night_study_08_imp		weekend_study_08_imp						
global maturex_6		loc_09		moth_lowed		fath_lowed		fath_mided		acognisc		social_disad		snix		abuse_b14		roma_07		parent_ideal_06		parent_pay_06		i.mothwork_09		o		m		exp_sal_avg_08		exp_sal_100net_08		exp_sal_200net_08		study_time_07		study_time_08		sedulity_07		sedulity_08		night_study_08		night_study_08_imp		weekend_study_08_imp


$outlist

foreach var of varlist uni_enrol  {

disp "`var'"
reg  `var'  ${`var'_3} if sample == 1  [weight = weight]
est sto M3

reg  `var'  ${`var'_4} if sample == 1  [weight = weight]
est sto M4

reg  `var'  ${`var'_5} if sample == 1  [weight = weight]
est sto M5

reg  `var'  ${`var'_6} if sample == 1  [weight = weight]
est sto M6


suest M3 M4
test [M3_mean]loc_09=[M4_mean]loc_09

suest M3 M5
test [M3_mean]loc_09=[M5_mean]loc_09

suest M4 M6
test [M4_mean]loc_09=[M6_mean]loc_09

suest M5 M6
test [M5_mean]loc_09=[M6_mean]loc_09

}

*******************************************************

logit y1 x1
estimates store M1
logit y2 x2
estimates store M2
suest M1 M2
test [M1]x1=[M2]x2





************************************************************************************************************************
* CORR EXP EFF*
******************

* Piatek-Pinger 751



foreach var of varlist $outlist {
foreach i in  6 9 {
	local label : variable label `var'
twoway qfitci `var' loc_0`i', ytitle("`label'")
	graph export "$overleaf\probgraph_all_`var'_loc0`i'.pdf", replace
	graph export "$results\probgraph_all_`var'_loc0`i'.pdf", replace
twoway qfitci `var' loc_0`i', by(female) ytitle("`label'")
	graph export "$overleaf\probgraph_fem_`var'_loc0`i'.pdf", replace
	graph export "$results\probgraph_fem_`var'_loc0`i'.pdf", replace
twoway qfitci `var' loc_0`i', by(desc_mothereduc, title("")) ytitle("`label'")
	graph export "$overleaf\probgraph_mothed_`var'_loc0`i'.pdf", replace
	graph export "$results\probgraph_mothed_`var'_loc0`i'.pdf", replace
}
}

pwcorr exp_sal_avg_08 exp_sal_10pct_08 exp_empl_08 exp_sal_100net_08 exp_sal_200net_08 expectations_08  study_time_08 sedulity_08 night_study_08 weekend_study_08 effort_08, sig

desc exp_sal_avg_08 exp_sal_10pct_08 exp_empl_08 exp_sal_100net_08 exp_sal_200net_08 expectations_08  study_time_08 sedulity_08 night_study_08 weekend_study_08 sedulity_09 effort_08


pwcorr desc_mothereduc acognisc  aemotisc  o expectations_08 effort_08, sig


*************************
* DESCRIPTIVE STATS
**************************

* Describe LoC
tab ad036axx
tab ad036bxx
tab ad036cxx
tab ad036dxx
tab df2a
tab df2b
tab df2c
tab df2d

* Describe HOME
forval i = 1/13 {
	tab acogni`i'	
	}
	
forval i = 1/14 {
	tab aemoti`i'	
	}
	
	
* LoC changes
lab var t2 "Gender of the respondent"
lab def t2_v 0 "Male" 1 "Female"
lab val t2 t2_v  
hist delta_loc_09, by(t2)
graph export $latex\figures\locchange.pdf




* Descriptive statistics of the control variables

fsum loc_06 loc_09  delta_loc_09  $expect $effort $varlist09  regio mothwork_* fathwork_* $channels09 , label catvar(regio mothwork_* fathwork*)
fsum o m, label 

* Kolmogoro-Smirnov test
use $newdata\eletpalya_for_regs_vars, clear

keep azon loc_*
greshape long loc_0, i(azon) j(year)

ksmirnov loc_0, by(year) exact


* WILCOXON-FÉLE SIGNED-RANK TEST
use $newdata\eletpalya_for_regs_vars, clear
signrank loc_06 = loc_09
signtest loc_06 = loc_09



* Piatek-Pinger 751



foreach var of varlist $outlist {
foreach i in  6 9 {
	local label : variable label `var'
twoway qfitci `var' loc_0`i', ytitle("`label'")
	graph export "$overleaf\probgraph_all_`var'_loc0`i'.pdf", replace
	graph export "$results\probgraph_all_`var'_loc0`i'.pdf", replace
twoway qfitci `var' loc_0`i', by(female) ytitle("`label'")
	graph export "$overleaf\probgraph_fem_`var'_loc0`i'.pdf", replace
	graph export "$results\probgraph_fem_`var'_loc0`i'.pdf", replace
twoway qfitci `var' loc_0`i', by(desc_mothereduc, title("")) ytitle("`label'")
	graph export "$overleaf\probgraph_mothed_`var'_loc0`i'.pdf", replace
	graph export "$results\probgraph_mothed_`var'_loc0`i'.pdf", replace
}
}


* LOC simple
tab loc_simp_06 loc_simp_09


*Effort vs expectationseffort_07
global locvars loc_06 loc_09 
global cogn o m 
global effort study_time* sedul*07* sedul*08*  night_study* weekend_study*
global expect exp_*08*

corr $outlist loc_0* o m  expectations_08 expectations_12 effort_0*

****************************
*******************************
* Descriptive stats

global desc loc_09 gpa_07 o m female moth_lowed moth_mided moth_highed hhinc_06 acognisc  aemotisc expectations_08 exp_sal_avg_08  exp_empl_08 effort_07 study_time_07 sedulity_07 parent_pay_06 parent_min_06 parent_ideal_06

mean $desc [weight = weight]
*univapp_plan uni_enrol dropout_age maturex  
tabstat $desc [weight = weight], by(univapp_plan)  c(s)
tabstat $desc [weight = weight], by(uni_enrol)  c(s)
tabstat $desc [weight = weight], by(maturex)  c(s)


gegen dropout_median = median(dropout_age)
gen drop_above = dropout_age >=  dropout_median

tabstat $desc [weight = weight], by(drop_above)  c(s)


* Új táblázat az Effort cikkhez
xtile o_quart = o, n(4)
xtile expectations_08_quart = expectations_08, n(4)
xtile effort_08_quart = effort_08, n(4)
xtile loc_09_med = loc_09, n(2)


tabstat $outlist [weight = weight], by(desc_mothereduc)  
tabstat $outlist [weight = weight], by(o_quart)
tabstat $outlist [weight = weight], by(expectations_08_quart)
tabstat $outlist [weight = weight], by(effort_08_quart)
tabstat $outlist [weight = weight], by(loc_09_med)
  

