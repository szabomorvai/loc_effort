* Stability of trats

* Kiss Hubert János - Szabó-Morvai Ágnes

* 2018-05-25

* Lasso to find which variables predict best LoC
* https://www.youtube.com/watch?v=efYBzFcKWn8&feature=youtu.be

* On the stata lasso packages:
* https://statalasso.github.io/docs/estimators/

global origdata "C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Adat\Eletpálya_adatok"
global newdata "C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Adat\Traitsdata"
global results "C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Eredmények\2020"
global graphlib "C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Paper_1\Graphs"
global graphlib2 "C:\Users\szabomorvai.agnes\Dropbox\Apps\Overleaf\Locus of control (Copy)"
global dolib "C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Do\Do_2020"
global overleaf "C:\Users\szabomorvai.agnes\Dropbox\Apps\Overleaf\Locus of control (Copy)"

clear

use $newdata\eletpalya_for_regs_vars, clear

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
