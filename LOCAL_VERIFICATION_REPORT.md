# Verification Status Report — CollatzLeanResearch

## Current verified result
GitHub Actions run [39777970211](https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39777970211) succeeded for source revision `b12223b47822c49b4653b1361eb72745c26c1fac`, using Lean 4.19.0 and Mathlib revision `c44e0c8ee63ca166450922a373c7409c5d26b00b`.

- `lake build CollatzLean`: **PASSED**
- `lake env lean AxiomAudit.lean`: **PASSED**
- `lake env lean CollatzLean/Tests.lean`: **PASSED**
- Artifact: [lean-verification-logs](https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39777970211/artifacts/12425142488)
- Artifact SHA-256: `0c8ab2d7755c9783d876d1c1431c8a901fbfe072caf250fe8d3ab87eb76da708`

## New kernel-checked results

### Bounded factor-of-two stripping
`stripTwosFuel_correct` proves that for positive `n ≤ fuel`, there exists an exponent `a` such that
`n = 2^a * stripTwosFuel fuel n`, and the returned factor is odd.

### Accelerated odd step
- `acceleratedOddStep_correct`: `3*n+1` factors as a power of two times the accelerated output, which is odd.
- `acceleratedOddStep_pos`: the accelerated output is positive for positive input.
- `stripTwosFuel_reachable`: the bounded stripping result occurs at some ordinary Collatz orbit index.
- `acceleratedOddStep_reachable`: for positive odd `n`, the accelerated output occurs at a positive-time ordinary orbit index.
- `acceleratedOddStep_lt_implies_descent`: if the accelerated output is strictly below an odd input, then that input has a strict ordinary-orbit descent.

### Global descent reduction
- `even_input_descends`: every even `n > 1` descends in one ordinary step.
- `descent_iff_odd_descent`: global strict descent is equivalent to strict descent for odd inputs greater than one.

The regression file includes concrete accelerated outputs for inputs 1, 3, 5, and 7, and type-checks the general correctness and reachability statements.

## Axiom audit
The new audit reports:
- `stripTwosFuel_correct`, `acceleratedOddStep_correct`, and `acceleratedOddStep_pos`: `[propext, Classical.choice, Quot.sound]`.
- `stripTwosFuel_reachable`, `acceleratedOddStep_reachable`, `acceleratedOddStep_lt_implies_descent`, `even_input_descends`, and `descent_iff_odd_descent`: `[propext, Quot.sound]`.

The remaining audited declarations report the standard dependencies already recorded in `VERIFICATION_MANIFEST.json`. No audited declaration reports `sorryAx` or a user-declared custom axiom. `Classical.choice` appears in the existential factorization results; the reachability and descent reductions do not require it in their reported dependencies.

## What remains open
- The Collatz conjecture remains **OPEN / NOT PROVED**.
- The odd-input descent obligation remains open: one must show that every odd `n > 1` has some positive-time iterate below `n`.
- The theorem `acceleratedOddStep_lt_implies_descent` is conditional. It does not prove `acceleratedOddStep n < n` for every odd `n > 1`.
- The proposed accelerated-path identity remains a target, not a theorem.
- The audit covers the explicit declarations in `AxiomAudit.lean`; it does not imply that open targets have been solved.

The successful run verifies the code revision identified above. Any subsequent source changes must be rechecked by CI.
