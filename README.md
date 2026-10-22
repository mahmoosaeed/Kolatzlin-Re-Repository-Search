# Collatz Lean Research Case Study

An auditable Lean 4 + Mathlib research scaffold for the Collatz problem. It is **not a proof of the Collatz conjecture**.

## Kernel-checked results
The successful GitHub Actions run [39777970211](https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39777970211) verified source revision `b12223b47822c49b4653b1361eb72745c26c1fac` with Lean 4.19.0 and Mathlib revision `c44e0c8ee63ca166450922a373c7409c5d26b00b`.

- `stripTwosFuel_correct`: bounded stripping returns an odd factor and proves the power-of-two factorization.
- `acceleratedOddStep_correct`: the output is the odd factor in `3*n+1 = 2^a * output`.
- `stripTwosFuel_reachable` and `acceleratedOddStep_reachable`: the accelerated output is an actual positive-time ordinary orbit iterate for positive odd inputs.
- `acceleratedOddStep_lt_implies_descent`: a strict drop in the accelerated map is sufficient to establish ordinary-orbit descent.
- `even_input_descends`: even inputs above one descend immediately.
- `descent_iff_odd_descent`: the global descent principle reduces to odd inputs greater than one.

The run passed the library build, axiom audit, and regression tests. See the [full CI log artifact](https://github.com/mahmoosaeed/Kolatzlin-Re-Repository-Search/actions/runs/39777970211/artifacts/12425142488).

## Open research obligations
The remaining central task is proving that every odd `n > 1` has a positive-time iterate below `n`. In particular, the current conditional theorem does **not** prove that `acceleratedOddStep n < n` for every odd input. The accelerated-path identity is also still an open target.

Do not infer a universal theorem from finite tests. No `sorry`, `admit`, or custom axiom is used to bypass the open Collatz obligation.
