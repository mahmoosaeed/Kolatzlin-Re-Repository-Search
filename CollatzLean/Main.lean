import Mathlib

namespace CollatzLean

/-- Ordinary Collatz step: halve even inputs, apply 3*n+1 to odd inputs. -/
def step (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else 3 * n + 1

/-- Value after exactly k ordinary Collatz steps. -/
def orbit (n : Nat) : Nat → Nat
  | 0 => n
  | k + 1 => step (orbit n k)

@[simp] theorem orbit_zero (n : Nat) : orbit n 0 = n := rfl
@[simp] theorem orbit_succ (n k : Nat) :
    orbit n (k + 1) = step (orbit n k) := rfl

/-- Strip factors of two, with an explicit fuel bound. -/
def stripTwosFuel : Nat → Nat → Nat
  | 0, n => n
  | fuel + 1, n =>
      if n % 2 = 0 then stripTwosFuel fuel (n / 2) else n

/--
Total accelerated odd-step function. On odd positive inputs, it computes
3*n+1 and strips successive factors of two. The first argument to
stripTwosFuel is chosen as a conservative fuel bound.
-/
def acceleratedOddStep (n : Nat) : Nat :=
  stripTwosFuel (3 * n + 1) (3 * n + 1)

/-- Some finite ordinary iterate equals one. -/
def ReachesOne (n : Nat) : Prop := ∃ k, orbit n k = 1

/-- Every n > 1 has a positive-time iterate strictly below n. -/
def DescentPrinciple : Prop :=
  ∀ n, 1 < n → ∃ k, 0 < k ∧ orbit n k < n

/-- The Collatz conjecture, stated as an open proposition. -/
def CollatzConjecture : Prop :=
  ∀ n, 0 < n → ReachesOne n

/-- Composition law for finite iterates. -/
theorem orbit_add (n k j : Nat) :
    orbit (orbit n k) j = orbit n (k + j) := by
  induction j with
  | zero => simp [orbit]
  | succ j ih => simp [orbit, ih, Nat.add_succ]

/-- One ordinary Collatz step preserves positivity. -/
theorem step_pos {n : Nat} (hn : 0 < n) : 0 < step n := by
  unfold step
  split <;> omega

/-- Every finite iterate of a positive input is positive. -/
theorem orbit_pos {n k : Nat} (hn : 0 < n) : 0 < orbit n k := by
  induction k with
  | zero => simpa [orbit] using hn
  | succ k ih =>
      rw [orbit_succ]
      exact step_pos ih

/-- If Collatz holds, every n > 1 has a strict descent. -/
theorem reachesOne_implies_descent :
    CollatzConjecture → DescentPrinciple := by
  intro hCollatz n hn
  obtain ⟨k, hk⟩ := hCollatz n (by omega)
  have hkpos : 0 < k := by
    by_contra h
    have hk0 : k = 0 := by omega
    subst k
    simp [orbit] at hk
    omega
  exact ⟨k, hkpos, by rw [hk]; omega⟩

/-- Global strict descent implies Collatz by strong induction. -/
theorem descent_implies_collatz :
    DescentPrinciple → CollatzConjecture := by
  intro hDesc n hnpos
  revert hnpos
  induction n using Nat.strong_induction_on with
  | h n ih =>
      intro hnpos
      by_cases hn1 : n = 1
      · subst n
        exact ⟨0, by simp [orbit]⟩
      · have hn1' : 1 < n := by omega
        obtain ⟨k, hkpos, hsmall⟩ := hDesc n hn1'
        have hmpos : 0 < orbit n k := orbit_pos hnpos
        obtain ⟨j, hj⟩ := ih (orbit n k) hsmall hmpos
        refine ⟨k + j, ?_⟩
        rw [← orbit_add n k j, hj]

/-- Collatz is equivalent to the global strict-descent principle. -/
theorem collatz_iff_descent : CollatzConjecture ↔ DescentPrinciple :=
  ⟨reachesOne_implies_descent, descent_implies_collatz⟩

/-- Odd u with u = 1 (mod 3) must be 1 (mod 6). -/
theorem mod_six_eq_one_of_mod_two_one_mod_three_one
    (u : Nat) (h2 : u % 2 = 1) (h3 : u % 3 = 1) :
    u % 6 = 1 := by omega

/-- Odd u with u = 2 (mod 3) must be 5 (mod 6). -/
theorem mod_six_eq_five_of_mod_two_one_mod_three_two
    (u : Nat) (h2 : u % 2 = 1) (h3 : u % 3 = 2) :
    u % 6 = 5 := by omega

/-- 2^a modulo 3 is determined by the parity of a. -/
theorem pow_two_mod_three (a : Nat) :
    2 ^ a % 3 = (if a % 2 = 0 then 1 else 2) := by
  induction a with
  | zero => norm_num
  | succ a ih =>
      rw [pow_succ, Nat.mul_mod]
      by_cases h : a % 2 = 0
      · have h' : (a + 1) % 2 = 1 := by omega
        simp [ih, h, h']
      · have h' : (a + 1) % 2 = 0 := by omega
        simp [ih, h, h']

/-- Factorization 3*n+1 = 2^a*u fixes u modulo 3. -/
theorem quotient_mod_three_from_equation
    (n a u : Nat)
    (heq : 3 * n + 1 = 2 ^ a * u) :
    u % 3 = (if a % 2 = 0 then 1 else 2) := by
  have hmod : (2 ^ a * u) % 3 = 1 := by
    rw [← heq]
    omega
  rw [Nat.mul_mod, pow_two_mod_three] at hmod
  by_cases h : a % 2 = 0
  · simp [h] at hmod ⊢
    omega
  · have h' : a % 2 = 1 := by omega
    simp [h, h'] at hmod ⊢
    omega

/-- If u is odd, the same factorization fixes u modulo 6. -/
theorem quotient_mod_six_from_equation
    (n a u : Nat)
    (heq : 3 * n + 1 = 2 ^ a * u)
    (huOdd : u % 2 = 1) :
    u % 6 = (if a % 2 = 0 then 1 else 5) := by
  have h3 := quotient_mod_three_from_equation n a u heq
  by_cases h : a % 2 = 0
  · have hmod3 : u % 3 = 1 := by simpa [h] using h3
    have hmod6 :
        u % 6 = 1 :=
      mod_six_eq_one_of_mod_two_one_mod_three_one u huOdd hmod3
    simpa [h] using hmod6
  · have hmod3 : u % 3 = 2 := by simpa [h] using h3
    have hmod6 :
        u % 6 = 5 :=
      mod_six_eq_five_of_mod_two_one_mod_three_two u huOdd hmod3
    simpa [h] using hmod6

/--
Open target only: the proposed accelerated-path identity is recorded as a
proposition and is not claimed as a proved theorem.
-/
def AcceleratedPathIdentityTarget
    (n : Nat) (xs exps : Nat → Nat) (r : Nat) : Prop :=
  xs 0 = n →
  (∀ i, i < r → 2 ^ (exps i) * xs (i + 1) = 3 * xs i + 1) →
  (2 ^ (∑ i ∈ Finset.range r, exps i)) * xs r =
    (3 ^ r) * n +
      ∑ i ∈ Finset.range r,
        (3 ^ (r - 1 - i)) *
          (2 ^ (∑ j ∈ Finset.range i, exps j))

/-- Open target: prove global strict descent for all n > 1. -/
def GlobalDescentTarget : Prop := DescentPrinciple

end CollatzLean
