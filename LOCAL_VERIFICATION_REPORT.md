# Verification Status Report — CollatzLeanResearch

## Executive status
The repository has now been prepared for remote Lean verification. The project is pinned to Lean 4.19.0 and Mathlib v4.19.0. GitHub Actions is configured to run the build, axiom audit, and regression tests and upload logs as an artifact. Until a run completes, compilation and kernel verification remain unconfirmed.

## Verification classification
- Local matching Lean build: NOT RUN (Lean/Lake/Elan unavailable in the earlier runtime).
- GitHub Actions workflow: committed in this repository; trigger status must be checked in Actions.
- Compiler errors: not yet assessed until CI logs are inspected.
- Axiom audit: no output claimed until the workflow's axiom-audit.log is retrieved.
- Collatz conjecture: OPEN / NOT PROVED.
- Finite Python checks: bounded computations only; not a proof of the universal statement.

## Next steps
Open Actions, select Lean verification, inspect the run, and download the lean-verification-logs artifact. Review lake-build.log and axiom-audit.log. Fix any errors based on actual diagnostics and rerun. Do not claim a theorem is kernel-checked unless the exact source revision builds and its axiom output is inspected.
