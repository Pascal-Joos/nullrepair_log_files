# Qualitative Insights Manual Inspection


## Hypotheses

### Why do baselines produce more resolving patches:

#### Baselines aggressively use guard conditions and suppressions that silence errors without addressing the underlying cause. (paper)(green color)
(explicitly throwing null-pointer exceptions, where actual call-sites handle the possibility that it returns null)

Example:
libgdx 103:

Caller expects to find null if channel not yet created and creates it on demand. Throwing, breaks the code. Actually the method should be changed to allow returning @Nullable and then one call site would need an additional missing null check. 

#### Baselines sometimes guess default values for fields, without knowing if they are meaningful. This might lead to silent and hard to debug bugs, when this default is used.(blue color) (FIELD_NO_INIT)

Example: 
conductor 20:
a status = null might encode that there is no status yet.
status = Status.SCHEDULED as initialization is wrong, as it is not scheduled on creation of the Task object.


#### Dirty fixes. Breaking some code semantics that are intended to resolve the warning. NullRepair tries more suffisticated changes but fails. (red color)

Example:
libgdx 390:
JsonWriter writer is inferred as @nonnull field, but has @nullable assignment during cleanup of the Writer (set null to prevent memory leak). Fix removes that which is wrong.

### Wrongly raised METHOD_NO_INIT cases by NullAway. Actually it is initialized on all paths. No idea how we could suppress such cases. (yellow color)

Example:
libgdx 65:
Initialization happens inside a called method (always). NullAway seems to not fully reason about that.

### Why reviewers preferred NullRepair patches:

#### Semantic precision and alignment with the program's intent. Rather than failing at the site of the error, NullRepair often applied coordinated changes across the codebase to safely propagate null-handling logic. Deeper understanding of surrounding logic and more idiomatic and robust. (paper)

Need an example from the manual inspection




### Why reviewers sometimes preferred one of the baselines:

#### Error is genuine nullability issue and baselines produce fail-fast fix to ensure safety (paper)




### Why reviewers scored as tie:

#### All approaches sometimes fail to recognize complex initialization patterns, leading to incomplete or unnecessary changes. (paper)

#### Sometimes all three produce similarly effective local edits with minimal context required. (paper)


