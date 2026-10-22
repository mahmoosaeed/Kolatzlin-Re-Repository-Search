# Collatz Lean Research Case Study

This is an auditable Lean 4 + Mathlib research scaffold, not a proof of the Collatz conjecture.

## Contents
- Ordinary Collatz step and finite orbit.
- A bounded-fuel accelerated odd-step candidate.
- Propositions for eventual arrival at one and global strict descent.
- Candidate proof of equivalence between Collatz and global strict descent.
- Modular residue lemmas for 3*n+1 = 2^a*u.
- Negative tests for the false claim that every individual step decreases.
- Proof ledger and open-goal register.

## Verification boundary
The project is pinned to Lean 4.19.0 and Mathlib v4.19.0. GitHub Actions is configured to run lake build, AxiomAudit.lean, and regression tests, preserving logs as the lean-verification-logs artifact. Compilation is not claimed until the workflow actually completes and its logs are inspected.

## Build
Run lake update and lake build under the pinned toolchain. Inspect the axiom-audit.log artifact for exact #print axioms output. Do not use finite checks as proof of a universal statement and do not introduce sorry, admit, or custom axioms to bypass proof obligations.

The Collatz conjecture remains OPEN / NOT PROVED.
