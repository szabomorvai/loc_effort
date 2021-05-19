* PDS lasso R-squared values
* there is no way to directly get the R2 for pds lasso, as opposed to lasso where lassogof does it. 
* it is not even saved in ereturn - see: eret list

* So I extract the selected variables and run simple OLS. 
* The results are not quite the same as those of pdslasso, we'll need to elaborate on this a bit more

	mat B=e(b)
	mat list B
	local clist
	tokenize "`: colnames e(b)'"

forval j = 1/`= colsof(B)' {
 if B[1, `j'] != 0 & index("``j''","_cons")==0 {
 local clist `clist' ``j''
 *di "`clist'"
 }
 }
global clist `clist'

