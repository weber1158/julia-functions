function ikq_plot(df;
  mineral_names = ("Illite", "Kaolinite", "Quartz"),
  xguide = mineral_names[1],
  yguide = mineral_names[2],
  zguide = mineral_names[3],
  marker = (1, 8),
  color_by_sample = false,
  legend = color_by_sample ? :outertopright : false,
  color = :black,
  title = "",
  kwargs...
)
#
# Creates an illite-kaolinite-quartz ternary diagram
#
# Required dependencies: DataFrames.jl, Plots.jl, TernaryPlots.jl
#
# Inputs
#  df :: A DataFrame that includes columns: "Sample" and "Mineral"
# 
  samples=unique(df.Sample)
  function count_ikq(df_col)
    i_idx = df_col .== "Illite"
    k_idx = df_col .== "Kaolinite"
    q_idx = df_col .== "Quartz"
    i_cts = sum(i_idx)
    k_cts = sum(k_idx)
    q_cts = sum(q_idx)
    ikq = [i_cts k_cts q_cts]
    return ikq
  end
  a = zeros(length(samples),2) # two columns for tern2cart function
  for (idx, s) in enumerate(samples)
    s_idx = isequal.(df.Sample, s)
    sample = df[s_idx, :]
    ikq = count_ikq(sample.Mineral)
    a[idx, :] = collect(tern2cart(ikq[1, :]))'
  end
  
  ternary_axes(
    xguide="Illite",
    yguide="Kaolinite",
    zguide="Quartz"
  );
  if color_by_sample
      scatter!(a[:,1], a[:,2];
          group = samples,
          legend = legend,
          m = marker,
          kwargs...
      )
  else
      scatter!(a[:,1], a[:,2];
          legend = legend,
          m = marker,
          color = color,
          kwargs...
      )
  end
end
