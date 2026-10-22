import Lake
open Lake DSL

package «collatz-lean-research» where
  version := v!"0.1.0"

-- Match the Mathlib release to lean-toolchain (Lean 4.19.0).
require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.19.0"

lean_lib CollatzLean
