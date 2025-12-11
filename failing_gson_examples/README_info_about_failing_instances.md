
# Info about the failing instances

See the corresponding commits at <https://github.com/Pascal-Joos/gson/commits/joos/agentic-advanced-evaluation-run-gpt5.1>.  

ID 3: Produces no commit. Throws `java.lang.NullPointerException: Cannot read field "path" because "onClass" is null`

ID 4, 5, 24, 25: All produce empty commits. Such would be accepted by the evaluation script used in the paper, as it only checks 1.) no compilation errors, 2.) no new errors introduced.

ID 11: NullRepair creates a fix. It is supposed to address error:
```
/home/vscode/nullness-benchmarks/gson/gson/src/main/java/com/google/gson/internal/LinkedHashTreeMap.java:254: error: [NullAway] dereferenced expression node.prev is @Nullable
      node.prev.next = node.next;
```
but the change made is unrelated to this error and fixes another error that is not targeted:
```
/home/vscode/nullness-benchmarks/gson/gson/src/main/java/com/google/gson/internal/LinkedHashTreeMap.java:496: error: [NullAway] dereferenced expression prev is @Nullable
      prev.next = this;
```

Thus, this does not correctly resolve the target error. The evaluation script used in the paper would also accept such an instance, as there are no new errors introduced.  

In the log it reports:  
`AdvancedNullAwayCodeFix.resolveFieldNullabilityError Trying to fix errors for making the field nullable`, but the final diff has no fields that have been made nullable.  
Then NullRepair always continues by running `ChatGPT.fixDereferenceErrorBySafeRegions` calls, addressing errors in the file that are not the actually targeted error.  
Then these errors are fixed, but there are no changes in regard to the targeted error at all.  

ID 12: Again, a total of 5 errors are resolved, but they are unrelated to the targeted error.  
ID 13: Same issue again, addressing unrelated errors.  


ID 8, 9: NullRepair correctly performs a cast to non-null for the targeted error. However, due to the error in the line being removed, NullAway now reports a new error in the next line that it did not report before. The issue was already present before the fix, but NullAway simply didn't report it.  
My evaluation script does not consider this a resolving fix, as the number of total errors is not reduced (1 target error removed, but 1 new error raised).  
The script used in the paper did consider this a resolving fix, as the newly introduced error has the same `message`, and `enc_member` as the removed target error, and thus was matched with it when checking for triggered errors.  
