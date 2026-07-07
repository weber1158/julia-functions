function ik_poisson_ratio(df_col)
#
# Prints the illite/kaolinite ratio and associated Poisson error
# 
# Requires:
#  - Printf
  
  ilt = "Illite"
  kln = "Kaolinite"
  idx1 = df_col .== ilt
  idx2 = df_col .== kln
  cts1 = sum(idx1)
  cts2 = sum(idx2)

  if (cts1 == 0) && (cts == 0)
      ik = NaN
      σ = NaN
      @printf("No illite or kaolinite detected. I/K undefined.\n")
  elseif (cts1 == 0)
      @printf("No illite detected, cannot compute error.\n")
      ik = cts1 / cts2
      σ = NaN
  elseif (cts2 == 0)
      ik = NaN
      σ = NaN
      @printf("No kaolinite detected. I/K undefined.\n")
  else
      ik = cts1 / cts2
      σ = ik * sqrt((1/cts1) + (1/cts2))
      @printf("I/K = %0.3f ± %0.3f\n", ik, σ)
  end
  return (ik, σ)
end
