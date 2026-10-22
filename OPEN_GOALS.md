# Open goals

## OG-1 — Full Collatz conjecture
Target: CollatzLean.CollatzConjecture. Equivalent descent formulation: CollatzLean.DescentPrinciple. Neither target is proved. Finite computations cannot establish the universal claim.

## OG-2 — Accelerated-map correctness
The bounded-fuel acceleratedOddStep definition is intended to strip powers of two from 3*n+1. Prove fuel sufficiency, oddness of output, the corresponding factorization, and agreement with the canonical accelerated map on odd positive inputs. Until then it is not a verified implementation of that map.

## OG-3 — Accelerated-path identity
AcceleratedPathIdentityTarget states the intended identity under the transition equations. It remains a target proposition, not a theorem.

## OG-4 — Build and axiom audit
Run lake update and lake build under the pinned toolchain. Record Mathlib revision and exact output. Run #print axioms on central theorems.

## OG-5 — Automated falsification
Expand tests for parity errors, false universal one-step decrease claims, modulo claims, edge cases 0 and 1, even/odd inputs, accelerated-map outputs, and short path identities. Finite tests can refute claims but cannot prove the universal conjecture.

## Closure criterion
Do not report Collatz solved unless the universal target is proved without sorry, admit, or a custom axiom equivalent to the conjecture, and the complete source is reproducibly checked by Lean's kernel.
