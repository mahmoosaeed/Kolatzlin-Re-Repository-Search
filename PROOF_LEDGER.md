# Proof ledger

Status policy: the status “kernel-checked” requires a successful build and recorded axiom audit for the exact source revision. The full Collatz conjecture remains open.

| ID | Declaration | Role | Status |
|---|---|---|---|
| D-001 | step | Ordinary Collatz step | Definition |
| D-002 | orbit | Finite orbit | Definition |
| D-003 | stripTwosFuel | Bounded factor-of-two stripping | Definition |
| D-004 | acceleratedOddStep | Accelerated-map candidate | Properties unproved |
| D-005 | ReachesOne | Some orbit iterate equals one | Definition |
| D-006 | DescentPrinciple | Positive-time descent for every n > 1 | Open proposition |
| D-007 | CollatzConjecture | Every positive input reaches one | Open proposition |
| P-001 | orbit_add | Iterate composition | Kernel-checked in CI commit 7b40f198 |
| P-002 | step_pos | Positivity after one step | Kernel-checked in CI commit 7b40f198 |
| P-003 | orbit_pos | Positivity of finite iterates | Kernel-checked in CI commit 7b40f198 |
| P-004 | reachesOne_implies_descent | Collatz implies descent | Kernel-checked conditional theorem in CI commit 7b40f198 |
| P-005 | descent_implies_collatz | Descent implies Collatz by induction | Kernel-checked conditional theorem in CI commit 7b40f198 |
| P-006 | collatz_iff_descent | Equivalence of open targets | Kernel-checked equivalence; neither side is thereby proved |
| P-007–P-011 | Modular residue lemmas | Arithmetic residue facts | Kernel-checked in CI commit 7b40f198 |
| T-001–T-003 | Regression examples | Detect false one-step descent and test even descent | Lean-checked in CI commit 7b40f198 |
| O-001 | AcceleratedPathIdentityTarget | Intended accelerated identity | Open target |
| O-002 | GlobalDescentTarget | Global descent | Open target |

## Exact verification record
- Toolchain: Lean 4.19.0; Lake 5.0.0-6caaee8.
- Mathlib revision: c44e0c8ee63ca166450922a373c7409c5d26b00b.
- Successful CI run: https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39774737649
- Axiom-audit dependencies are listed in VERIFICATION_MANIFEST.json and the CI artifact.
- No listed declaration depends on sorryAx or a user-declared custom axiom; observed dependencies are propext, Quot.sound, and Classical.choice for two declarations.

The full Collatz conjecture is NOT PROVED. The equivalence theorem only shows that the conjecture and the global strict-descent principle imply each other.
