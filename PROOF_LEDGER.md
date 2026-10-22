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
| T-001–T-003 | Original regression examples | Falsify universal one-step descent; test even descent | Lean-checked |
| T-004 | Accelerated examples 1, 3, 5, 7 | Concrete outputs | Lean-checked |
| T-005 | General factorization/reachability contracts | Type-check theorem contracts | Lean-checked |
| O-001 | AcceleratedPathIdentityTarget | Intended accelerated identity | Open target |
| O-002 | GlobalDescentTarget | Global descent | Open target |

## Exact CI record
- Source revision: `b12223b47822c49b4653b1361eb72745c26c1fac`
- Lean: 4.19.0
- Mathlib revision: `c44e0c8ee63ca166450922a373c7409c5d26b00b`
- Successful run: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39777970211
- Axiom audit and logs: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39777970211/artifacts/12425142488

The Collatz conjecture is **NOT PROVED**. Proving descent for every odd input remains the central open obligation.
