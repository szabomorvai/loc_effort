* Locus of Control, Educational Attainment and College Aspirations: The Role of Effort
* Kiss Hubert János (R) Szabó-Morvai Ágnes
* 2021-05-17


clear
use $newdata\eletpalya_for_regs_vars_2021, clear

* Globals
* Control varlist for LOC_2006
global varlist06 i.regio moth_* fath_* acognisc  aemotisc sleepwith_06* hhsize    social_disad* i.mothwork_06* i.fathwork_06* fin_dist* female  mother* father* snix sniszam letszam hhinc_06	childcare* tales* amkor* amkor_sq abuse_b14*  divorce_06 roma_07 bw_u2500* sochome_06* stepparents* ed* parent_*
* Control varlist for LOC_2009
global varlist09 $varlist06 sleepwith_* abuse_a14* death_* accident_* illness_*  i.mothwork* i.fathwork*  hhinc_*
global locvars loc_06 loc_09 
global cogn o m 
global effort study_time* sedul*07* sedul*08*  night_study* weekend_study*
global expect exp_*08*
global outlist dropout_age maturex  univapp_plan uni_enrol 
global list1 
global list2 $varlist09 
global list3 $varlist09 $cogn 
global list4 $varlist09 $cogn $expect 
global list5 $varlist09 $cogn $effort 
global list6 $varlist09 $cogn $expect $effort 
global desc loc_09 gpa_07 o m female moth_lowed moth_mided moth_highed hhinc_06 acognisc  aemotisc expectations_08 exp_sal_avg_08  exp_empl_08 effort_07 study_time_07 sedulity_07 parent_pay_06 parent_min_06 parent_ideal_06

* variable list subsets from final models
foreach var of varlist $outlist {
global out "outreg2 using "$results\varlists_`var'_$S_DATE.xls", coefastr bracket append bdec(3) tdec(3)  " 
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
  }
 }
}
* save lists in macros
global uni_enrol_1	loc_09																	
global uni_enrol_2	loc_09	moth_lowed	moth_highed	fath_lowed	fath_highed	acognisc	abuse_b14	parent_ideal_06	parent_min_06									
global uni_enrol_3	loc_09	moth_lowed	moth_highed	fath_lowed	fath_highed	acognisc	abuse_b14	parent_ideal_06	parent_min_06	o	m							
global uni_enrol_4	loc_09	moth_lowed	moth_highed	fath_lowed	fath_highed	acognisc	abuse_b14	parent_ideal_06	parent_min_06	o	m	exp_sal_avg_08	exp_sal_100net_08	exp_sal_200net_08				
global uni_enrol_5	loc_09	moth_lowed	moth_highed	fath_lowed	fath_highed	acognisc	abuse_b14	parent_ideal_06	parent_min_06	o	m	study_time_07	study_time_08	sedulity_07	sedulity_08			
global uni_enrol_6	loc_09	moth_lowed	moth_highed	fath_lowed	fath_highed	acognisc	abuse_b14	parent_ideal_06	parent_min_06	o	m	exp_sal_avg_08	exp_sal_100net_08	exp_sal_200net_08	study_time_07	study_time_08	sedulity_07	sedulity_08

global univapp_plan_1	loc_09																		
global univapp_plan_2	loc_09	moth_lowed	moth_highed	fath_lowed	fath_highed	acognisc	abuse_b14	ed_mo_fa_high	parent_ideal_06	parent_min_06	parent_pay_06								
global univapp_plan_3	loc_09	moth_lowed	moth_highed	fath_lowed	fath_highed	acognisc	abuse_b14	ed_mo_fa_high	parent_ideal_06	parent_min_06	parent_pay_06	o	m						
global univapp_plan_4	loc_09	moth_lowed	moth_highed	fath_lowed	fath_highed	acognisc	abuse_b14	ed_mo_fa_high	parent_ideal_06	parent_min_06	parent_pay_06	o	m	exp_sal_avg_08	exp_sal_100net_08	exp_sal_200net_08			
global univapp_plan_5	loc_09	moth_lowed	moth_highed	fath_lowed	fath_highed	acognisc	abuse_b14	ed_mo_fa_high	parent_ideal_06	parent_min_06	parent_pay_06	o	m	study_time_08	sedulity_07	sedulity_08			
global univapp_plan_6	loc_09	moth_lowed	moth_highed	fath_lowed	fath_highed	acognisc	abuse_b14	ed_mo_fa_high	parent_ideal_06	parent_min_06	parent_pay_06	o	m	exp_sal_avg_08	exp_sal_100net_08	exp_sal_200net_08	study_time_08	sedulity_07	sedulity_08

global maturex_1	loc_09																						
global maturex_2	loc_09	moth_lowed	fath_lowed	fath_mided	acognisc	social_disad	abuse_b14	roma_07	parent_ideal_06	parent_pay_06	1.mothwork_09												
global maturex_3	loc_09	moth_lowed	fath_lowed	fath_mided	acognisc	social_disad	abuse_b14	roma_07	parent_ideal_06	parent_pay_06	1.mothwork_09	o	m										
global maturex_4	loc_09	moth_lowed	fath_lowed	fath_mided	acognisc	social_disad	abuse_b14	roma_07	parent_ideal_06	parent_pay_06	1.mothwork_09	o	m	exp_sal_avg_08	exp_sal_100net_08	exp_sal_200net_08							
global maturex_5	loc_09	moth_lowed	fath_lowed	fath_mided	acognisc	social_disad	abuse_b14	roma_07	parent_ideal_06	parent_pay_06	1.mothwork_09	o	m	study_time_07	study_time_08	sedulity_07	sedulity_08	night_study_08	night_study_08_imp	weekend_study_08_imp			
global maturex_6	loc_09	moth_lowed	fath_lowed	fath_mided	acognisc	social_disad	abuse_b14	roma_07	parent_ideal_06	parent_pay_06	1.mothwork_09	o	m	exp_sal_avg_08	exp_sal_100net_08	exp_sal_200net_08	study_time_07	study_time_08	sedulity_07	sedulity_08	night_study_08	night_study_08_imp	weekend_study_08_imp


global dropout_age_1	loc_09																										
global dropout_age_2	loc_09	moth_lowed	acognisc	social_disad	1.fathwork_06	fin_dist_09	abuse_b14	roma_07	ed_fa_mo_mid	parent_ideal_06	parent_pay_06	1.mothwork_09															
global dropout_age_3	loc_09	moth_lowed	acognisc	social_disad	1.fathwork_06	fin_dist_09	abuse_b14	roma_07	ed_fa_mo_mid	parent_ideal_06	parent_pay_06	1.mothwork_09	o	m													
global dropout_age_4	loc_09	moth_lowed	acognisc	social_disad	1.fathwork_06	fin_dist_09	abuse_b14	roma_07	ed_fa_mo_mid	parent_ideal_06	parent_pay_06	1.mothwork_09	o	m	exp_sal_avg_08	exp_empl_08	exp_sal_100net_08	exp_sal_200net_08									
global dropout_age_5	loc_09	moth_lowed	acognisc	social_disad	1.fathwork_06	fin_dist_09	abuse_b14	roma_07	ed_fa_mo_mid	parent_ideal_06	parent_pay_06	1.mothwork_09	o	m	study_time_07	study_time_08	sedulity_07	sedulity_08	sedulity_08_imp	night_study_08	night_study_08_imp	weekend_study_07_imp	weekend_study_08_imp				
global dropout_age_6	loc_09	moth_lowed	acognisc	social_disad	1.fathwork_06	fin_dist_09	abuse_b14	roma_07	ed_fa_mo_mid	parent_ideal_06	parent_pay_06	1.mothwork_09	o	m	exp_sal_avg_08	exp_empl_08	exp_sal_100net_08	exp_sal_200net_08	study_time_07	study_time_08	sedulity_07	sedulity_08	sedulity_08_imp	night_study_08	night_study_08_imp	weekend_study_07_imp	weekend_study_08_imp


************************************************************************
* Table 2: Descriptive statistics of the dependent variables
************************************************************************
xtile o_quart = o, n(4)
xtile expectations_08_quart = expectations_08, n(4)
xtile effort_08_quart = effort_08, n(4)
xtile loc_09_med = loc_09, n(2)

tabstat $outlist [weight = weight]
tabstat $outlist [weight = weight], by(desc_mothereduc)  
tabstat $outlist [weight = weight], by(o_quart)
tabstat $outlist [weight = weight], by(expectations_08_quart)
tabstat $outlist [weight = weight], by(effort_08_quart)
tabstat $outlist [weight = weight], by(loc_09_med)

************************************************************************
* Table 3: Correlations between the main explanatory variables of interest
************************************************************************
pwcorr desc_mothereduc acognisc  aemotisc  o expectations_08 effort_08 loc_09, sig

************************************************************************
* Table 4: PDS Lasso models of LoC and educational attainment
************************************************************************
global out "outreg2 using "$results\lassoreg_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N)" 
global out2	"outreg2 using "$results\Rsquared_insample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_in, e(r2)) stats(coef se N) keep(loc_09)"
global out3	"outreg2 using "$results\Rsquared_outofsample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_out, e(r2)) stats(coef se N) keep(loc_09)"

foreach var of varlist $outlist  {
	forval i = 1/6 {
		pdslasso  `var' loc_09 ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		$out
	* R-sq
	do $code\032_rsq.do
	reg `var' $clist if sample == 1  [weight = weight], robust cluster(omid)
	est sto olsin_`var'_0
	$out2
	reg `var' $clist if sample == 2  [weight = weight], robust cluster(omid)
	est sto olsout_`var'_0
	$out3 
	}
}

************************************************************************
*Table 5:  LoC, expectations and effort
************************************************************************
global out "outreg2 using "$results\exp_eff_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 
global out2	"outreg2 using "$results\exp_eff_rsq_insample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_in, e(r2)) stats(coef se N)"
global out3	"outreg2 using "$results\exp_eff_rsq_outofsample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_out, e(r2)) stats(coef se N)"
***************
*EXPECTATIONS
**************
foreach var of varlist expectations_08 {
	foreach i in 1 2 3 5  {
		pdslasso  `var' loc_06 ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		$out
	* R-sq
	do $code\032_rsq.do
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
foreach var of varlist effort_08 effort_07_08_09 {
	foreach i in 1 2 3 4  {
		pdslasso  `var' loc_06 ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		$out
	* R-sq
	do $code\032_rsq.do
	reg `var' $clist if sample == 1  [weight = weight], robust cluster(omid)
	est sto olsin_`var'_0
	$out2
	reg `var' $clist if sample == 2  [weight = weight], robust cluster(omid)
	est sto olsout_`var'_0
	$out3
	}
}

************************************************************************
*Table 6:  Formal mediation analysis
************************************************************************
foreach var of varlist $outlist {
*global out "outreg2 using "$results\varlists_`var'_$S_DATE.xls", coefastr bracket append bdec(3) tdec(3)  " 
	pdslasso `var' loc_09 ( $list3 ) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_6
	mat B=e(b)
	local clist_`var' "`: colnames B'"
*	di "`clist'"
}
	di "`clist_dropout_age'"
	di "`clist_maturex'"
	di "`clist_univapp_plan'"
	di "`clist_uni_enrol'"
	
global  list_dropout_age moth_lowed moth_mided acognisc social_disad 1.fathwork_06 fin_dist_09 abuse_b14 ed_fa_mo_mid parent_ideal_06 parent_pay_06 1.mothwork_09 o m
global  list_maturex moth_lowed fath_lowed fath_mided acognisc social_disad abuse_b14 roma_07 parent_ideal_06 parent_pay_06 1.mothwork_09 o m
global  list_univapp_plan moth_lowed moth_highed fath_lowed fath_highed acognisc abuse_b14 parent_ideal_06 parent_min_06 parent_pay_06 o m
global  list_uni_enrol moth_lowed moth_highed fath_lowed fath_highed acognisc abuse_b14 parent_ideal_06 parent_min_06 o m

foreach var of varlist $outlist {	
	foreach mediator of varlist effort_07_08_09 expectations_08 {
	    * Eq 1: 
		reg `var' loc_09 ${list_`var'} if sample == 1  [weight = weight], robust cluster(omid)
		outreg2 using "$results\mediation_$S_DATE.xls",  ctitle(Total_`var'_`mediator') bdec(3) tdec(3) label 
	
		* Eq. 2: 
		reg `var' loc_09 `mediator' ${list_`var'} if sample == 1  [weight = weight], robust cluster(omid)
		outreg2 using "$results\mediation_$S_DATE.xls",  ctitle(Direct_`var'_`mediator') bdec(3) tdec(3) label 
	}
  }

************************************************************************
*Table 7:  Heterogeneity:  mother’s education
************************************************************************
global out_moth_lowed "outreg2 using "$results\heterog_moth_low_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N) keep(loc_09)"
global out_moth_mided "outreg2 using "$results\heterog_moth_mid_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N) keep(loc_09)"
global out_moth_highed "outreg2 using "$results\heterog_moth_high_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N) keep(loc_09)"

foreach var of varlist $outlist {
	foreach i of varlist moth_lowed moth_mided moth_highed {
		forval k = 1/6 {
		pdslasso  `var' loc_09 ( ${list`k'}) if sample == 1 & `i' == 1 [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		${out_`i'}
		}
	}
}

************************************************************************
*Table 8:  Heterogeneity:  gender differences
************************************************************************
global out_fem0 "outreg2 using "$results\heterog_fem0_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N) keep(loc_09)"
global out_fem1 "outreg2 using "$results\heterog_fem1_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N) keep(loc_09)"

foreach var of varlist $outlist {
		foreach i in 0 1 {
		forval k = 1/6 {
		pdslasso  `var' loc_09 ( ${list`k'}) if sample == 1 & female == `i' [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		${out_fem`i'}
		}
	}
}


************************************************************************
* Appendix
************************************************************************
************************************************************************
*Table B.10:  Summary statistics for the entire sample and by outcome variables
************************************************************************
mean $desc [weight = weight]
tabstat $desc [weight = weight], by(univapp_plan)  c(s)
tabstat $desc [weight = weight], by(uni_enrol)  c(s)
tabstat $desc [weight = weight], by(maturex)  c(s)
gegen dropout_median = median(dropout_age)
gen drop_above = dropout_age >=  dropout_median
tabstat $desc [weight = weight], by(drop_above)  c(s)

************************************************************************
*Table D.12:  Summary statistics of the dependent variables in the regressions
************************************************************************
summarize $outlist expectations_08 effort_08 effort_07_08_09 

************************************************************************
*Table D.13:  The locus of control pairs of statements - Rotter-test
************************************************************************
tab ad036axx
tab ad036bxx
tab ad036cxx
tab ad036dxx
tab df2a
tab df2b
tab df2c
tab df2d

************************************************************************
*Table D.14:  Dictionary of control variables
************************************************************************
fsum loc_06 loc_09  delta_loc_09  $expect $effort moth_* fath_* acognisc  aemotisc sleepwith_06* hhsize    social_disad*  fin_dist* female  mother* father* snix sniszam letszam hhinc_06	childcare* tales* amkor* amkor_sq abuse_b14*  divorce_06 roma_07 bw_u2500* sochome_06* stepparents* ed* parent_* sleepwith_*  abuse_a14* death_* accident_* illness_*   hhinc_* regio mothwork_* fathwork_*  , label catvar(regio mothwork_* fathwork*)
fsum o m, label 

************************************************************************
*Table E.15:  Correlation of effort and expectations
************************************************************************
pwcorr exp_sal_avg_08 exp_sal_10pct_08 exp_empl_08 exp_sal_100net_08 exp_sal_200net_08 expectations_08  study_time_08 sedulity_08 night_study_08 weekend_study_08 effort_08, sig 

************************************************************************
*Table F.16:  Testing for differences of LoC coefficients between model specifications (p-values)
************************************************************************

*$outlist dropout_age maturex  univapp_plan uni_enrol 
foreach var of varlist  univapp_plan    {
disp "`var'"
qui reg  `var'  ${`var'_3} if sample == 1  [weight = weight]
est sto M3

qui reg  `var'  ${`var'_4} if sample == 1  [weight = weight]
est sto M4

qui reg  `var'  ${`var'_5} if sample == 1  [weight = weight]
est sto M5

qui reg  `var'  ${`var'_6} if sample == 1  [weight = weight]
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

************************************************************************
*Online Appendix
************************************************************************
************************************************************************
*OA Table A.1: Home Cognitive and Emotional Scale
************************************************************************
forval i = 1/13 {
	tab acogni`i'	
	}
	
forval i = 1/14 {
	tab aemoti`i'	
	}

************************************************************************
*OA Table D.2 to D.5: Complete regressions
************************************************************************
global out "outreg2 using "$results\lassoreg_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se pval N)" 
global out2	"outreg2 using "$results\Rsquared_insample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_in, e(r2)) stats(coef se N) keep(loc_09)"
global out3	"outreg2 using "$results\Rsquared_outofsample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_out, e(r2)) stats(coef se N) keep(loc_09)"

foreach var of varlist $outlist  {
	forval i = 1/6 {
		pdslasso  `var' loc_09 ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		$out
	* R-sq
	do $code\032_rsq.do
	reg `var' $clist if sample == 1  [weight = weight], robust cluster(omid)
	est sto olsin_`var'_0
	$out2
	reg `var' $clist if sample == 2  [weight = weight], robust cluster(omid)
	est sto olsout_`var'_0
	$out3 
	}
}

************************************************************************
*OA Table E.6: Nested regression results  
************************************************************************
global out "outreg2 using "$results\nested_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label " 
foreach var of varlist $outlist  {
	forval i = 1/6 {
		reg  `var'  ${`var'_`i'} if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		$out
	}
}

************************************************************************
*OA Table F.7 to F9: Channel regressions
************************************************************************
global out "outreg2 using "$results\exp_eff_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(Clusters, e(N_clust), Selected controls, e(xselected_ct), Dictionary size, e(xhighdim_ct) ) stats(coef se N)" 
global out2	"outreg2 using "$results\exp_eff_rsq_insample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_in, e(r2)) stats(coef se N)"
global out3	"outreg2 using "$results\exp_eff_rsq_outofsample_$S_DATE.xls", coefastr bracket append  bdec(3) tdec(3) label addstat(R-sq_out, e(r2)) stats(coef se N)"
***************
*EXPECTATIONS
**************
foreach var of varlist expectations_08 {
	foreach i in 1 2 3 5  {
		pdslasso  `var' loc_06 ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		$out
	* R-sq
	do $code\032_rsq.do
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
foreach var of varlist effort_08 effort_07_08_09 {
	foreach i in 1 2 3 4  {
		pdslasso  `var' loc_06 ( ${list`i'}) if sample == 1  [weight = weight], robust cluster(omid)
		estimates store `var'_`i'
		$out
	* R-sq
	do $code\032_rsq.do
	reg `var' $clist if sample == 1  [weight = weight], robust cluster(omid)
	est sto olsin_`var'_0
	$out2
	reg `var' $clist if sample == 2  [weight = weight], robust cluster(omid)
	est sto olsout_`var'_0
	$out3
	}
}