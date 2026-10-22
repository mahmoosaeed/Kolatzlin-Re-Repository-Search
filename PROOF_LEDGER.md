# Proof ledger

Status policy: a proof body is a candidate until successfully compiled; file/archive integrity is not Lean verification; label a theorem kernel-checked only after a successful lake build and inspection of #print axioms.

| ID | Declaration | Role | Status |
|---|---|---|---|
| D-001 | step | Ordinary Collatz step | Definition |
| D-002 | orbit | Finite orbit | Definition |
| D-003 | stripTwosFuel | Bounded factor-of-two stripping | Definition |
| D-004 | acceleratedOddStep | Accelerated-map candidate | Properties unproved |
| D-005 | ReachesOne | Some orbit iterate equals one | Definition |
| D-006 | DescentPrinciple | Positive-time descent for every n > 1 | Open proposition |
| D-007 | CollatzConjecture | Every positive input reaches one | Open proposition |
| P-001 | orbit_add | Iterate composition | Candidate; not compiled |
| P-002 | step_pos | Positivity after one step | Candidate; not compiled |
| P-003 | orbit_pos | Positivity of finite iterates | Candidate; not compiled |
| P-004 | reachesOne_implies_descent | Collatz implies descent | Candidate; not compiled |
| P-005 | descent_implies_collatz | Descent implies Collatz by induction | Candidate; not compiled |
| P-006 | collatz_iff_descent | Equivalence of open targets | Candidate; not compiled |
| P-007–P-011 | Modular residue lemmas | Arithmetic residue facts | Candidates; not compiled |
| T-001–T-003 | Regression examples | Detect false one-step descent and test even descent | Candidates; not compiled |
| O-001 | AcceleratedPathIdentityTarget | Intended accelerated identity | Open target |
| O-002 | GlobalDescentTarget | Global descent | Open target |

No successful Lean build or #print axioms output is claimed here. The full Collatz conjecture remains open in this project.
