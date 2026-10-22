# Collatz Lean Research Case Study

This is an auditable Lean 4 + Mathlib research scaffold, not a proof of the Collatz conjecture.

## Contents
- Ordinary Collatz step and finite orbit.
- A bounded-fuel accelerated odd-step candidate.
- Propositions for eventual arrival at one and global strict descent.
- A kernel-checked equivalence theorem between the Collatz conjecture and the global strict-descent principle.
- Modular residue lemmas for 3*n+1 = 2^a*u.
- Regression examples that refute the false claim that every individual step decreases.
- Proof ledger and open-goal register.

## Verified revision
GitHub Actions run [39774737649](https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39774737649) succeeded for commit `7b40f198f9173e98d592f6f54ed7376301f86f09` using Lean 4.19.0 and Mathlib revision `c44e0c8ee63ca166450922a373c7409c5d26b00b`.

The run passed:
- `lake build CollatzLean`
- `lake env lean AxiomAudit.lean`
- `lake env lean CollatzLean/Tests.lean`

Download the [`lean-verification-logs` artifact](https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39774737649/artifacts/12423393467) to inspect the full build, test, dependency, and axiom-audit logs. The audit reports only Lean's standard dependencies `propext`, `Quot.sound`, and, for two declarations, `Classical.choice`.

## Verification boundary
The successful build verifies the exact source revision above. It does **not** prove the full Collatz conjecture. `CollatzConjecture`, `DescentPrinciple`, and the accelerated-path identity remain open targets. The theorem `collatz_iff_descent` establishes equivalence of two statements, not the truth of either one.

Do not use finite checks as proof of a universal statement, and do not introduce `sorry`, `admit`, or custom axioms to bypass proof obligations. Re-run CI after source changes.
