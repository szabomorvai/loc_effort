* Locus of Control, Educational Attainment and College Aspirations: The Role of Effort
* Kiss Hubert János (R) Szabó-Morvai Ágnes
* 2021-05-17

clear
use $newdata\eletpalya_for_regs

foreach var of varlist ad005xxx ad026xxx ad028xxx c202* ad037*xx af016a01 af016b01 ///
	af023xxx af075*xx b193 af048xxx	c200	d190	e160	f158 af047xxx	c199	d189	///
	e159	f157 af071xxx af072xxx b168a	c146 c196* c197* c198 d188	e156	f156  ///
	c198	d188	e156	f156 b43 c32 d32 af084xxx af085xxx af086xxx ///
{
	recode `var' (9=.) 
}

foreach var of varlist cfiat4 {
	recode `var' (4=.) 
}

foreach var of varlist b65	c50	d50 {
	recode `var' (6=.) 
}

foreach var of varlist  af056xxx af054xxx c111 c139	c140	c141a	c141b	c141c	c141d ///
	c142a	c142b  b65	c50	d50 b127eg b127tiz c102e c102t d110e d110t {
	recode `var' (9=.) (-6=.)
}

foreach var of varlist  b126h c101h d109h {
	recode `var' (9=.) (-6=.) (0=.) (7=.)
}

foreach var of varlist  b222 b223 af084xxx af085xxx af086xxx {
	recode `var' (88=.) (99=.)
}

foreach var of varlist b193 cfiat16 b65	c50	d50 {
	recode `var' (8=.)
}

foreach var of varlist af167xxx af168xxx af190xxx af191xxx b122 d119 ad012axx b205 c172 d173 b81 b82 b193  af160xxx af162xxx af183xxx af185xxx ///
	b168	c145 b168a	c146 b169	c147  bk19	cg19	dg19	e165	f163 {
	recode `var' (-6=.) (99=.)
}

foreach var of varlist c185a c185b c185c c185g c185o c185f c185j c185k c185m c185n c185p c185q f155m f155n f155o f155q f155r {
	recode `var'   (999=.) 
}

foreach var of varlist ad024bxx {
	recode `var' (-6=.)  (9999=.) 
}

* Impute Mode
foreach var of varlist af056xxx ad005xxx b122 c111 d119   ad012axx b205 c172 d173 ad031*xx ///
	c202* ad028xxx ad033*xx ad034*xx ad035*xx ad037*xx af006x01 af006x02 af010x01 af010x02 ///
	af016a01 af016b01 af075*xx c48e1 d48e1 b81 c71	d77 b82	c72	d78 b193 ///
	d152 e119	f116 af071xxx af072xxx c139	c140	c141a	c141b	c141c	c141d	///
	c142a	c142b b168	c145 b168a	c146 b169	c147 cfiat1	fo25aa	fo25ab	fo25ac	///
	fo25ad	fo25ae	fo25af	fo25ag	fo25ah	fo25ai af054xxx  fo26aa	fo26ab	fo26ac	///
	fo26ad	fo26ae	fo26af	fo26ag	fo26ah	fo26ai c196* c197* cfiat16 cfiat4 cfiat7 cfiat8 ///
	b222 b223 c198	d188	e156	f156 fo16 fo17 fo22 fo23 fo24 df1a df1b df1c df1d df1e ///
	df1f df1g df1h df1i df1j f88 bk19	cg19	dg19	e165	f163 cfiat14 b43 c32 d32 ///
	af160xxx af162xxx af183xxx af185xxx b126h c101h d109h b83 c73 d81 e91 e75 f72 af084xxx af085xxx af086xxx  ///
{
	gen `var'_i = cond(`var' == ., 1, 0)
	egen imp_`var' = mode(`var')
		replace `var' = imp_`var' if `var' == .
}




* Impute mean
foreach var of varlist ad024bxx ad026xxx  af023xxx c185a c185b c185c c185g c185o ///
	c185f c185j c185k c185m c185n c185p c185q af048xxx	c200	d190	e160	f158 ///
	af047xxx	c199	d189	e159	f157 amkor o m b65	c50	d50 af167xxx af168xxx af190xxx af191xxx ///
	f155m f155n f155o f155q f155r ///
{
	gen `var'_i = cond(`var' == ., 1, 0)
	egen imp_`var' = mean(`var')
	replace `var' = imp_`var' if `var' == .
}


save $newdata\eletpalya_imputed , replace
