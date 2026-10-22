import CollatzLean.Main
import Mathlib

open CollatzLean

/-- Negative test: not every individual step decreases. -/
example : step 3 = 10 := by norm_num [step]
example : ¬ step 3 < 3 := by norm_num [step]

/-- Second negative test for the false universal one-step decrease claim. -/
example : step 7 = 22 := by norm_num [step]
example : ¬ step 7 < 7 := by norm_num [step]

/-- Positive even inputs do decrease in one ordinary step. -/
example (n : Nat) (hn : 0 < n) (heven : n % 2 = 0) :
    step n < n := by
  simp [step, heven]
  omega


/-- The accelerated map removes all factors of two in these sample cases. -/
example : acceleratedOddStep 1 = 1 := by
  norm_num [acceleratedOddStep, stripTwosFuel]
example : acceleratedOddStep 3 = 5 := by
  norm_num [acceleratedOddStep, stripTwosFuel]
example : acceleratedOddStep 5 = 1 := by
  norm_num [acceleratedOddStep, stripTwosFuel]
example : acceleratedOddStep 7 = 11 := by
  norm_num [acceleratedOddStep, stripTwosFuel]

/-- General correctness: 3*n+1 is a power of two times an odd output. -/
example (n : Nat) (hn : 0 < n) :
    ∃ a, 3 * n + 1 = 2 ^ a * acceleratedOddStep n ∧
      acceleratedOddStep n % 2 = 1 :=
  acceleratedOddStep_correct n hn

example (n : Nat) (hn : 0 < n) :
    0 < acceleratedOddStep n :=
  acceleratedOddStep_pos hn

/-- The global descent problem reduces to odd inputs greater than one. -/
example : DescentPrinciple ↔ OddDescentPrinciple :=
  descent_iff_odd_descent


/-- The accelerated result is an iterate of the ordinary map for odd inputs. -/
example (n : Nat) (hn : 0 < n) (hodd : n % 2 = 1) :
    ∃ k, 0 < k ∧ orbit n k = acceleratedOddStep n :=
  acceleratedOddStep_reachable n hn hodd

/-- Fuel-bounded stripping itself agrees with some ordinary orbit iterate. -/
example (fuel n : Nat) (hn : 0 < n) (hbound : n ≤ fuel) :
    ∃ k, k ≤ fuel ∧ orbit n k = stripTwosFuel fuel n :=
  stripTwosFuel_reachable fuel n hn hbound

/-- Residue regression test. -/
example (u : Nat) (h2 : u % 2 = 1) (h3 : u % 3 = 2) :
    u % 6 = 5 :=
  mod_six_eq_five_of_mod_two_one_mod_three_two u h2 h3

#check CollatzConjecture
#check GlobalDescentTarget
