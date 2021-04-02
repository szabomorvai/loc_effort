* Stability of trats

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

global outlist dropout_age maturex  univapp_plan uni_enrol 


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

**********************************************************
* LASSO PDS  


global out "outreg2 using "$results\lassoreg_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N)" 
global out2	"outreg2 using "$results\Rsquared_insample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_in, e(r2)) stats(coef se N) keep(loc_09)"
global out3	"outreg2 using "$results\Rsquared_outofsample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_out, e(r2)) stats(coef se N) keep(loc_09)"



foreach var of varlist $outlist  {
	forval i = 1/7 {
		pdslasso  `var' loc_09 ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		$out

	* R-sq
	do $dolib\Rsq.do
	reg `var' $clist if sample == 1  [weight = weight], robust cluster(omid)
	est sto olsin_`var'_0
	$out2
	reg `var' $clist if sample == 2  [weight = weight], robust cluster(omid)
	est sto olsout_`var'_0
	$out3
	}
}


* Graphs
/*
	coefplot (univapp_plan_1, label(Exogenous)) (univapp_plan_2, label(Exog + Cognitive)) (univapp_plan_3, label(Exog + Cogn + Expectations)) (univapp_plan_4, label(Exog + Cogn + Effort)) (univapp_plan_5, label(Exog + Cogn + Exp + Effort)) (univapp_plan_6, label(Exog + Cogn + Exp + Eff + Channels)), bylabel(Application Plan) ///
	|| (dropout_age_1) (dropout_age_2) (dropout_age_3) (dropout_age_4) (dropout_age_5) (dropout_age_6), bylabel(Dropout age) ///
	||, keep(loc_09)  bycoefs yline(0) cismooth grid(none) xline(0) title(Point estimates for LoC (2009)) mlabposition(1) mlabgap(*2) mlabel("{it:p}="+ string(@pval,"%9.3f")) 
	graph export "$overleaf\lassoreg_graph_1.pdf", replace
	

	coefplot (univ_app_1, label(Exogenous)) (univ_app_2, label(Exog + Cognitive)) (univ_app_3, label(Exog + Cogn + Expectations)) (univ_app_4, label(Exog + Cogn + Effort)) (univ_app_5, label(Exog + Cogn + Exp + Effort)) (univ_app_6, label(Exog + Cogn + Exp + Eff + Channels)), bylabel(Application) ///
	|| (maturex_1) (maturex_2) (maturex_3) (maturex_4) (maturex_5) (maturex_6), bylabel(Maturity Exam) ///
	||, keep(loc_09)  bycoefs yline(0) cismooth grid(none) xline(0) title(Point estimates for LoC (2009)) mlabposition(1) mlabgap(*2) mlabel("{it:p}="+ string(@pval,"%9.3f"))
	graph export "$overleaf\lassoreg_graph_2.pdf", replace
	*/

****************************************
* HISTOGRAMS
****************************************

use $newdata\eletpalya_for_regs_vars, clear
preserve
keep azon loc_06 loc_09
reshape long loc_0, i(azon) j(year) 
lab var loc_0 "LoC"
twoway (histogram loc_0 if year == 6,  width(.3) color(navy)) ///
       (histogram loc_0 if year == 9,  width(.3) fcolor(none) lcolor(red)), legend(order(1 "Year: 2006" 2 "Year: 2009" )) name(fig1, replace)
restore

preserve
hist delta, by(female) w(.5)
twoway (histogram delta_loc_09 if female==1,  width(.3) color(navy)) ///
       (histogram delta_loc_09 if female==0,  width(.3) fcolor(none) lcolor(red)), legend(order(1 "Female" 2 "Male" )) name(fig2, replace)
	   
graph combine fig1 fig2
	graph export $graphlib\stability.pdf, replace
	graph export "$overleaf\stability.pdf", replace
restore



**********************************************************
* LASSO PSD   -- EFFORT, EXPECTATIONS


global out "outreg2 using "$results\exp_eff_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 
global out2	"outreg2 using "$results\exp_eff_rsq_insample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_in, e(r2)) stats(coef se N)"
global out3	"outreg2 using "$results\exp_eff_rsq_outofsample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_out, e(r2)) stats(coef se N)"
***************
*EXPECTATIONS
**************
*est drop *

foreach var of varlist expectations_12 {
	foreach i in 1 2 3 8  {
		pdslasso  `var' loc_09 ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		$out

	* R-sq
	do $dolib\Rsq.do
	reg `var' $clist if sample == 1  [weight = weight], robust cluster(omid)
	est sto olsin_`var'_0
	$out2
	reg `var' $clist if sample == 2  [weight = weight], robust cluster(omid)
	est sto olsout_`var'_0
	$out3
	}
}


**********
* EFFORT	
**********
foreach var of varlist effort_07 effort_08 effort_07_08_09 {
	foreach i in 1 2 3 8  {
		pdslasso  `var' loc_06 ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		$out

	* R-sq
	do $dolib\Rsq.do
	reg `var' $clist if sample == 1  [weight = weight], robust cluster(omid)
	est sto olsin_`var'_0
	$out2
	reg `var' $clist if sample == 2  [weight = weight], robust cluster(omid)
	est sto olsout_`var'_0
	$out3
	}
}

**************************************
* LASSOKILL -  Adding vars one by one - to kill loc effect

* !!!! itt valami nem jó. a Lassokillnél a végső regresszió ugyanaz, mint az alap regresszióknál, de nem ugyanazok a mért paraméterek
foreach var of varlist $outlist {
global out "outreg2 using "$results\lassokill_`var'_$S_DATE.xls", coefastr bracket append label bdec(3) tdec(3)  " 
	pdslasso `var' loc_09 ( $list7 ) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_6
	mat B=e(b)
	mat list B
	local clist
	tokenize "`: colnames e(b)'"

forval j = 1/`= colsof(B)' {
 if B[1, `j'] != 0 & index("``j''","_cons")==0 {
 local clist `clist' ``j''
	reg `var' `clist' if sample == 1  [weight = weight], robust cluster(omid)
	est sto olsin_`var'_6
	$out
	*di "`clist'"

  }
 }
}
	


*********************************************
**********************************************************
	

********************************************************
********************************************************
* HETEROGENEITY
********************************************************
********************************************************

* BY GENDER

global out_fem0 "outreg2 using "$results\heterog_fem0_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N) keep(loc_09)"
global out_fem1 "outreg2 using "$results\heterog_fem1_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N) keep(loc_09)"

foreach var of varlist $outlist {
		foreach i in 0 1 {
		forval k = 1/7 {
		pdslasso  `var' loc_09 ( ${list`k'}) if sample == 1 & female == `i' [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		${out_fem`i'}
		}
	}
}
	


* BY MOTHER HIGHEST EDUCATION

global out_moth_lowed "outreg2 using "$results\heterog_moth_low_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N) keep(loc_09)"
global out_moth_mided "outreg2 using "$results\heterog_moth_mid_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N) keep(loc_09)"
global out_moth_highed "outreg2 using "$results\heterog_moth_high_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N) keep(loc_09)"

foreach var of varlist $outlist {
	foreach i of varlist moth_lowed moth_mided moth_highed {
		forval k = 1/7 {
		pdslasso  `var' loc_09 ( ${list`k'}) if sample == 1 & `i' == 1 [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		${out_`i'}
		}
	}
}
	


* BY HOUSEHOLD INCOME
*gen inchigh = hhinc_07 > 185000
*drop inchigh

global out_inchigh0 "outreg2 using "$results\heterog_verylow_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"
global out_inchigh1 "outreg2 using "$results\heterog_veryhigh_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"

foreach var of varlist $outlist {
	foreach i in 0 1 {
		forval k = 1/7 {
		pdslasso  `var' loc_09 ( ${list`k'}) if sample == 1 & inchigh == `i' [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		${out_inchigh`i'}
		}
	}
}
	

* BY HOUSEHOLD INCOME and gender
*gen inchigh = hhinc_07 > 185000
*drop inchigh

global out_inchigh0fem0 "outreg2 using "$results\heterog_verylow_fem0_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"
global out_inchigh1fem0 "outreg2 using "$results\heterog_veryhigh_fem0_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"
global out_inchigh0fem1 "outreg2 using "$results\heterog_verylow_fem1_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"
global out_inchigh1fem1 "outreg2 using "$results\heterog_veryhigh_fem1_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"

foreach var of varlist $outlist {
	foreach i in 0 1 {
	foreach j in 0 1 {
		forval k = 1/7 {
		pdslasso  `var' loc_09 ( ${list`k'}) if sample == 1 & inchigh == `i' & female == `j' [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		${out_inchigh`i'fem`j'}
		}
	}
}
}	

* BY MOTHERS EDUC and gender
*gen inchigh = hhinc_07 > 185000
*drop inchigh

global out_moth_lowedfem0 "outreg2 using "$results\heterog_mothlow_fem0_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"
global out_moth_lowedfem1 "outreg2 using "$results\heterog_mothlow_fem1_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"
global out_moth_midedfem0 "outreg2 using "$results\heterog_mothmid_fem0_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"
global out_moth_midedfem1 "outreg2 using "$results\heterog_mothmid_fem1_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"
global out_moth_highedfem0 "outreg2 using "$results\heterog_mothhigh_fem0_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"
global out_moth_highedfem1 "outreg2 using "$results\heterog_mothhigh_fem1_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N) keep(loc_09)"

foreach var of varlist $outlist {
	foreach i of varlist moth_lowed moth_mided moth_highed {
	foreach j in 0 1 {
		forval k = 1/7 {
		pdslasso  `var' loc_09 ( ${list`k'}) if sample == 1 & `i' == 1 & female == `j' [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		${out_`i'fem`j'}
		}
	}
}
}	
	
	

	
* HETEROGENEITY - HEATMAPS

* lefuttatni minden grid point-ra 
* elmenteni az együtthatót
* ábrázolni
foreach var of varlist $outlist {
	foreach i of varlist moth_lowed moth_mided moth_highed {
	foreach j in 0 1 {
		forval k = 1/7 {
		pdslasso  `var' loc_09 ( ${list`k'}) if sample == 1 & `i' == 1 & female == `j' [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		${out_`i'fem`j'}
		}
	}
}
}	




preserve
collapse univapp_plan , by( mothed hhinc_07)
twoway contour univapp_plan hhinc_07 mothed, heatmap
restore

twoway contour univapp_plan loc_09 fathed, interp(shepard) heatmap
twoway contour uni_enrol loc_09 mothed
twoway contour uni_enrol loc_09 fathed, interp(shepard) 
twoway contour maturex loc_09 mothed, interp(shepard) 

corr univapp_plan loc_09 hhinc_07

********************************************************************
* LOC_2006; LOC_2009; DELTA LOC - WHICH ONE TO INCLUDE? 

* a: loc_09
* b: loc_06
* c: loc_09 delta_loc_09
* d: loc_06 loc_09 delta_loc_09

global outa "outreg2 using "$results\lasso_a_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 
global outb "outreg2 using "$results\lasso_b_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 
global outc "outreg2 using "$results\lasso_c_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 
global outd "outreg2 using "$results\lasso_d_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 
global oute "outreg2 using "$results\lasso_e_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 
global outf "outreg2 using "$results\lasso_f_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 



foreach var of varlist $outlist {
	forval i = 1/7 {
		pdslasso  `var' loc_09 ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_0
		$outa
		
		pdslasso  `var' loc_06  ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_0
		$outb

		pdslasso  `var' loc_09  (delta_loc_09 ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_0
		$outc

		pdslasso  `var' loc_09  (loc_06 delta_loc_09 ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_0
		$outd

		pdslasso  `var' loc_06 delta_loc_09  ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_0
		$oute

		pdslasso  `var' loc_09  (loc_06 ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_0
		$outf

	}
}

* HETEROGENEITY ALONG DELTA VALUES

gen delta_small = abs(delta_loc_09) <1  
gen delta_negative = delta_loc_09 < 0
global out_small "outreg2 using "$results\lasso_deltaheter_small_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 

foreach var of varlist $outlist  {
    forval k = 0/1 {
		forval i = 1/7 {
		pdslasso  `var' loc_09 ( ${list`i'}) if sample == 1 & delta_small == `k' [weight = weight], robust cluster(omid)
		estimates store `var'_`i'_`k'
		$out_small
		}
	}
}

global out_neg "outreg2 using "$results\lasso_deltaheter_neg_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 

foreach var of varlist $outlist {
    forval k = 0/1 {
		forval i = 1/7 {
		pdslasso  `var' loc_09 ( ${list`i'}) if sample == 1 & delta_negative == `k' [weight = weight], robust cluster(omid)
		estimates store `var'_`i'_`k'
		$out_neg
		}
	}
}



************************************
* IV - using exogenous negative events
*************************************
gen deathorill_08 = death_08 + illness_08
mean(delta_loc_09), over(deathorill_08)
tab deathorill_08 desc_moth*, col
mean(o), over(deathorill_08)
summarize o



********************************************************
**********************************************************
* LASSO PDS  - mindegyik kimenet külön táblában


global out_dropout_age "outreg2 using "$results\lassoreg_dropout_age_$S_DATE.tex", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 
global out_maturex "outreg2 using "$results\lassoreg_maturex_$S_DATE.tex", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 
global out_univapp_plan "outreg2 using "$results\lassoreg_univapp_plan_$S_DATE.tex", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 
global out_uni_enrol "outreg2 using "$results\lassoreg_uni_enrol_$S_DATE.tex", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 


foreach var of varlist $outlist  {
	forval i = 1/7 {
		pdslasso  `var' loc_09 ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		${out_`var'}

	}
}


**************************************
* Nested models
***************************************
* Először megkeressük a végső modellt mindegyiknél: 

foreach var of varlist $outlist {
global out "outreg2 using "$results\lassokill_`var'_$S_DATE.xls", coefastr bracket append bdec(3) tdec(3)  " 
	pdslasso `var' loc_09 ( $list6 ) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_6
	mat B=e(b)
	mat list B
	local clist
	tokenize "`: colnames e(b)'"

forval j = 1/`= colsof(B)' {
 if B[1, `j'] != 0 & index("``j''","_cons")==0 {
 local clist `clist' ``j''
	reg `var' `clist' if sample == 1  [weight = weight], robust cluster(omid)
	est sto olsin_`var'_6
	$out
	*di "`clist'"

  }
 }
}
	
* Aztán elmentjük a változólistákat: 

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


*Majd lefuttatjuk mindegyikre a regressziót

* Nested models


global out "outreg2 using "$results\nested_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label " 

		reg  maturex  $maturex_6 if sample == 1  [weight = weight], robust cluster(omid)


foreach var of varlist $outlist  {
	forval i = 1/6 {
		reg  `var'  ${`var'_`i'} if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		$out

	}
}
