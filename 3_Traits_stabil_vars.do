* Stability of trats

* Kiss Hubert János - Szabó-Morvai Ágnes

* 2018-05-25

* LoC correlation
* http://www.mccc.edu/~jenningh/Courses/documents/Rotter-locusofcontrolhandout.pdf
* A high score = External Locus of Control
* A low score = Internal Locus of Control 

global origdata C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Adat\Eletpálya_adatok
global newdata C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Adat\Traitsdata
global overleaf "C:\Users\szabomorvai.agnes\Dropbox\Apps\Overleaf\Locus of control (Copy)"
global results "C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Eredmények\2021"

clear

use $newdata\eletpalya_imputed_2021

gen weight = int(suly*w_hull_f)	
drop if t1ev < 89 | t1ev >  92
keep if sample_f == 1													// only those are kept who stayed in the sample until the last wave
splitsample, generate(sample) nsplit(2) rseed(1234)


* LoC 2006 - higher score, inner LoC
gen loc1_06 = cond(1, ad036axx== 1, 0) 
	replace loc1_06 = . if ad036axx == . 
gen loc2_06 = cond(1, ad036bxx== 1, 0) 
	replace loc2_06 = . if ad036bxx == . 
gen loc3_06 = cond(1, ad036cxx== 1, 0) 
	replace loc3_06 = . if ad036cxx == . 
gen loc4_06 = cond(1, ad036dxx== 2, 0) 
	replace loc4_06 = . if ad036dxx == . 

factor loc1* loc2* loc3* loc4* [weight = weight]
predict loc_06
	lab var loc_06 "LoC score in 2006"


gen loc_simp_06 = loc1_06 + loc2_06 + loc3_06 + loc4_06
 
* LoC 2009 - higher score, inner LoC
gen dloc1 = cond(1, df2a== 1, 0) 
	replace dloc1 = . if df2a == . 
gen dloc2 = cond(1, df2b== 1, 0) 
	replace dloc2 = . if df2b == . 
gen dloc3 = cond(1, df2c== 1, 0) 
	replace dloc3 = . if df2c == . 
gen dloc4 = cond(1, df2d== 2, 0) 
	replace dloc4 = . if df2d == . 

factor dloc* [weight = weight]
predict loc_09
	lab var loc_09 "LoC score in 2009"

gen loc_simp_09 = dloc1 + dloc2 + dloc3 + dloc4

foreach i in 06 09 {
	summarize loc_`i'
	replace loc_`i'= (loc_`i' - r(mean)) / (r(sd))
}

gen delta_loc_09 = loc_09 - loc_06
	lab var delta_loc_09 "Change of LoC score 2006-9"
	

* Female variable

gen female = af002a01
	recode female (1=2) if (t2 == 1 & bl01neme == 2) |  (t2 == 1 & cl01neme == 2) |  (t2 == 1 & dl01neme == 2) |  (t2 == 1 & el01neme == 2) |  (t2 == 1 & fl01neme == 2)
	recode female (2=1) if (t2 == 0 & bl01neme == 1) |  (t2 == 0 & cl01neme == 1) |  (t2 == 0 & dl01neme == 1) |  (t2 == 0 & el01neme == 1) |  (t2 == 0 & fl01neme == 1)
	recode female (1 = 0) (2=1)
	lab def female 0 "Male" 1 "Female" 
	lab val female female
	lab var female "Female"	
	
tab regio, gen(regio_)

* Age at interview
*acho2 acnap2
*t1ev t1ho

gen intdate = mdy(acfho, 15, 2006)
gen szulev = 1900 + t1ev
gen birthdate = mdy(t1ho, 15, szulev)
gen age = (intdate - birthdate)/365
lab var age "Age at 2006 interview"

* Wealth

* Control variables
	*Summer work
	gen swork_06 = ad005xxx
	gen swork_06_imp = ad005xxx_i
		recode swork_06 (2=0)
		lab var swork_06 "Summer work in 2006"
		
	gen swork_07 = b122
	gen swork_07_imp = b122_i
		recode swork_07 (2=0)
		lab var swork_07 "Summer work in 2007"

	gen swork_08 = c111
	gen swork_08_imp = c111_i
		recode swork_08 (2=0)
		lab var swork_08 "Summer work in 2008"
		
	gen swork_09 = d119
	gen swork_09_imp = d119_i
		recode swork_09 (2=0)
		lab var swork_09 "Summer work in 2009"

* Permanent work
	gen work_06 = ad012axx
	gen work_06_imp = ad012axx_i
		recode work_06 (2=0)
		lab var work_06 "Permanent work in 2006"

	gen work_07 = b205
	gen work_07_imp = b205_i
		recode work_07 (2=0)
		lab var work_07 "Permanent work in 2007"
		
	gen work_08 = c172
	gen work_08_imp = c172_i
		recode work_08 (2=0)
		lab var work_08 "Permanent work in 2008"
		
	gen work_09 = d173
	gen work_09_imp = d173_i
		recode work_09 (2=0)
		lab var work_09 "Permanent work in 2009"
		
			
	* Books
	gen books = ad024bxx
	gen books_imp = ad024bxx_i
				
	* How many people sleep in the same room 
	gen sleepwith_06 = ad026xxx
	gen sleepwith_06_imp = ad026xxx_i
	lab var sleepwith_06 "How many people sleep in the same room (2006)"
	
	* Subjective health (1-4, higher better))
	gen subjhealth_06 = 5-ad028xxx
	gen subjhealth_06_imp = ad028xxx_i
	lab var subjhealth_06 "How healthy do you feel (2006)"
	lab def subjhealth_06 1 "Bad" 2 "Fair"  3 "Good" 4 "Perfect" 
	lab val subjhealth_06 subjhealth_06
	
gen subjhealth_08 = 5 - c198	
	lab var subjhealth_08 "How healthy do you feel (2008)"
	gen subjhealth_08_imp = c198_i

gen subjhealth_09 = 5 - d188	
	lab var subjhealth_09 "How healthy do you feel (2009)"
	gen subjhealth_09_imp = d188_i

gen subjhealth_10 = 6 - e156	
	lab var subjhealth_10 "How healthy do you feel (2010)"
	gen subjhealth_10_imp = e156_i
	
gen subjhealth_11 = 6 - f156	
	lab var subjhealth_11 "How healthy do you feel (2011)"
	gen subjhealth_11_imp = f156_i
		
	
	
* Objective health (1-17, higher better)

gen health_headache_06 = 6-ad031axx
gen health_headache_06_imp = ad031axx_i
lab var health_headache_06 "Health: headache (2006)"
gen health_headache_08 = 6-c202a
gen health_headache_08_imp = c202a_i
lab var health_headache_08 "Health: headache (2008)"


gen health_stomache_06 = 6-ad031bxx
gen health_stomache_06_imp = ad031bxx_i
lab var health_stomache_06 "Health: stomachache (2006)"
gen health_stomache_08 = 6-c202b
gen health_stomache_08_imp = c202b_i
lab var health_stomache_08 "Health: stomachache (2008)"

gen health_badmood_06 = 6-ad031dxx
gen health_badmood_06_imp = ad031dxx_i
lab var health_badmood_06 "Health: bad mood (2006)"
gen health_badmood_08 = 6-c202d
gen health_badmood_08_imp = 6-c202d_i
lab var health_badmood_08 "Health: bad mood (2008)"

gen health_nosleep_06 = 6-ad031hxx
gen health_nosleep_06_imp = ad031hxx_i
lab var health_nosleep_06 "Health: cannot sleep (2006)"
gen health_nosleep_08 = 6-c202h
gen health_nosleep_08_imp = c202h_i
lab var health_nosleep_08 "Health: cannot sleep (2008)"


gen objhealth_06 = 21-(health_headache_06 + health_stomache_06 + health_badmood_06 + health_nosleep_06)
lab var objhealth_06 "Objective health (2006)"
gen objhealth_08 = 21-(health_headache_08 + health_stomache_08 + health_badmood_08 + health_nosleep_08)
lab var objhealth_08 "Objective health (2008)"


* Emotional stability
gen cont1 = cond(ad033axx == 1, 1, 0) 
gen cont2 = cond(ad033bxx == 1, 1, 0) 
gen cont3 = cond(ad033cxx == 3, 1, 0) 
gen cont4 = cond(ad033dxx == 3, 1, 0) 
gen cont5 = cond(ad033exx == 3, 1, 0) 
gen cont6 = cond(ad033fxx == 1, 1, 0) 
gen cont7 = cond(ad033gxx == 3, 1, 0) 
gen cont8 = cond(ad033hxx == 1, 1, 0) 


gen emot_stability_06 = cont1 + cont2 + cont3 + cont4 + cont5 + cont6 + cont7 + cont8 
lab var emot_stability_06 "Emotional stability (2006)"
gen emot_stability_06_imp = cond(ad033axx_i == 1 | ad033bxx_i == 1 | ad033cxx_i == 1 | ad033dxx_i == 1 | ad033exx_i == 1 | ad033fxx_i == 1 | ad033gxx_i == 1 | ad033hxx_i == 1, 1, 0)

* Self esteem 2006
gen est1 = cond((ad034axx == 3 | ad034axx == 4), 1, 0) 
gen est2 = cond((ad034bxx == 3 | ad034bxx == 4), 1, 0) 
gen est3 = cond((ad034cxx == 1 | ad034cxx == 2), 1, 0) 
gen est4 = cond((ad034dxx == 3 | ad034dxx == 4), 1, 0) 
gen est5 = cond((ad034exx == 1 | ad034exx == 2), 1, 0) 
gen est6 = cond((ad034fxx == 3 | ad034fxx == 4), 1, 0) 
gen est7 = cond((ad034gxx == 3 | ad034gxx == 4), 1, 0) 
gen est8 = cond((ad034hxx == 1 | ad034hxx == 2), 1, 0) 
gen est9 = cond((ad034ixx == 1 | ad034ixx == 2), 1, 0) 
gen est10 = cond((ad034jxx == 1 | ad034jxx == 2), 1, 0) 

gen self_esteem_06 = est1 + est2 + est3 + est4 + est5 + est6 + est7 + est8 + est9 + est10
lab var self_esteem_06 "Self esteem (2006)"
gen self_esteem_06_imp = cond(ad034axx_i == 1 | ad034bxx_i == 1 | ad034cxx_i == 1 | ad034dxx_i == 1 | ad034exx_i == 1 | ad034fxx_i == 1 | ad034gxx_i == 1 | ad034hxx_i == 1 | ad034ixx_i == 1 | ad034jxx_i == 1 , 1, 0)

* Self esteem 2009

gen est1_09 = cond((df1a == 3 | df1a == 4), 1, 0) 
gen est2_09 = cond((df1b == 3 | df1b == 4), 1, 0) 
gen est3_09 = cond((df1c == 1 | df1c == 2), 1, 0) 
gen est4_09 = cond((df1d == 3 | df1d == 4), 1, 0) 
gen est5_09 = cond((df1e == 1 | df1e == 2), 1, 0) 
gen est6_09 = cond((df1f == 3 | df1f == 4), 1, 0) 
gen est7_09 = cond((df1g == 3 | df1g == 4), 1, 0) 
gen est8_09 = cond((df1h == 1 | df1h == 2), 1, 0) 
gen est9_09 = cond((df1i == 1 | df1i == 2), 1, 0) 
gen est10_09 = cond((df1j == 1 | df1j == 2), 1, 0) 

gen self_esteem_09 = est1_09 + est2_09 + est3_09 + est4_09 + est5_09 + est6_09 + est7_09 + est8_09 + est9_09 + est10_09
lab var self_esteem_09 "Self esteem (2009)"
gen self_esteem_09_imp = cond(df1a_i == 1 | df1b_i == 1 | df1c_i == 1 | df1d_i == 1 | df1e_i == 1 | df1f_i == 1 | df1g_i == 1 | df1h_i == 1 | df1i_i == 1 | df1j_i == 1 , 1, 0)



* Bullying (1-9, higher - more bullying)	
gen bullying_06 = ad035axx + ad035bxx + ad035cxx + ad035dxx + ad035exx + ad035fxx + ad035gxx + ad035hxx + ad035ixx     
lab var bullying_06 "Bullying (2006)"
gen bullying_06_imp = cond(ad035axx_i == 1 | ad035bxx_i == 1 | ad035cxx_i == 1 | ad035dxx_i == 1 | ad035exx_i == 1 | ad035fxx_i == 1 | ad035gxx_i == 1 | ad035hxx_i == 1 | ad035ixx_i == 1 , 1, 0)

* Bullying 2008
gen bullying_08 = cfiat1
	recode bullying_08 (1=0) (2=1) 
lab var bullying_08 "Bullying (2008)"

* Roma
gen roma_07 = 0
	replace roma = 1 if b222 == 7 | b223 == 7
lab var roma_07 "Roma"

* Socializing
gen soc1 = cond(ad037axx == 1 | ad037axx == 2 , 1, 0)
gen soc2 = cond(ad037bxx == 1 | ad037bxx == 2 , 1, 0)
gen soc3 = cond(ad037cxx == 3 | ad037cxx == 4 , 1, 0)
gen soc4 = cond(ad037dxx == 1 | ad037dxx == 2 , 1, 0)
gen soc5 = cond(ad037exx == 3 | ad037exx == 4 , 1, 0)
gen soc6 = cond(ad037fxx == 1 | ad037fxx == 2 , 1, 0)
gen soc7 = cond(ad037gxx == 1 | ad037gxx == 2 , 1, 0)

gen sociable_06 = soc1 + soc2  + soc3 + soc4 + soc5 + soc6 + soc7
lab var sociable_06 "Sociability (2006)"
gen sociable_06_imp = cond(ad037axx_i == 1 | ad037bxx_i == 1 | ad037cxx_i == 1 | ad037dxx_i == 1 | ad037exx_i == 1 | ad037fxx_i == 1 | ad037gxx_i == 1 , 1, 0)


* Household size
gen hhsize = af001xxx
lab var hhsize "Household size"
* Financial distress 2006
recode af215a01 af215b01 af216a01 af216b01 af217a01 af217b01 (2=0) (9=0)
gen fin_dist_06 = cond(af213xxx== 1 |  af215a01 == 1 |  af215b01 == 1 |  af216a01 == 1 |  af216b01== 1 |  af217a01 == 1 |  af217b01== 1 , 1, 0)
lab var fin_dist_06  "Financial distress (2006)"
* Financial disatress 2009
gen fin_dist_09 = cond(d60 == 1 | d62a1 == 1 | d62b1 == 1, 1, 0)
lab var fin_dist_09  "Financial distress (2009)"


				
* Mother or stepmother
gen mother = af006x01
	recode mother (2=0)
	replace mother = 1 if af006x02 == 1
	gen mother_imp = af006x01_i
lab var mother "Lives with mother"	

* Step-mother
*gen smother = af006x02
*	recode smother (2=0)
*gen smother_imp = af006x02_i

* Father
gen father = af010x01
	recode father (2=0)
	replace father = 1 if af010x02 == 1	
gen father_imp = af010x01_i
lab var father "Lives with father"	

* Step-father
*gen sfather = af010x02
*	recode sfather (2=0)
*gen sfather_imp = af010x02_i
	
* Social home
gen sochome_06 = af016a01
	recode sochome_06 (2=0)
gen sochome_06_imp = af016a01_i
lab var sochome_06 "Been in social home (2006)"

* Step parents
gen stepparents = af016b01
	recode stepparents (2=0)
gen stepparents_imp = af016b01_i
lab var stepparents "Has step parents"

* Birthweight 
gen birthweight = af023xxx
lab var birthweight "Birthweight"
gen birthweight_imp = af023xxx_i

gen bw_u2500 = af023xxx < 2500
	lab var bw_u2500 "Birthweight under 2500g"
gen bw_u2500_imp = af023xxx_i


* Social disadvantage 
gen social_disad = cond(af075axx == 1 | af075bxx == 1 | af075cxx == 1, 0, 1)
gen social_disad_imp = cond((af075axx_i == 1 | af075bxx_i == 1 | af075cxx_i == 1) & social_disad == 0 , 1, 0)
lab var social_disad "Social disadvantage (2006)"

* Mother work
gen mothwork_06 = af166xxx
	recode mothwork_06 (2=0) (-6=2)
	lab var mothwork_06 "Mother works (2006)"
	lab def mothwork 0 "No" 1 "Yes" 2 "We did not ask"
	lab val mothwork_06 mothwork

gen mothwork_07 = b43
	recode mothwork_07 (2=1) (3=0) (-6=2)
	lab var mothwork_07 "Mother works (2007)"
	lab val mothwork_07 mothwork

gen mothwork_08 = c32
	recode mothwork_08 (2=1) (3=0) (-6=2)
	lab var mothwork_08 "Mother works (2008)"
	lab val mothwork_08 mothwork

gen mothwork_09 = d32
	recode mothwork_09 (2=1) (3=0) (-6=2)
	lab var mothwork_09 "Mother works (2009)"
	lab val mothwork_09 mothwork

	
		


* Father work 
gen fathwork_06 = af189xxx
	recode fathwork_06 (2=0) (-6=2)
*gen fathwork_imp = af189xxx_i
 lab var fathwork_06 "Father works (2006)"
 	lab val fathwork_06 mothwork

gen fathwork_07 = b57
	recode fathwork_07 (2=1) (3=0) (-6=2)
	lab var fathwork_07 "Father works (2007)"
 	lab val fathwork_07 mothwork

gen fathwork_08 = c41
	recode fathwork_08 (2=1) (3=0) (-6=2)
	lab var fathwork_08 "Father works (2008)"
 	lab val fathwork_08 mothwork

gen fathwork_09 = d41
	recode fathwork_09 (2=1) (3=0) (-6=2) (9=2)
	lab var fathwork_09 "Father works (2009)"
	 	lab val fathwork_09 mothwork

 
 
* Grandfathers and grandmothers highest education

gen ed_mo_mo_u8 = af160xxx < 5
	lab var ed_mo_mo_u8 "Mother's mother: less than 8"
gen ed_mo_mo_8 = af160xxx == 5
	lab var ed_mo_mo_8 "Mother's mother: 8"
gen ed_mo_mo_mid = af160xxx > 5 & af160xxx < 8
	lab var ed_mo_mo_mid "Mother's mother: high school"
gen ed_mo_mo_high = af160xxx >= 8
	lab var ed_mo_mo_high "Mother's mother: university"

gen ed_mo_fa_u8 = af162xxx < 5
	lab var ed_mo_fa_u8 "Mother's father: less than 8"
gen ed_mo_fa_8 = af162xxx == 5
	lab var ed_mo_fa_8 "Mother's father: 8"
gen ed_mo_fa_mid = af162xxx > 5 & af162xxx < 8
	lab var ed_mo_fa_mid "Mother's father: high school"
gen ed_mo_fa_high = af162xxx >= 8
	lab var ed_mo_fa_high "Mother's father: university"

gen ed_fa_mo_u8 = af183xxx < 5
	lab var ed_fa_mo_u8 "Father's mother: less than 8"
gen ed_fa_mo_8 = af183xxx == 5
	lab var ed_fa_mo_8 "Father's mother: 8"
gen ed_fa_mo_mid = af183xxx > 5 & af183xxx < 8
	lab var ed_fa_mo_mid "Father's mother: high school"
gen ed_fa_mo_high = af183xxx >= 8
	lab var ed_fa_mo_high "Father's mother: university"

gen ed_fa_fa_u8 = af185xxx < 5
	lab var ed_fa_fa_u8 "Father's father: less than 8"
gen ed_fa_fa_8 = af185xxx == 5
	lab var ed_fa_fa_8 "Father's father: 8"
gen ed_fa_fa_mid = af185xxx > 5 & af185xxx < 8
	lab var ed_fa_fa_mid "Father's father: high school"
gen ed_fa_fa_high = af185xxx >= 8
	lab var ed_fa_fa_high "Father's father: university"


 

  
 
* Household income (we have data for further years too) d50
gen hhinc_06 = af167xxx + af168xxx + af190xxx + af191xxx
lab var hhinc_06 "Household income (2006)"
gen hhinc_06_imp = (af167xxx_i == 1 | af168xxx_i == 1 | af190xxx_i  == 1 | af191xxx_i  == 1 )


gen hhinc_07 = b65
lab var hhinc_07 "Household income (2007)"
gen hhinc_07_imp = b65_i

gen hhinc_08 = c50
lab var hhinc_08 "Household income (2008)"
gen hhinc_08_imp = c50_i

gen hhinc_09 = d50
lab var hhinc_09 "Household income (2009)"
gen hhinc_09_imp = d50_i
 
 
 * Mother / step mother education
gen mothed = . 
foreach num in b c d e f g h {
	replace mothed = af002`num'04 if af002`num'12 == 2 | af002`num'12 == 3 
 }
 

 * Father / step father education
gen fathed = . 
foreach num in b c d e f g h {
	replace fathed = af002`num'04 if af002`num'12 == 4 | af002`num'12 == 5 
 }

* Impute
foreach var of varlist mothed fathed  {
	recode `var' (99=.) (-6=.)
	gen `var'_imp = cond(`var' == ., 1, 0)
	egen imp_`var' = mode(`var')
	replace `var' = imp_`var' if `var' == .
}


* Parental education dummies
foreach par in moth fath {
gen `par'_lowed = cond(`par'ed >= 1 & `par'ed <= 4, 1, 0)
gen `par'_mided =  cond(`par'ed >= 5 & `par'ed <= 7, 1, 0)
gen `par'_highed =  cond(`par'ed >= 8 & `par'ed <= 10, 1, 0)
lab var `par'_lowed "`par'er less than high school"
lab var  `par'_mided "`par'er high school"
lab var `par'_highed "`par'er university"
}

* Mother education 3valued
gen desc_mothereduc = 1 if moth_lowed == 1
	replace desc_mothereduc  = 2 if moth_mided == 1
	replace desc_mothereduc  = 3 if moth_highed == 1
	lab def desc_mothereduc 1 "Primary or lower" 2 "High school" 3 "University"
	lab val desc_mothereduc desc_mothereduc

* Father education 3valued
gen desc_fathereduc = 1 if fath_lowed == 1
	replace desc_fathereduc  = 2 if fath_mided == 1
	replace desc_fathereduc  = 3 if fath_highed == 1
	lab def desc_fathereduc 1 "Primary or lower" 2 "High school" 3 "University"
	lab val desc_fathereduc desc_fathereduc
	
gen moth_fath_educ = 1 if desc_fathereduc == 1 & desc_mothereduc == 1
	replace moth_fath_educ = 2 if desc_fathereduc == 1 & desc_mothereduc == 2
	replace moth_fath_educ = 3 if desc_fathereduc == 1 & desc_mothereduc == 3
	replace moth_fath_educ = 4 if desc_fathereduc == 2 & desc_mothereduc == 1
	replace moth_fath_educ = 5 if desc_fathereduc == 2 & desc_mothereduc == 2
	replace moth_fath_educ = 6 if desc_fathereduc == 2 & desc_mothereduc == 3
	replace moth_fath_educ = 7 if desc_fathereduc == 3 & desc_mothereduc == 1
	replace moth_fath_educ = 8 if desc_fathereduc == 3 & desc_mothereduc == 2
	replace moth_fath_educ = 9 if desc_fathereduc == 3 & desc_mothereduc == 3
	lab def moth_fath_educ 1 "M1 F1" 2 "M1 F2" 3 "M1 F3" 4 "M2 F1" 5 "M2 F2" 6 "M2 F3" 7 "M3 F1" 8 "M3 F2" 9 "M3 F3"
	lab val moth_fath_educ moth_fath_educ

gen mfe = desc_fathereduc + desc_mothereduc 
gen gmfe = af160xxx + af162xxx + af183xxx + af185xxx


* Religiousness
gen relig_07 =  b193
	lab var relig_07 "Religiousness (2007)"
gen relig_imp_07 = b193_i

* Childcare
gen childcare = af054xxx
recode childcare (1=.5) (2=1) (3=1.5) (4=2) (5=2.5) (6=3)
lab var childcare "How long have you been enrolled to childcare"
gen childcare_imp = af054xxx_i

* Tales in childhood
gen tales = af056xxx
	lab var tales "How often did the parents read tales from a book"
recode tales (1=0) (2=3) (3=6) (4=16) (5=25) 
gen tales_imp = af056xxx_i
	
* Age of mother
lab var amkor "Age of female caretaker"
gen amkor_sq = amkor^2
lab var amkor_sq "Age of female caretaker - squared"

* Positive expectations - general (2008) - more is better

*annak, hogy a jövo hét vasárnapján napos ido lesz, mit gondol, mi a valószínusége?
*annak, hogy ha három év múlva megkérdezi valaki, hogy elégedett-e az életével, akkor igennel fog válaszolni, mit gondol, mi a valószínusége?
*annak, hogy ha három év múlva megkérdezi valaki, hogy milyen az egészsége, azt válaszolja, hogy nagyon jó vagy kituno, mit gondol, mi a valószínusége?
*annak, hogy a következo három évben súlyos baleset áldozata lesz (ami miatt legalább 1 hétig kórházban kell maradnia vagy annál is súlyosabb, mit gondol, mi a valószínusége?
*annak, hogy édesanyja legalább 80 éves koráig élni fog, mit gondol, mi a valószínusége?

gen posexp_gen_08 = c185a + c185b + c185c + c185f + c185g
	replace posexp_gen_08 = posexp_gen_08 / 100
	lab var posexp_gen_08 "Positive expectations in general (2008)"
gen posexp_gen_08_imp = cond(1, (c185a_i == 1 | c185b_i == 1 | c185c_i == 1 | c185f_i == 1 | c185g_i == 1), 0)


* Positive expectations  - school, work (2008) - more is better

*annak, hogy sikeresen leérettségizik, mit gondol, mi a valószínusége?
*annak, hogy felsofokú diplomát szerez (legalább ba szint), mit gondol, mi a valószínusége?
*annak, hogy 35 évesen több pénzt fog keresni, mint az átlag, mit gondol, mi a valószínusége?
*annak, hogy 35 évesen a legjobban kereso 10 százalékba fog tartozni, mit gondol, mi a valószínusége?
*annak, hogy iskolái befejezése után talál magának rendszeres munkát, mit gondol, mi a valószínusége?
*annak, hogy havi nettó 100 ezer ft-nál többet fog keresni az elso munkahelyén, mit gondol, mi a valószínusége?
*annak, hogy havi nettó 200 ezer ft-nál többet fog keresni az elso munkahelyén, mit gondol, mi a valószínusége?

gen posexp_sch_08 = c185j+ 	c185k	+ c185m	+ c185n	+ c185o	+ c185p	+ c185q
	replace posexp_sch_08 = posexp_sch_08 / 100
	lab var posexp_sch_08 "Positive expectations (school, work)- 2008"
gen posexp_sch_08_imp = cond(1, (c185j_i == 1 | 	c185k_i == 1 |  c185m_i == 1 |  c185n_i == 1 |  c185o_i == 1 |  c185p_i == 1 |  c185q _i == 1 ), 0)

* Expectations 2008
gen exp_sal_avg_08 = c185m	
	replace exp_sal_avg_08 = exp_sal_avg_08 / 100
	lab var exp_sal_avg_08 "Exp: earn more than avg (2008)"
gen exp_sal_avg_08_imp = c185m_i == 1

gen exp_sal_10pct_08 = c185n	
	replace exp_sal_10pct_08 = exp_sal_10pct_08 / 100
	lab var exp_sal_10pct_08 "Exp: earn best 10% (2008)"
gen exp_sal_10pct_08_imp = c185n_i == 1

gen exp_empl_08 = c185o	
	replace exp_empl_08 = exp_empl_08 / 100
	lab var exp_empl_08 "Exp: permanent employment (2008)"
gen exp_empl_08_imp = c185o_i == 1


gen exp_sal_100net_08 = c185p	
	replace exp_sal_100net_08 = exp_sal_100net_08 / 100
	lab var exp_sal_100net_08 "Exp: earn more than net HUF100.000 (2008)"
gen exp_sal_100net_08_imp = c185p_i == 1

gen exp_sal_200net_08 = c185q	
	replace exp_sal_200net_08 = exp_sal_200net_08 / 100
	lab var exp_sal_200net_08 "Exp: earn more than net HUF200.000 (2008)"
gen exp_sal_200net_08_imp = c185q_i == 1
	
	
* Expectations 2012
gen exp_sal_avg_12 = f155m 	
	replace exp_sal_avg_12 = exp_sal_avg_12 / 100
	lab var exp_sal_avg_12 "Exp: earn more than avg (2012)"
gen exp_sal_avg_12_imp = f155m_i == 1

gen exp_sal_10pct_12 = f155n 	
	replace exp_sal_10pct_12 = exp_sal_10pct_12 / 100
	lab var exp_sal_10pct_12 "Exp: earn best 10% (2012)"
gen exp_sal_10pct_12_imp = f155n_i == 1

gen exp_empl_12 = f155o	
	replace exp_empl_12 = exp_empl_12 / 100
	lab var exp_empl_12 "Exp: permanent employment (2012)"
gen exp_empl_12_imp = f155o_i == 1


gen exp_sal_100net_12 = f155q	
	replace exp_sal_100net_12 = exp_sal_100net_12 / 100
	lab var exp_sal_100net_12 "Exp: earn more than net HUF100.000 (2012)"
gen exp_sal_100net_12_imp = f155q_i == 1

gen exp_sal_200net_12 = f155r	
	replace exp_sal_200net_12 = exp_sal_200net_12 / 100
	lab var exp_sal_200net_12 "Exp: earn more than net HUF200.000 (2012)"
gen exp_sal_200net_12_imp = f155r_i == 1
	
	

* Height
gen height_06 = af048xxx	
gen height_08 = c200	
gen height_09 = d190	
gen height_11 = e160	
gen height_12 = f158
foreach num in 06 08 09 11 12 {
	lab var height_`num' "Height 20`num'"
}

* Weight
gen weight_06 =  af047xxx		
gen weight_08 =  c199	
gen weight_09 =  d189	
gen weight_11 =  e159	
gen weight_12 =  f157
foreach num in 06 08 09 11 12 {
	lab var weight_`num' "Weight 20`num'"
}

* Grade retention
gen retention_06 = cond(1, (af071xxx >0 | af072xxx>0), 0)
	lab var retention_06 "Grade retention 2006"
gen retention_06_imp = cond(1, (af071xxx_i == 1 | 	af072xxx_i == 1), 0)

gen ret_1_4 = af071xxx >0
	lab var ret_1_4 "Grade retention in grades 1-4"
gen ret_5_8 = af072xxx >0
	lab var ret_5_8 "Grade retention in grades 5-8"


* School environment
*hogyan érez az iskolája iránt?
*mennyire nyomasztják Önt az iskolai feladatok?
*tanáraim arra ösztönöznek, hogy elmondjam a véleményemet az osztályban. ezzel mennyire ért egyet?
*tanáraink igazságosan bánnak velünk. ezzel mennyire ért egyet?
*ha külön segítségre van szükségem, megkapom tolük. ezzel mennyire ért egyet?
*tanárait érdekli, hogy milyen az Ön egyénisége. ezzel mennyire ért egyet?
*az egyik tanár megütötte vagy megverte valamelyik iskolatársát, ez elofordult az elmúlt tanévben?
*az egyik iskolatársa megütötte vagy megverte valamelyik tanárt, ez elofordult az elmúlt tanévben?


gen school_env_08 = 25-(c139 + c140 + c141a +	c141b +	c141c +	c141d -	c142a -	c142b) 
	lab var school_env_08 "School environment 2008"
gen school_env_08_imp = cond(1, (c139_i == 1 | c140_i == 1 | c141a_i == 1 |	///
c141b_i == 1 |	c141c_i == 1 |	c141d_i == 1 |	c142a _i == 1 |	c142b_i == 1), 0)

* Study time
*egy átlagos hétköznap hány órát tölt az iskolai órákra való felkészüléssel?
*ebben a tanévben milyen gyakran fordul elo, hogy hétköznap este nyolc óra után tanul?
*hétvégén összesen hány órát tölt tanulással?

gen study_time_07 = b168  +b169
	lab var study_time_07 "How many hours a week do you spend with studying? (2007)"
gen study_time_07_imp = cond(1, (b168_i == 1 |  b169_i == 1), 0)

gen study_time_08 = c145 +c147 
	lab var study_time_08 "How many hours a week do you spend with studying? (2008)"
gen study_time_08_imp = cond(1, (c145_i == 1 | c147_i == 1), 0)

gen night_study_07 = b168a != 1
	gen night_study_07_imp = b168a_i == 1
	lab var night_study_07 "Study after 8pm on weekday (2007)"

gen night_study_08 = c146 != 1
	gen night_study_08_imp = c146_i == 1
	lab var night_study_08 "Study after 8pm on weekday (2008)"
	
gen weekend_study_07 = b169 != 1
	gen weekend_study_07_imp = b169_i == 1
	lab var weekend_study_07 "Study at the weekends (2007)"

gen weekend_study_08 = c147 != 1
	gen weekend_study_08_imp = c147_i == 1
	lab var weekend_study_08 "Study at the weekends (2008)"


* University application - outcome variable, not imputed - but there are no missings
gen univ_app = cond(1, (e83==1 | e85==1 |	f82==1 | e87==1 |	f84==1 | (e89==1 & e90a1 != 99) |	f86==1 | f74 == 1 | e130== 1	| f127== 1), 0)
	lab var univ_app "University application"
	
gen ua_09 = e83 == 1 
	
* University enrolment
gen uni_enrol = e130== 1	| f127== 1
	lab var uni_enrol "Attending college (2011, 2012)"

* Fire from school
gen fire_06 = cond(1, (af070a15 == 4 | af070a15 == 5 | af070b15 == 4 | af070b15 == 5 | af070c15 == 4 | af070c15 == 5), 0)
	lab var fire_06 "Fired from school"

* Parents divorce
gen divorce_06 = cond(1, (af008xxx == 4 | af012xxx == 4), 0)
	lab var divorce_06 "Parents divorced"

* SNI
lab var snix "Special education needs"
recode snix (.=0) (2=1)
	
	
* Abuse
*az elmúlt néhány hónapban milyen gyakran bántalmazták Önt az iskolában?
*egy családtag, rokon, hozzátartozó. elofordult 14 éves korom ELOTT, hogy szavakkal bántott, lelkileg bántalmazott, megalázott?
*egy barát, vagy tanár vagy más ismeros. elofordult 14 éves korom ELOTT, hogy szavakkal bántott, lelkileg bántalmazott, megalázott?
*egy ismeretlen. elofordult 14 éves korom ELOTT, hogy szavakkal bántott, lelkileg bántalmazott, megalázott?
*egy családtag, rokon, hozzátartozó. elofordult 14 éves korom ELOTT, hogy fizikailag bántalmazott?
*egy barát, vagy tanár vagy más ismeros. elofordult 14 éves korom ELOTT, hogy fizikailag bántalmazott?
*egy ismeretlen. elofordult 14 éves korom ELOTT, hogy fizikailag bántalmazott?
*egy családtag, rokon, hozzátartozó. elofordult 14 éves korom ELOTT, hogy szexuálisan bántalmazott?
*egy barát, vagy tanár vagy más ismeros. elofordult 14 éves korom ELOTT, hogy szexuálisan bántalmazott?
*egy ismeretlen. elofordult 14 éves korom ELOTT, hogy szexuálisan bántalmazott?

gen abuse_b14 =  fo25aa + fo25ab + fo25ac + fo25ad + fo25ae + fo25af + fo25ag + fo25ah + fo25ai
	lab var abuse_b14 "Mental, physical or sexual abuse before age 14"
gen abuse_b14_imp = cond(1, (fo25aa_i == 1 | fo25ab_i == 1 | ///
	fo25ac_i == 1 | fo25ad_i == 1 | fo25ae_i == 1 | fo25af_i == 1 | fo25ag_i == 1 ///
	| fo25ah_i == 1 | fo25ai_i == 1), 0)
	
gen abuse_a14 = fo26aa +	fo26ab	+ fo26ac	+ fo26ad	+ fo26ae	+ fo26af	+ fo26ag	+ fo26ah	+ fo26ai
	lab var abuse_a14 "Mental, physical or sexual abuse AFTER age 14"
gen abuse_a14_imp = cond(1, (fo26aa_i == 1 | fo26ab_i == 1 | ///
	fo26ac_i == 1 | fo26ad_i == 1 | fo26ae_i == 1 | fo26af_i == 1 | fo26ag_i == 1 ///
	| fo26ah_i == 1 | fo26ai_i == 1), 0)

	
* Negative life events
	* Loose job
	gen lost_job_07 = 0
		replace lost_job_07 = 1 if work_06 == 1 & work_07 == 0  
		lab var lost_job_07 "Lost job in 2007"
	gen lost_job_08 = 0
		replace lost_job_08 = 1 if work_07 == 1 & work_08 == 0  
		lab var lost_job_08 "Lost job in 2008"
	gen lost_job_09 = 0
		replace lost_job_09 = 1 if work_08 == 1 & work_09 == 0  
		lab var lost_job_09 "Lost job in 2009"
	
	* Unemployed 
	gen unemp_06 = 0
		replace unemp_06 = 1 if ad015xxx == 1 
		replace unemp_06 = . if ad015xxx == -6
		lab var unemp_06 "Unemployed in 2006"	
	gen unemp_07 = 0
		replace unemp_07 = 1 if b217 == 1 
		replace unemp_07 = . if b217 == -6 | b217 == 9 
		lab var unemp_07 "Unemployed in 2007"	
	gen unemp_08 = 0
		replace unemp_08 = 1 if c181 == 1 
		replace unemp_08 = . if c181 == -6
		lab var unemp_08 "Unemployed in 2008"	
	gen unemp_09 = 0
		replace unemp_09 = 1 if d182 == 1 
		replace unemp_09 = . if d182 == -6
		lab var unemp_09 "Unemployed in 2009"	
* Death in the family
gen death_08 = c48e1	
gen death_08_imp = c48e1_i	
	recode death_08 (2=0)
gen death_09 = d48e1
gen death_09_imp = d48e1_i
	recode death_09 (2=0)
	
lab var death_08 "Death in the family (2008)"
lab var death_09 "Death in the family (2009)"
	
* Accident
gen accident_07 = b81	
gen accident_07_imp = b81_i	
	recode accident_07 (2=0) 

gen accident_08 = c71	
gen accident_08_imp = c71_i	
	recode accident_08 (2=0) 

gen accident_09 = d77
gen accident_09_imp = d77_i
	recode accident_08 (2=0) 

lab var accident_07 "Accident in the family (2007)"
lab var accident_08 "Accident in the family (2008)"
lab var accident_09 "Accident in the family (2009)"

* Illness

gen illness_07 = b82	
gen illness_07_imp = b82_i	
	recode illness_07 (2=0) 

gen illness_08 = c72	
gen illness_08_imp = c72_i	
	recode illness_08 (2=0) 

gen illness_09 = d78
gen illness_09_imp = d78_i
	recode illness_08 (2=0) 

lab var illness_07 "Illness in the family (2007)"
lab var illness_08 "Illness in the family (2008)"
lab var illness_09 "Illness in the family (2009)"


* Positive life events
	* Child Birth - we dont have data for 2006
	gen childbirth_07 = 0
		replace childbirth_07 = 1 if bk19 == 1 
	gen childbirth_08 = 0
		replace childbirth_08  = 1 if (bk19 == -6 & cg19 >0 & cg19 < 6) | (bk19 == 1 & cg19 == 2)
		replace childbirth_08  = . if (bk19 == . | cg19 == .)
	gen childbirth_09 = 0
		replace childbirth_09 = 1 if (cg19 == -6 & dg19 > 0 & dg19 < 4) | (cg19 > -6 & cg19 < 6 &  dg19 != . &  cg19 <  dg19)
		replace childbirth_09  = . if (cg19 == . | dg19 == .)
	lab var childbirth_07 "Child birth (2007)"
	lab var childbirth_08 "Child birth (2008)"
	lab var childbirth_09 "Child birth (2009)"
	* New job
	gen new_job_07 = 0
		replace new_job_07 = 1 if work_06 == 0 & work_07 == 1  
		lab var new_job_07 "New job in 2007"
	gen new_job_08 = 0
		replace new_job_08 = 1 if work_07 == 0 & work_08 == 1  
		lab var new_job_08 "New job in 2008"
	gen new_job_09 = 0
		replace new_job_09 = 1 if work_08 == 0 & work_09 == 1  
		lab var new_job_09 "New job in 2009"
		
gen event_num = lost_job_07 + lost_job_08 + lost_job_09 + childbirth_08 + childbirth_09 ///
+ new_job_07 + new_job_08 + new_job_09 + death_08 + death_09 + accident_07 + accident_08 ///
+ accident_09 
		lab var event_num "Number of exogenous life events"
		
gen pos_event_num =  childbirth_08 + childbirth_09 + new_job_07 + new_job_08 + new_job_09  
		lab var pos_event_num "Number of positive life events"

gen neg_event_num = lost_job_07 + lost_job_08 + lost_job_09 + death_08 + death_09 ///
+ accident_07 + accident_08 + accident_09 
		lab var neg_event_num "Number of negative life events"	

		************************** -- egyik vagy másik igen -- igen!
* Applications to university
	gen univapp_plan = 0
		replace univapp_plan = 1 if d152 == 3 | e119 ==  3 | f116 == 3 
		replace univapp_plan = . if d152 == . & e119 ==  . & f116 == . 
		lab var univapp_plan "Plan to apply to university"
		lab def univapp_plan 1 "Yes" 0 "No"
		lab val univapp_plan univapp_plan

* Parent plans: adolescent's highest education
gen parent_ideal_06 = cond(1, af084xxx > 5, 0)
		lab var parent_ideal_06 "Ideal education for child: university (2006)"
gen parent_ideal_06_imp = af084xxx == 1
		
gen parent_min_06 = cond(1, af085xxx > 5, 0)
		lab var parent_min_06 "Minimum wanted education for child: university (2006)"
gen parent_min_06_imp = af085xxx == 1		

gen parent_pay_06 = cond(1, af086xxx > 5, 0)
		lab var parent_pay_06 "How long can you pay for child's education: university (2006)"
gen parent_pay_06_imp = af086xxx == 1		


		
* Adverse behaviour in the environment
gen drugenv_08 = c196a + c196b + c196c + c196d
	lab var drugenv_08 "How many friends smoke/drink/take drugs (2008)"
gen drugenv_08_imp = (c196a_i == 1 | c196b_i == 1 | c196c_i == 1 | c196d_i == 1)
	
* Adverse behaviour
recode cfiat4 (2=0)
recode cfiat7 (1=0) (2=1) (4=6) (5=15)
recode cfiat8 (1=0) (2=1) (4=6) (5=15)
gen drug_08 = cfiat4 + cfiat7 + cfiat8
lab var drug_08 "Smoke/drink/take drugs (2008)"
gen drug_08_imp = (cfiat4_i == 1 | cfiat7_i == 1 | cfiat8_i == 1)
		
* Friends
gen numfriend_08 = c197a + c197b
	lab var numfriend_08 "Number of friends (2008)"
gen numfriend_08_imp = (c197a_i == 1 | c197b_i == 1)

	
* 	Sex
gen sex_08 = cfiat16
	recode sex_08 (2 = 11) (3 = 12) (4 = 13) (5 = 14) (6 = 15) (7 = 16) (1 = 18)
	lab var sex_08 "How old at first sex (2008)"
gen sex_08_imp = (cfiat16_i == 1)
		
* Crime
gen crime_12 = fo16 + fo17 + fo22 + fo23 + fo24		
	lab var crime_12 "Committed a crime ever (2012)"
gen crime_12_imp = (fo16_i == 1 | fo17_i == 1 | fo22_i == 1 | fo23_i == 1 | fo24_i == 1) 

* School dropout
gen dropout_09 = d92 == -6
	lab var dropout_09 "School dropout (2009)"
	
* Dropout in which year 
gen dropout_year = 5
	replace dropout_year = 4 if d92 == -6
	replace dropout_year = 3 if c84 == -6
	replace dropout_year = 2 if b95 == -6
	replace dropout_year = 1 if af089xxx == -6

* Dropout age 

gen dropout_age = 22
		replace dropout_age = 21 if f88 == 5 
		replace dropout_age = 20 if e91	== 5 & f88 == 5 
		replace dropout_age = 18 if d81	== 5 & e91	== 5 & f88 == 5 
		replace dropout_age = 17 if c73	== 5 & d81	== 5 & e91	== 5 & f88 == 5 
		replace dropout_age = 16 if b83	== 5 & c73	== 5 & d81	== 5 & e91	== 5 & f88 == 5 
		replace dropout_age = 15 if af089xxx == -6 & b83	== 5 & c73	== 5 & d81	== 5 & e91	== 5 & f88 == 5 
lab var dropout_age "Dropout age"
gen dropout_age_imp = (b83_i	== 1 | c73_i	== 1 | d81_i	== 1 | e91_i	== 1 | f88_i == 1 )

foreach i in 16 17 18 20 21 {
    gen inschool_`i' = dropout_age > `i'
	lab var inschool_`i' "In school at age `i'"
	gen inschool_`i'_imp = dropout_age_imp == 1
	}


* Maturity exam
gen maturex = e75 == 1
	replace maturex = 1 if f72 == 1
	lab var maturex "Graduating from high school"
	
* GPA 
	replace b127tiz = b127tiz/10 if b127tiz < 10
	replace b127tiz = b127tiz/100 if b127tiz >= 10
gen gpa_07 = b127eg + b127tiz
	replace gpa_07  = 5 if gpa_07  > 5 & gpa_07  < 6 

	replace c102t = c102t/10 if c102t < 10
	replace c102t = c102t/100 if c102t >= 10
gen gpa_08 = c102e + c102t
	replace gpa_08  = 5 if gpa_08  > 5 & gpa_08  < 6 
	recode gpa_08 (0=1)
	
	
	replace d110t = d110t/10 if d110t < 10
	replace d110t = d110t/100 if d110t >= 10
gen gpa_09 = c102e + d110t
	replace gpa_09  = 5 if gpa_09  > 5 & gpa_09  < 6 
	replace gpa_09  = 1 if gpa_09  < 1 

* Number of children
gen kidnum_11 = e165
		lab var kidnum_11 "Number of children (2011)"
gen kidnum_11_imp = e165_i == 1 		

gen kidnum_09 = dg19
		lab var kidnum_09 "Number of children (2009)"
gen kidnum_09_imp = dg19_i == 1 

* First child at which age
gen firstchild_age = 21
			replace firstchild_age = 20 if f163 > 0
			replace firstchild_age = 19 if e165 > 0
			replace firstchild_age = 18 if dg19 > 0
			replace firstchild_age = 17 if cg19 > 0
			replace firstchild_age = 16 if bk19 > 0
	lab var firstchild_age "Age at first child"


* Do you look good? 
gen lookgood_08 = 6 - cfiat14
	lab var lookgood_08 "Do you look good? (2008)"
gen lookgood_08_imp = cfiat14_i == 1 


* Sedulity
gen sedulity_07 = b126h
	lab var sedulity_07 "Sedulity grade (2007)"
gen sedulity_07_imp = b126h_i == 1 

gen sedulity_08 = c101h
	lab var sedulity_08 "Sedulity grade (2008)"
gen sedulity_08_imp = c101h_i == 1 

gen sedulity_09 = d109h
	lab var sedulity_09 "Sedulity grade (2009)"
gen sedulity_09_imp = d109h_i == 1 

* Variable labels
lab var acognisc "HOME cognitive scale"
lab var aemotisc "HOME emotional scale"
lab var o "Reading score"
lab var m "Mathematics score"

factor exp*08 [weight = weight]
predict expectations_08
	lab var expectations_08 "Expectations 1 (2008)"
/*loadingplot
graph export "$overleaf\factorloadings_expectations_08.pdf", replace
graph export "$results\factorloadings_expectations_08.pdf", replace
*/

factor exp*12 [weight = weight]
predict expectations_12
	lab var expectations_12 "Expectations (2012)"
/*loadingplot 
graph export "$overleaf\factorloadings_expectations_12.pdf", replace
graph export "$results\factorloadings_expectations_12.pdf", replace
*/
	
factor study_time_07 sedulity_07 night_study_07 weekend_study_07 [weight = weight]
predict effort_07
	lab var effort_07 "Effort (2007)"
/*loadingplot 
graph export "$overleaf\factorloadings_effort_07.pdf", replace
graph export "$results\factorloadings_effort_07.pdf", replace
*/
	
factor study_time_08 sedulity_08 night_study_08 weekend_study_08 [weight = weight]
predict effort_08
	lab var effort_08 "Effort (2008)"
/*loadingplot 
graph export "$overleaf\factorloadings_effort_08.pdf", replace
graph export "$results\factorloadings_effort_08.pdf", replace
*/
factor study_time_07 sedulity_07 night_study_07 weekend_study_07 study_time_08 sedulity_08 night_study_08 weekend_study_08 sedulity_09 [weight = weight]
predict effort_07_08_09
lab var effort_07_08_09 "Effort (2007-8-9)"
/*loadingplot
graph export "$overleaf\factorloadings_effort_07_08_09.pdf", replace
graph export "$results\factorloadings_effort_07_08_09.pdf", replace
*/


gen smoke_08 = cfiat5 != 4 
	replace smoke_08 = . if cfiat5 == . 

gen smoke_12 = fo1 != 4 
	replace smoke_12 = . if fo1 == . 

lab var sniszam "SEN students in the class"
lab var letszam "# of students in the class"

gen inchigh = 3
	replace inchigh = 0 if hhinc_07 < 130000
	replace inchigh = 1 if hhinc_07 > 212400
	
* Parent type by constraints
gen ct_type = 1 if parent_min_06 == 0 & parent_ideal_06 == 0
	replace ct_type = 2 if parent_min_06 == 0 & parent_ideal_06 == 1
	replace ct_type = 3 if parent_min_06 == 1 & parent_ideal_06 == 1
	replace ct_type = 4 if parent_min_06 == 1 & parent_ideal_06 == 0
lab def ct_type 1 "Strict low" 2 "Challenge" 3 "Strict high" 4 "Illogical"
lab val ct_type ct_type

gen univ_if_plan = 0 if uni_enrol == 0 & univapp_plan == 1
	replace univ_if_plan = 1 if uni_enrol == 1 & univapp_plan == 1
	


save $newdata\eletpalya_for_regs_vars_2021, replace

	


*****************************************************************		
/*
There is some problem with the variable names!! 

* Interactions

drop *_imp
*Varlist
* Control varlist for LOC_2006
global varlist06 i.regio moth_* fath_* acognisc  aemotisc sleepwith_06* hhsize    social_disad* i.mothwork_06* i.fathwork_06* fin_dist* female /*i.t1ho*/  mother* father* snix sniszam letszam hhinc_06	childcare* tales* amkor* amkor_sq abuse_b14* /*height_06 height06Xfemale weight_06*/ divorce_06 roma_07 bw_u2500* sochome_06* stepparents* ed*

global channels06   subjhealth_06* emot_stability_06* self_esteem_06* bullying_06* sociable_06* objhealth*06* health*06* work_06* swork_06* retention_06 fire_06 age af071xxx af072xxx

*
* Control varlist for LOC_2009

global varlist09 $varlist06 sleepwith_* abuse_a14* death_* accident_* illness_* /*height_12 height12Xfemale weight_**/ i.mothwork* i.fathwork*  hhinc_*

global channels09 $channels06 event_num pos_event_num  neg_event_num   subjhealth_* emot_stability_* self_esteem_* bullying_* sociable_* objhealth* health* school_env_08* study_time* work_* swork_* lost_job_* /*unemp_**/  childbirth_* new_job_* posexp_gen_08* posexp_sch_08* drugenv_08* numfriend_08* sex_08* drug_08* bullying_08*  self_esteem_09* kidnum_11* firstchild_age relig_07 lookgood_08*


* Outcome variables
*univapp_plan inschool_21 dropout_age univ_app maturex
global locvars loc_06 loc_09 
global cogn o m 
global sedul study_time* sedulity* 
global expect exp*08*



*$varlist09 $channels09  
global allvars $locvars $cogn $sedul $expect

foreach var1 of varlist $allvars {
    foreach var2 of varlist $allvars  {
		gen int_`var1'_`var2' = `var1'*`var2'
	}
}




