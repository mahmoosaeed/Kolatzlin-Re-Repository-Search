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
| O-001 | AcceleratedPathIdentityTarget | Intended accelerated identity | Open target; not yet proved as a Lean theorem |
| O-002 | GlobalDescentTarget | Global descent | Open target |
| O-003 | Uniform/finite-step descent from residue constraints and path identity | Requires a new bound on accumulated exponents or a different invariant | Open; residue congruences alone currently yield no finite-step descent theorem |

## Exact CI record
- Current verified source revision: `c75194812b47a81eefff61f91b7909a6bb9253a0`
- Lean: 4.19.0
- Mathlib revision: `c44e0c8ee63ca166450922a373c7409c5d26b00b`
- Mod-four theorem build: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39782928541
- Mod-four regression tests: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39782950733
- Final build, regression tests, and explicit axiom audit: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39782957966
- The Collatz conjecture remains **NOT PROVED**.

The Collatz conjecture is **NOT PROVED**. Proving descent for every odd input remains the central open obligation.
