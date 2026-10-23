# Proof ledger

Status policy: “kernel-checked” means the declaration was compiled in the stated source revision by Lean under CI. Open targets remain open regardless of related conditional theorems.

| ID | Declaration | Role | Status |
|---|---|---|---|
| D-001 | step | Ordinary Collatz step | Definition |
| D-002 | orbit | Finite orbit | Definition |
| D-003 | stripTwosFuel | Bounded factor-of-two stripping | Definition |
| D-004 | acceleratedOddStep | Accelerated-map candidate | Definition; correctness proved below |
| D-005 | ReachesOne | Some orbit iterate equals one | Definition |
| D-006 | DescentPrinciple | Positive-time descent for every n > 1 | Open proposition |
| D-007 | CollatzConjecture | Every positive input reaches one | Open proposition |
| D-008 | OddDescentPrinciple | Strict descent for odd n > 1 | Open proposition |
| P-001 | orbit_add | Iterate composition | Kernel-checked |
| P-002 | step_pos | Positivity after one step | Kernel-checked |
| P-003 | orbit_pos | Positivity of finite iterates | Kernel-checked |
| P-004 | reachesOne_implies_descent | Collatz implies descent | Kernel-checked conditional theorem |
| P-005 | descent_implies_collatz | Descent implies Collatz by induction | Kernel-checked conditional theorem |
| P-006 | collatz_iff_descent | Equivalence of open targets | Kernel-checked equivalence, not a proof of either side |
| P-007–P-011 | Modular residue lemmas | Arithmetic residue facts | Kernel-checked |
| P-012 | stripTwosFuel_correct | Fuel-bounded factorization and oddness | Kernel-checked |
| P-013 | acceleratedOddStep_correct | Factorization of 3*n+1 | Kernel-checked |
| P-014 | acceleratedOddStep_pos | Positivity of accelerated output | Kernel-checked |
| P-015 | stripTwosFuel_reachable | Bounded strip output occurs on ordinary orbit | Kernel-checked |
| P-016 | acceleratedOddStep_reachable | Accelerated odd output occurs at positive orbit time | Kernel-checked |
| P-017 | acceleratedOddStep_lt_implies_descent | Conditional accelerated-to-ordinary descent | Kernel-checked conditional theorem |
| P-018 | even_input_descends | One-step descent for even n > 1 | Kernel-checked |
| P-019 | descent_iff_odd_descent | Reduces global descent to odd inputs | Kernel-checked |
| P-020 | acceleratedOddStep_lt_of_mod_four_eq_one | If n > 1 and n ≡ 1 (mod 4), accelerated output is strictly smaller | Kernel-checked; CI run 28 |
| P-021 | acceleratedOddStep_gt_of_mod_four_eq_three | If n > 1 and n ≡ 3 (mod 4), accelerated output is strictly larger | Kernel-checked; CI run 29 |
| P-022 | mod-four tests | General theorem contracts and examples n=3,7 | Kernel-checked; CI run 30 |
| P-023 | Axiom audit for mod-four descent/obstruction | Explicit audit declaration | Kernel-checked; CI run 31 |
| T-001–T-003 | Original regression examples | Falsify universal one-step descent; test even descent | Lean-checked |
| T-004 | Accelerated examples 1, 3, 5, 7 | Concrete outputs | Lean-checked |
| T-005 | General factorization/reachability contracts | Type-check theorem contracts | Lean-checked |
| P-024 | acceleratedPathIdentity | Exact identity for every finite accelerated path satisfying the block equations | Kernel-checked; CI run 55 |
| P-025 | acceleratedPathIdentity_conditional_descent | The accumulated-exponent inequality is a sufficient condition for terminal descent | Kernel-checked; CI run 55 |
| T-006 | Path identity and conditional-descent interface regressions | Theorem contracts type-check under Lean | Passed; CI run 55 |
| P-026 | Axiom audit for acceleratedPathIdentity and acceleratedPathIdentity_conditional_descent | Dependencies are `propext`, `Classical.choice`, `Quot.sound`; no `sorryAx` or user-declared custom axiom reported | Passed; CI run 55 |
| O-002 | GlobalDescentTarget | Prove strict descent for every odd input greater than 1 | Open target |
| O-003 | Uniform/finite-step descent from residue constraints and path identity | Need a universal quantitative bound on accumulated exponents or a different decreasing invariant | Open; current results do not establish universal finite-step descent |
| P-027 | acceleratedPath_coarse_exponent_bound | If every preterminal path state is at least 3, then `3^r * 2^{A_r} * x_r ≤ 10^r * n`, where `A_r = Σ_{i<r} a_i` | Kernel-checked; CI run 65 |
| P-028 | acceleratedPath_coarse_bound_implies_descent | Under the same path-state condition, `10^r < 3^r * 2^{A_r}` implies `x_r < n`, assuming `n > 0` | Kernel-checked conditional theorem; CI run 65 |
| T-007 | Coarse exponent threshold interface | Regression test for the conditional descent theorem | Passed; CI run 65 |
| P-029 | Axiom audit for coarse exponent results | Theorems depend on `propext`, `Classical.choice`, `Quot.sound`; no `sorryAx` or user-declared custom axiom reported | Passed; CI run 65 |
| O-004 | Universal accumulated-exponent growth or alternative Lyapunov function | Prove that every path avoiding earlier descent eventually satisfies the quantitative threshold, or construct a different well-founded decreasing potential. Current coarse bound is conditional and does not prove that threshold occurs universally. | Open |

| P-030 | acceleratedPath_exponent_sum_ge_length | For an odd-to-odd accelerated path, every local exponent is at least 1, so the accumulated exponent is at least the number of steps | Kernel-checked; CI run 70 |
| P-031 | acceleratedPath_exponent_ge_one_add_mod_four_count | Sharper bound: accumulated exponent is at least path length plus the number of preterminal states congruent to 1 modulo 4 | Kernel-checked; CI run 73 |
| T-008 | Accumulated exponent lower-bound regression contracts | Type-checks both the length bound and the mod-four-count bound | Passed; CI run 73 |
| P-032 | Axiom audit for mod-four exponent bound | Dependencies: propext, Classical.choice, Quot.sound; no sorryAx or user-declared custom axiom reported | Passed; CI run 73 |

| P-033 | acceleratedPath_mod_four_count_implies_descent | If the mod-four residue count satisfies the explicit threshold, the coarse path bound proves terminal descent | Kernel-checked conditional theorem; CI run 77 |
| T-009 | Mod-four residue-count descent contract | Regression test for the residue-count threshold theorem | Passed; CI run 77 |
| P-034 | Axiom audit for mod-four residue-count descent | Dependencies: propext, Classical.choice, Quot.sound; no sorryAx or user-declared custom axiom reported | Passed; CI run 77 |

## Exact CI record
- Verified source commit (the exact tree used by the successful run): `e502e8653204e5024e3fdfc44b2d161463a3e7ae`
- Successful CI run 55: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/40007690102
- Verification artifact: [lean-verification-logs](https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/40007690102/artifacts/12524214136)
- Artifact digest: `sha256:0dc54ad3d2f6870f98973bc416564db2d2a8f7673845f425143ea653ed890ca3`
- Latest expanded verification source commit: `f645dc1da241f1b9502e686e202672373fa6dff2` (the exact source revision verified by CI run 65).
- Successful CI run 65: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/40010019433
- Verification artifact: [lean-verification-logs](https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/40010019433/artifacts/12526430669)
- Artifact digest: `sha256:3752692d447bb0c848ec3baecff9a0c13f5de7c4cd4bf8abba565157454b9bc0`
- Run 65 checks: `lake build CollatzLean` **PASSED**; explicit axiom report **PASSED**; regression tests **PASSED**. The four accelerated-path and coarse-bound declarations listed above appear in the audit output with dependencies `[propext, Classical.choice, Quot.sound]`; the audit log contains no `sorryAx`.
- Checks: `lake build CollatzLean` **PASSED**; explicit axiom audit **PASSED**; regression tests **PASSED**.
- Lean: 4.19.0; Mathlib revision: `c44e0c8ee63ca166450922a373c7409c5d26b00b`.
- The Collatz conjecture remains **NOT PROVED**. The path identity is proved, but the inequality needed for universal descent is not.

The Collatz conjecture is **NOT PROVED**. The exact path identity is now formalized; proving a universal descent guarantee remains the central open obligation.

- Latest verified source revision (exact tree used by successful run 73): 24a1d8f8079b0794199e5ca60fb3fb4c6e33fbaf.
- Successful CI run 73: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/40014458427
- Verification artifact: [lean-verification-logs](https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/40014458427/artifacts/12527373031)
- Artifact SHA-256: 34290b8c5bfdbe2ab1805fd124ae5b1ba202ca015e1c7ec0bdd7afc7625a610e.
- Run 73: lake build CollatzLean passed; explicit axiom audit passed; regression tests passed. The mod-four exponent-count theorem depends on propext, Classical.choice, and Quot.sound; no sorryAx appeared in the audit log.

- Latest verified source revision (exact tree used by successful run 77): 8877eba7722b8b87d8977096ee4fefde6103277f.
- Successful CI run 77: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/40014832239
- Verification artifact: [lean-verification-logs](https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/40014832239/artifacts/12527304079)
- Artifact SHA-256: 4473f56aa81f5f6de0037461064ada85903f647921bde2e7c96217c87e463cb1.
- Run 77 checks: lake build CollatzLean passed; explicit axiom audit passed; regression tests passed. The mod-four residue-count descent theorem depends on propext, Classical.choice, and Quot.sound; no sorryAx appeared in the audit log.
