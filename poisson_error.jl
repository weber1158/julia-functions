function poisson_error(df_col, match)
	#
  # Prints the rel. abundance (%) of each match along with its Poisson counting error
  #
  # Required dependencies: 
  #  - Printf
  #
  # Example
  #  data = ["Quartz", "Quartz", "Feldspar", "Quartz", "Clay"]
  #  poisson_error(data, "Feldspar")
  #
	total_cts = length(df_col)
	idx = df_col .== match # or idx = isequal.(df_col, match)
	cts = sum(idx)
	cts_pct = cts / total_cts * 100
	E = sqrt(cts) / total_cts * 100
	@printf("%s = %0.3f ± %0.3f%%\n", match, cts_pct, E)
end
