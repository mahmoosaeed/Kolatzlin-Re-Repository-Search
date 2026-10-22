# Verification Status Report — CollatzLeanResearch

## Executive status
**Remote Lean verification succeeded** for commit `7b40f198f9173e98d592f6f54ed7376301f86f09` using Lean 4.19.0 and Mathlib revision `c44e0c8ee63ca166450922a373c7409c5d26b00b`. The library build, explicit `#print axioms` audit, and regression tests all completed successfully.

- Successful GitHub Actions run: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39774737649
- Log artifact: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39774737649/artifacts/12423393467
- Artifact name: `lean-verification-logs`
- Artifact SHA-256: `6c56953ba1094d42ce620f3767bb161bbb5c059103a6c4b27377a32e96039458`

## Actual results
- Toolchain: Lean 4.19.0; Lake 5.0.0-6caaee8.
- Dependency resolution: passed; Mathlib revision `c44e0c8ee63ca166450922a373c7409c5d26b00b`, requested tag `v4.19.0`.
- Mathlib cache: passed; 6,641 files downloaded on the successful run.
- `lake build CollatzLean`: **PASSED**.
- `lake env lean AxiomAudit.lean`: **PASSED**.
- `lake env lean CollatzLean/Tests.lean`: **PASSED**.
- Compiler diagnostics repaired from actual logs: removed two redundant `omega` tactics in `pow_two_mod_three` that Lean reported as “no goals to be solved.”
- An earlier workflow attempt failed because `leanprover/lean-action` required a pre-existing `lake-manifest.json`; the workflow was changed to install Elan directly and run `lake update` before the build. A later run exposed the two redundant tactics above; they were corrected before the successful run.

## Axiom audit
Exact reported dependencies from `#print axioms`:
- `CollatzLean.orbit_add`: `[propext]`
- `CollatzLean.step_pos`: `[propext, Quot.sound]`
- `CollatzLean.orbit_pos`: `[propext, Quot.sound]`
- `CollatzLean.reachesOne_implies_descent`: `[propext, Classical.choice, Quot.sound]`
- `CollatzLean.descent_implies_collatz`: `[propext, Quot.sound]`
- `CollatzLean.collatz_iff_descent`: `[propext, Classical.choice, Quot.sound]`
- Both modulo-six lemmas, `pow_two_mod_three`, `quotient_mod_three_from_equation`, and `quotient_mod_six_from_equation`: `[propext, Quot.sound]`

These are Lean's standard logical/equality axioms; this audit output does not show a user-declared axiom or a `sorryAx` dependency for the listed declarations. It is still important to distinguish this audit from proving the open Collatz target.

## Verification boundary
- The named library and the regression file compiled under the pinned toolchain.
- The audit covers only the declarations listed in `AxiomAudit.lean`.
- `CollatzConjecture`, `DescentPrinciple`, and `AcceleratedPathIdentityTarget` remain open targets. `collatz_iff_descent` proves an equivalence between the Collatz conjecture and the global descent principle; it does not prove either side.
- Finite Python checks are bounded computation, not a proof of a universal statement.
- The successful result applies to the exact source revision named above; subsequent edits require a fresh run.
