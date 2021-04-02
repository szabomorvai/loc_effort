* Stability of trats

* Kiss Hubert János - Szabó-Morvai Ágnes

* 2018-05-25

global origdata C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Adat\Eletpálya_adatok_new
global newdata C:\Users\szabomorvai.agnes\Dropbox\Research\Traits_Stabil\Adat\Traitsdata

	


clear

use $origdata\eletpalya_a
keep sorszam suly isuly acfho acnap2 snix sniszam ac001xxx	ac002axx	ac002bxx	ac002cxx	ac002dxx	ac003xxx	af160xxx af162xxx af183xxx af185xxx ///
ac004xxx	ac007xxx	acogni1      	acogni10     	acogni11     	///
acogni12     	acogni13     	acogni2      	acogni3      	acogni4      	///
acogni5      	acogni6      	acogni7      	acogni8      	acogni9      	///
acognisc     	ad002axx	ad002bxx	ad004axx	ad004bxx	ad005xxx	///
ad012axx	ad015xxx	ad017xxx	ad024axx	ad026xxx	ad028xxx	ad031axx	///
ad031bxx	ad031dxx	ad031hxx	ad033axx	ad033bxx	ad033cxx	ad033dxx	///
ad033exx	ad033fxx	ad033gxx	ad033hxx	ad034axx	ad034bxx	ad034cxx	///
ad034dxx	ad034exx	ad034fxx	ad034gxx	ad034hxx	ad034ixx	ad034jxx	///
ad035axx	ad035bxx	ad035cxx	ad035dxx	ad035exx	ad035fxx	ad035gxx	///
ad035hxx	ad035ixx	ad036axx	ad036bxx	ad036cxx	ad036dxx	ad037axx	///
ad037bxx	ad037cxx	ad037dxx	ad037exx	ad037fxx	ad037gxx	ad038xxx	///
ad039xxx	ad040xxx	ad041xxx	aekor03	aekor151	aekor46	aekor714	aemoti1	///
aemoti10     	aemoti11     	aemoti12     	aemoti13     	aemoti14     	///
aemoti2      	aemoti3      	aemoti4      	aemoti5      	aemoti6      	///
aemoti7      	aemoti8      	aemoti9      	aemotisc	aetest	aev	af001xxx	///
af002a01	af002a02	af002a03	af002a04	af002a05	af002a06	af002a07	///
af002a08	af002a09	af002a10	af002a11	af006x01	af006x02	af007xxx	///
af008xxx	af009xxx	af010x01	af010x02	af011xxx	af016a01	af016a03	///
af016b01	af016b03	af021xxx	af023xxx	af052xxx	af054xxx	af056xxx	///
af075axx	af075bxx	af075cxx	af078xxx	af079xxx	af090xxx	af091xxx	///
af134xxx	af144axx	af144bxx	af166xxx	af189xxx	af202xxx	af208xxx	///
af209xxx	af212axx	af213xxx	af215a01	af215b01	af216a01	af216b01	///
af217a01	af217b01	af221axx	af221bxx	af221cxx	af221dxx	af221exx	///
af222axx	af222bxx	af222cxx	afanye	afcsall	afdolg	afedes	afellmun	///
afellnev	afellnyu	afellosz	afellszo	afisk	afisk5	afkor	afoszt	///
afrmunka	afvan	aho	ahome1       	ahome10      	ahome11      	ahome12      	///
ahome13      	ahome14      	ahome15      	ahome16      	ahome17      	///
ahome18      	ahome19      	ahome2       	ahome20      	ahome21      	///
ahome22      	ahome23      	ahome24      	ahome25      	ahome26      	///
ahome27      	ahome3       	ahome4       	ahome5       	ahome6       	///
ahome7       	ahome8       	ahome9       	ahomesc      	aitemi_a     	///
aitemi_b     	amanye       	amcsall      	amdolg	amedes	amegeszs	///
amellmun	amellnev	amellnyu	amellosz	amellszo	amisk	amisk5	///
amkor	amoszt	amrmunka	amvan        	ascore       	ascore_c     	///
ascore_e     	asectf_a     	atest        	atanul	azon	diakid	efsnisza	///
evfolyam	hullam	isktip_1		letszam	m	m_zpsc	megye	megyenev	o	///
o_zpsc	omid	osztid	regio	t1ev	t1ho	t1nap	t2	telkod_t	telnev_t ///
af002a05	af002a06	af002a07	af002a08	af002a09	af002a10	af002a11	 ///
af203xxx	af205xxx	af206xxx ad024bxx af002b04	af002b12	af002c04	af002c12	///
af002d04	af002d12	af002e04	af002e12	af002f04	af002f12	af002g04	///
af002g12	af002h04	af002h12 af008xxx	af012xxx	af047xxx	af048xxx	///
af070a15	af070b15	af070c15	af071xxx	af072xxx ///
af167xxx af168xxx af190xxx af191xxx af089xxx af084xxx af085xxx af086xxx
	

gen sample_a = 1
save $newdata\eletpalya_a_short, replace

	
	
use $origdata\eletpalya_bb

keep b130eg	b130tiz	b122	b205	b217	b219	bl2	bl01neme	bl01szul	bl01i	///
bl01j	bl01k	bl01l	bl01m	bl01n	bl01o	bl01p	bl01q	b3	b11	b102	b103 ///
	b25	b73	b75a1	b75b1	b83	b87	b168	b168a	b169	b4	b4a	b12	b12a	///
	b43	b42a	b42b	b42c	b44a	b57	b56a	b56b	b56c	bk12a	bk12b	///
	bk12c	bk13	b80	bk20a1	///																							
bev       	btanul	azon ///																														
isuly_b      	bmvan        	bmedes       	bmazona      	bmkor        	///
bmcsall      	bmisk        	bmisk5       	bmoszt       	bmdolg       	///
bmellnev     	bmellmun     	bmellnyu     	bmellszo     	bmellosz     	///
bmanye       	bmrmunka     	bfvan        	bfedes       	bfazona      	///
bfkor        	bfcsall      	bfisk        	bfisk5       	bfoszt       	///
bfdolg       	bfellnev     	bfellmun     	bfellnyu     	bfellszo     	///
bfellosz     	bfrmunka     	btest        	betest       	bekor03      	///
bekor46      	bekor714     	bekor151     				///
bc7        	bc8a       	bc8b       	bc8c       	bc8d       	bc9        	bc10     ///
 bl01k	bl01l	bl01m	bl01n	bl01o	bl01p	bl01q	b26	b28	b29	b65	b65a	 ///
 b81	b82 b80	bk19	b168	b168a	b169	b193 b6 	b14	b44c b44d b58c ///
b58d b222 b223 b95 b126h	b83 b127eg	b127tiz	b168a	b169




gen sample_b = 1
save $newdata\eletpalya_b_short, replace
	
	
use $origdata\eletpalya_cc

keep c105e	c105t	c111	c172	c181	c183	c198	c202a	c202b	c202d	///
c202h	cl2	cl01neme	cl01szul	cl01i	cl01j	cl01k	cl01l	cl01m	cl01n	///
cl01o	cl01p	cl01q	c3	c8	c89	c90	c22	c59	c61a1	c61b1	c73	c80	c135a	///
c135b	c136a	c136b	c137a	c137b	c145	c146	c147	c32	c31a	c31b	///
c31c	c33a	c41	c40a	c40b	c40c	cp13a	cp13b	cp13c	cp14	c69	///
cg20a1	c185b	c185m	c185o	cfiat1	cfiat2										///																																																														
seged66	azon																	///																																																																												
isuly_c      	cmvan        	cmedes       	cmazona      	cmkor        	///
cmcsall      	cmisk        	cmisk5       	cmoszt       	cmdolg       	///
cmellnev     	cmellmun     	cmellnyu     	cmellszo     	cmellosz     	///
cmrmunka     	cfvan        	cfedes       	cfazona      	cfkor        	///
cfcsall      	cfisk        	cfisk5       	cfoszt       	cfdolg       	///
cfellnev     	cfellmun     	cfellnyu     	cfellszo     	cfellosz     	///
cfrmunka     	ctest        	cetest       	cekor03      	cekor46      	///
cekor714     	cekor151     	cl01k	cl01l	cl01m	cl01n	cl01o	cl01p	 ///
cl01q	c16	c24	c25	c50	c50a	c48e1	c48e2	c71	c72	c196a	c196b	c196c	 ///
c196d	c197a	c197b	cfiat15	cfiat16	cfiat4	cfiat5 c69	cg19 c200	c139	///
c140	c141a	c141b	c141c	c141d	c142a	c142b	c145	c146	c147	///
c185a	c185b	c185c	c185d	c185e	c185f	c185g	c185h	c185i	c185j	///
c185k	c185l	c185m	c185n	c185o	c185p	c185q	ck11h	ck12e	ck12t	///
ck16 c199 	c5	c10 c33c c33d c42c c42d cfiat14 cfiat7 cfiat8 c84	c101h	c185m ///
c185n c185o c185p c185q c73 c102e	c102t	c146 c147



gen sample_c = 1														
save $newdata\eletpalya_c_short, replace

																
use $origdata\eletpalya_dd
														
keep d115e	d115t	d119	d173	d182	d184	d188	df1a	df1b	df1c	///
df2a df2b df2c df2d																///
df1d	df1e	df1f	df1g	df1h	df1i	df1j	dl2	dl01neme	dl01szul	///
dl01i	dl01j	dl01k	dl01l	dl01m	dl01n	dl01o	dl01p	dl01q	d3	d8	///
d97	d98	d22	d60	d62a1	d62b1	d81	d88	d32	d31a	d31b	d31c	d33a	d41	///
d40a	d40b	d40c	dp13a	dp13b	dp13c	dp14	d75	dg20a1				///																																					
ev          	seged63	azon													///										
dmvan        	dmedes       	dmazona      	dmkor        	dmcsall      	///
dmisk        	dmisk5       	dmoszt       	dmdolg       	dmellnev     	///
dmellmun     	dmellnyu     	dmellszo     	dmellosz     	dmrmunka     	///
dfvan        	dfedes       	dfazona      	dfkor        	dfcsall      	///
dfisk        	dfisk5       	dfoszt       	dfdolg       	dfellnev     	///
dfellmun     	dfellnyu     	dfellszo     	dfellosz     	dfrmunka     	///
dtest        	detest       	dekor03      	dekor46      	dekor714     	///
dekor151     																	///			
dc5     	dc6a    	dc6b    	dc6c    	dc6d    	dc7     	dc8      ///
dl01k	dl01l	dl01m	dl01n	dl01o	dl01p	dl01q	d16	d24	d25	d50	d50a	 ///
d48e1	d48e2	d77	d78 d75		dg19 	d152 d189	d190	df3a1	df3a2	df3a3 ///
	df3a4	df3a5	df3a6	df3a7	df3a8	df3b1	df3b2	df3b3	df3b4	df3b5 ///
	df3b6	df3b7	df3b8	df3c1	df3c2	df3c3	df3c4	df3c5	df3c6	df3c7	///
	df3c8	df3d1	df3d2	df3d3	df3d4	df3d5	df3d6	df3d7	df3d8	df4a	///
	df4b	df4c	df4d	df4e	df4f	df4g	df4h	df4i	df4j	df4k	///
	df4l	df4m	df4n	df4o	df4p	df4q	df4r	df4s	df4t	df4u	///
	df4v	df4w	df4x	df4y	df5a	df5b	df5c	df5d	df5e	df5f	///
	df5g	df5h	df5i	df5j	df5k	df5l	df5m	df5n	df7	df8	dk13h	///
	dk14e	dk14t	dk16 d5 d10 d33c d33d d42c d42d d92 d109h d81 d110e d110t 



																	
drop if azon == . 
gen sample_d = 1
save $newdata\eletpalya_d_short, replace


use $origdata\eletpalya_ee																
keep e70e	e70t	e35	e156	el2	el01neme	el01szul	el01i	el01j	el01k	///
el01l	el01m	el01n	el01o	el01p	el01q	e9	e18aa	e18ba	e91	e104	///
e97	es23	es22a	es22b	es22c	es24a	es32	es31a	es31b	es31c	ep14	///
ep15	ep25ev	ep25ho	ep26	eg54a1											///								
eev        	azon ///
emvan        	emedes       	emazona      	emkor        	emcsall      	///
emisk        	emisk5       	emoszt       	emeolg       	emellneev    	///
emellmun     	emellnyu     	emellszo     	emellosz     	emrmunka     	///
efvan        	 fazona	efedes       	efkor        	efcsall      	efisk   ///
     	efisk5       	efoszt       	efeolg       	efellneev    	efellmun     	///
		efellnyu     	efellszo     	efellosz     	/*efrmunka*/     	etest        	///
		eetest       	eekor03      	eekor46      	eekor714     	eekor151     ///			
		ec4      	ec10     	ec11a    	ec11b    	ec11c    	ec11d    	ec12     ///
 ec13  	el01k	el01l	el01m	el01n	el01o	el01p	el01q	e10	e13	e14	ep26a	 ///
 ep26b	e17	e17a	es17aa	e161a	e161b	e161c	e161d	e161e	e161f	e161g	 ///
 e161h	e162a	e162ac1	e162b	e162bc1	e162bc2	e162bc3	e162c	e162cc1	e162cc2	 ///
 e162cc3	e162d	e162dc1	e162dc2	e162dc3	e162e	e162ec1	e162ec2	e162ec3	e162f	 ///
 e162fc1	e162fc2	e162fc3	e162g	e162gc1	e162gc2	e162gc3	e162h	e162hc1	e162hc2	 ///
 e162hc3	e163a	e163b	e163c	e163d	e163e	e163f	e163g	ei24a1	ei24a4	 ///
 ei24a7	ei24a10	ei24b1	ei24b4	ei24b7	ei24b10	ei24c1	ei24c4	ei24c7	ei24c10	 ///
 ei24d1	ei24d4	ei24d7	ei24d10	ei24e1	ei24e4	ei24e7	ei24e10	ei24f1	ei24f4	 ///
 ei24f7	ei24f10	ei24g1	ei24g4	ei24g7	ei24g10	ei24h1	ei24h4	ei24h7	ei24h10	 ///
 ei25a1	ei25b1	ei25c1	ei25d1	ei25e1	ei25f1	ei25g1 e165 e89 e119 e159	e160 ///
 e83	e85	e87	e89	ek14h	ek15e	ek15t	ek17 es24c es24d es33c es33d e91 e75 ///
e90a1 e130
 





drop if azon == .  	
gen sample_e = 1								
save $newdata\eletpalya_e_short, replace
													
use $origdata\eletpalya_ff
																																																							
keep f67e	f67t	f36	f156	fl2	fl01neme	fl01szul	fl01i	fl01j	fl01k	///
fl01l	fl01m	fl01n	fl01o	fl01p	fl01q	f9	f19aa	f19ba	f88	f101	///
f94	fs24	fs23a	fs23b	fs23c	fs25a	fs33	fs32a	fs32b	fs32c	fp12	///
fp13	fp23ev	fp23ho	fp24	fg52a1	f151	f155b	f155m	fo14a	fo15	///
fo15sz	fo15b	fo15c	fo16	fo16sz	fo16b	fo16c	fo17	fo17sz	fo17b	///
fo17c	fo22	fo22sz	fo22b	fo22c	fo23	fo23sz	fo23b	fo23c	fo24	///
fo24sz	fo24b	fo24c	fk6		///															
fiev       	azon ///																																		
fmvan        	fmazona      	fmedes       	fmkor        	fmcsall      	///
fmisk        	fmisk5       	fmoszt       	fmdolg       	fmellnev     	///
fmellmun     	fmellnyu     	fmellszo     	fmellosz     	fmrmunka     	///
ffvan        	ffazona      	ffedes       	ffkor        	ffcsall      	///
ffisk        	ffisk5       	ffoszt       	ffdolg       	ffellnev     	///
ffellmun     	ffellnyu     	ffellszo     	ffellosz     	ffrmunka     	///
ftest        	fetest       	fekor03      	fekor46      	fekor714     	///
fekor151     f87a1	fc4       	fc10      	fc11a     	fc11b     	fc11c     	fc11d     	fc12      	///
fc13      fl01k	fl01l	fl01m	fl01n	fl01o	fl01p	fl01q	f10	f13	f14	 ///
fp24a	fp24b	f18	f18a	fs18aa	f159a	f159b	f159c	f159d	f159e	 ///
f159f	f159g	f159h	f160a	f160ac1	f160b	f160bc1	f160bc2	f160bc3	f160c	 ///
f160cc1	f160cc2	f160cc3	f160d	f160dc1	f160dc2	f160dc3	f160e	f160ec1	f160ec2	 ///
f160ec3	f160f	f160fc1	f160fc2	f160fc3	f160g	f160gc1	f160gc2	f160gc3	f160h	 ///
f160hc1	f160hc2	f160hc3	f161a	f161b	f161c	f161d	f161e	f161f	f161g	 ///
fo6	fo9a	fo9b	fo9c	fo9d	fo9e	fo9f	fo9g	fo9h	fo9i	fo1	 ///
fi20a1	fi20a4	fi20a7	fi20a10	fi20b1	fi20b4	fi20b7	fi20b10	fi20c1	fi20c4	 ///
fi20c7	fi20c10	fi20d1	fi20d4	fi20d7	fi20d10	fi20e1	fi20e4	fi20e7	fi20e10	 ///
fi20f1	fi20f4	fi20f7	fi20f10	fi20g1	fi20g4	fi20g7	fi20g10	fi20h1	fi20h4	 ///
fi20h7	fi20h10	fi21a1	fi21b1	fi21c1	fi21d1	fi21e1	fi21f1	fi21g1 f163  f86 ///
f116 f157	f158	f82	f84	f86	f155a	f155b	f155c	f155d	f155e	f155f	///
f155g	f155h	f155i	f155j	f155k	f155l	f155m	f155n	f155o	f155q	///
f155r	f155p	fo8f	fo16	fo16sz	fo16a	fo16b	fo16c	fo16d	fo16e	///
fo16f	fo16fe	fo17	fo17sz	fo17a	fo17b	fo17c	fo17d	fo17e	fo17f	///
fo17fe	fo22	fo22sz	fo22a	fo22b	fo22c	fo22e	fo22f	fo22fe	fo23	///
fo23sz	fo23a	fo23b	fo23c	fo23d	fo23e	fo23f	fo23fe	fo24	fo24sz	///
fo24a	fo24b	fo24c	fo24d	fo24e	fo24f	fo25aa	fo25ab	fo25ac	fo25ad	///
fo25ae	fo25af	fo25ag	fo25ah	fo25ai	fo25ba	fo25bb	fo25bc	fo25bd	fo25be	///
fo25bf	fo25bg	fo25bh	fo25bi	fo25ca	fo25cb	fo26aa	fo26ab	fo26ac	fo26ad	///
fo26ae	fo26af	fo26ag	fo26ah	fo26ai	fo26ba	fo26bb	fo26bc	fo26bd	fo26be	///
fo26bf	fo26bg	fo26bh	fo26bi	fo26ca	fo26cb	fk13h	fk14e	fk14t	fk7 ///
fs25c fs25d fs34c fs34d fo25aa	fo25ab	fo25ac	fo25ad	fo25ae	fo25af	fo25ag	///
fo25ah	fo25ai	fo25ba	fo25bb	fo25bc	fo25bd	fo25be	fo25bf	fo25bg	fo25bh	///
fo25bi	fo25ca	fo25cb f155m f155n f155o f155q f155r f88 f72 fk20a1 f74 f127



								
drop if azon == . 
gen sample_f = 1
save $newdata\eletpalya_f_short, replace

use $origdata\eletpalya_kieses_sulyok, clear
save $newdata\eletpalya_kieses_sulyok, replace


use $newdata\eletpalya_a_short

merge 1:1 azon using $newdata\eletpalya_b_short, gen(merge_b)

merge 1:1 azon using $newdata\eletpalya_c_short, gen(merge_c)

merge 1:1 azon using $newdata\eletpalya_d_short, gen(merge_d)

merge 1:1 azon using $newdata\eletpalya_e_short, gen(merge_e)

merge 1:1 azon using $newdata\eletpalya_f_short, gen(merge_f)

merge 1:1 sorszam using $newdata\eletpalya_kieses_sulyok, gen(merge_suly)


save $newdata\eletpalya_for_regs, replace


