# Qualitative Insights Manual Inspection


## Hypotheses

### Why do baselines produce more resolving patches:

#### Baselines aggressively use guard conditions and suppressions that silence errors without addressing the underlying cause. (paper)
(explicitly throwing null-pointer exceptions, where actual call-sites handle the possibility that it returns null)

Need an example from the samples where NullRepair fails for this.





### Why reviewers preferred NullRepair patches:

#### Semantic precision and alignment with the program's intent. Rather than failing at the site of the error, NullRepair often applied coordinated changes across the codebase to safely propagate null-handling logic. Deeper understanding of surrounding logic and more idiomatic and robust. (paper)

Need an example from the manual inspection




### Why reviewers sometimes preferred one of the baselines:

#### Error is genuine nullability issue and baselines produce fail-fast fix to ensure safety (paper)




### Why reviewers scored as tie:

#### All approaches sometimes fail to recognize complex initialization patterns, leading to incomplete or unnecessary changes. (paper)

#### Sometimes all three produce similarly effective local edits with minimal context required. (paper)


