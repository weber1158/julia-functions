function poisson_error(df_col, match; alpha=0.05)
  #
  # Prints the rel. abundance (%) of each match along with its Poisson counting error
  # Note: Poisson error (σ) is reported as the ratio of the square root of the number
  #       of matches (n) to the total number of counts (N) (i.e., σ = √n/N), UNLESS
  #       the number of matches is zero. In such a case, σ is evaluated as the upper
  #       bound of the Garwood confidence interval: Χ^2_{2, 1-α/2}/2 [Porter, 2025].
  #
  # Reference: Porter, F. C. (2025). https://www.alphaxiv.org/abs/2509.02852v1
  # 
  # Required dependencies: 
  #  - Distributions
  #  - Printf
  #
  # Example 1
  #  data = ["Quartz", "Quartz", "Feldspar", "Quartz", "Clay"]
  #  poisson_error(data, "Quartz")
  # 
  # Example 2
  #  poisson_error(data, "Amphibole", alpha=0.10) # 90% confidence interval 
  #
	total_cts = length(df_col)
	idx = df_col .== match # or idx = isequal.(df_col, match)
	cts = sum(idx)
	cts_pct = cts / total_cts * 100

	if cts == 0
		upper = quantile(Chisq(2), 1 - alpha/2) / 2
    upper_pct = upper / total_cts * 100
    @printf("%s = %g%% (0 counts; %g%% upper limit ≈ %0.3f%%)\n",
            match, cts_pct, 100*(1-alpha), upper_pct)
		return (cts_pct, (0.0, upper_pct))
	else
		σ = sqrt(cts) / total_cts * 100
    @printf("%s = %0.3f ± %0.3f%%\n", match, cts_pct, σ)
    return (cts_pct, σ)
	end
end
