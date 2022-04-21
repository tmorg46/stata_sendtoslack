********************************************************************************
*** TABLE 2 - OLS REGRESSIONS
********************************************************************************

* 0 - Merge the individual dataset with the county dataset






********************************************************************************

* 1 - Clean some variables if needed

	* 1.1 Longevity in terms of logs
		gen log_longevity=log(age_death)
		
	* 1.2 Create Dummies for year of birth
		tab byear, gen(yob)
	
	* 1.3 Create dummies by state of birth
		gen bpl2=bpl
		replace bpl2=100 if bpl2>56 & bpl2!=.
		rename bpl bpl_o
		rename bpl2 bpl
		tab bpl, gen(bpl_d)		
		
		
		
		
		
********************************************************************************


* 2 - OLS REGRESSIONS FOR THE SAMPLE OF MALES BORN BETWEEN 1960-1930 WHO DIE BETWEEN 1975-2005 WHO DIE YOUNGER THAN 90

	* 2.1 Without Controling for the severity of the crisis
		reg log_longevity l_DRPCPBRE yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930  yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE age urban_c  white hispan_c foreign married black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930  yob* bpl* , cl(fips) 	


	* 2.2 Controling for the severity of the crisis
		reg log_longevity l_DRPCPBRE sev_index_c1_st yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE sev_index_c1_st black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930 pct_unempl_1930 yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE sev_index_c1_st age urban_c  white hispan_c foreign married black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930 pct_unempl_1930 yob* bpl* , cl(fips) 	

	
	



********************************************************************************

* 3 - OLS REGRESSIONS FOR THE SAMPLE OF FEMALES BORN BETWEEN 1960-1930 WHO DIE BETWEEN 1975-2005 WHO DIE YOUNGER THAN 90
	* 3.1 Without Controling for the severity of the crisis
		reg log_longevity l_DRPCPBRE yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930  yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE age urban_c  white hispan_c foreign married black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930  yob* bpl* , cl(fips) 	


	* 3.2 Controling for the severity of the crisis
		reg log_longevity l_DRPCPBRE sev_index_c1_st yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE sev_index_c1_stblack_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930 pct_unempl_1930 yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE sev_index_c1_st age urban_c  white hispan_c foreign married black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930 pct_unempl_1930 yob* bpl* , cl(fips) 	

	
	
	
	
********************************************************************************

* 4 - OLS REGRESSIONS FOR ALL MALES WHO DIED YOUNGER THAN 90
	* 4.1 Without Controling for the severity of the crisis
		reg log_longevity l_DRPCPBRE yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930  yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE age urban_c  white hispan_c foreign married black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930  yob* bpl* , cl(fips) 	


	* 4.2 Controling for the severity of the crisis
		reg log_longevity l_DRPCPBRE sev_index_c1_st yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE sev_index_c1_stblack_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930 pct_unempl_1930 yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE sev_index_c1_st age urban_c  white hispan_c foreign married black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930 pct_unempl_1930 yob* bpl* , cl(fips) 	

	





********************************************************************************

* 5 - OLS REGRESSIONS FOR ALL FEMALES WHO DIED YOUNGER THAN 90
	* 5.1 Without Controling for the severity of the crisis
		reg log_longevity l_DRPCPBRE yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930  yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE age urban_c  white hispan_c foreign married black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930  yob* bpl* , cl(fips) 	


	* 5.2 Controling for the severity of the crisis
		reg log_longevity l_DRPCPBRE sev_index_c1_st yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE sev_index_c1_stblack_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930 pct_unempl_1930 yob* bpl* , cl(fips) 	
		reg log_longevity l_DRPCPBRE sev_index_c1_st age urban_c  white hispan_c foreign married black_pct1930 pct_school7_13_1930 pct_rural_farm_1930 pct_ill10_1930 retail_stocks_pc_1930 farms_pc_1930 pct_unempl_1930 yob* bpl* , cl(fips) 	

	


