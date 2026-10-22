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


/--
Correctness of bounded factor-of-two stripping. If the positive input is
at most the fuel, the result is odd and the input factors as a power of
two times that result.
-/
theorem stripTwosFuel_correct (fuel n : Nat) (hn : 0 < n)
    (hbound : n ≤ fuel) :
    ∃ a, n = 2 ^ a * stripTwosFuel fuel n ∧
      stripTwosFuel fuel n % 2 = 1 := by
  induction fuel generalizing n with
  | zero => omega
  | succ fuel ih =>
      by_cases heven : n % 2 = 0
      · have hn2 : 0 < n / 2 := by omega
        have hbound2 : n / 2 ≤ fuel := by omega
        obtain ⟨a, ha, hodd⟩ := ih (n / 2) hn2 hbound2
        have hpow : n = 2 ^ (a + 1) * stripTwosFuel fuel (n / 2) := by
          have hdiv : n = 2 * (n / 2) := by omega
          calc
            n = 2 * (n / 2) := hdiv
            _ = 2 * (2 ^ a * stripTwosFuel fuel (n / 2)) :=
              congrArg (fun x => 2 * x) ha
            _ = 2 ^ (a + 1) * stripTwosFuel fuel (n / 2) := by
              rw [pow_succ]
              ring
        refine ⟨a + 1, ?_, ?_⟩
        · simpa [stripTwosFuel, heven] using hpow
        · simpa [stripTwosFuel, heven] using hodd
      · have hodd : n % 2 = 1 := by omega
        refine ⟨0, ?_, ?_⟩
        · simp [stripTwosFuel, heven]
        · simpa [stripTwosFuel, heven] using hodd

/-- The accelerated odd step returns an odd factor of 3*n+1. -/
theorem acceleratedOddStep_correct (n : Nat) (hn : 0 < n) :
    ∃ a, 3 * n + 1 = 2 ^ a * acceleratedOddStep n ∧
      acceleratedOddStep n % 2 = 1 := by
  unfold acceleratedOddStep
  exact stripTwosFuel_correct (3 * n + 1) (3 * n + 1)
    (by omega) (le_rfl)

/-- The accelerated odd-step output is positive on positive inputs. -/
theorem acceleratedOddStep_pos {n : Nat} (hn : 0 < n) :
    0 < acceleratedOddStep n := by
  obtain ⟨a, _, hodd⟩ := acceleratedOddStep_correct n hn
  omega

/-- Some finite ordinary iterate equals one. -/
def ReachesOne (n : Nat) : Prop := ∃ k, orbit n k = 1

/-- Every n > 1 has a positive-time iterate strictly below n. -/
def DescentPrinciple : Prop :=
  ∀ n, 1 < n → ∃ k, 0 < k ∧ orbit n k < n


/-- The unresolved part of global descent, restricted to odd inputs. -/
def OddDescentPrinciple : Prop :=
  ∀ n, 1 < n → n % 2 = 1 → ∃ k, 0 < k ∧ orbit n k < n

/-- The Collatz conjecture, stated as an open proposition. -/
def CollatzConjecture : Prop :=
  ∀ n, 0 < n → ReachesOne n

/-- Composition law for finite iterates. -/
theorem orbit_add (n k j : Nat) :
    orbit (orbit n k) j = orbit n (k + j) := by
  induction j with
  | zero => simp [orbit]
  | succ j ih => simp [orbit, ih, Nat.add_succ]


/--
The bounded stripping routine follows an actual ordinary Collatz orbit.
The fuel bound ensures it stops before exhausting fuel on a positive input.
-/
theorem stripTwosFuel_reachable (fuel n : Nat) (hn : 0 < n)
    (hbound : n ≤ fuel) :
    ∃ k, k ≤ fuel ∧ orbit n k = stripTwosFuel fuel n := by
  induction fuel generalizing n with
  | zero => omega
  | succ fuel ih =>
      by_cases heven : n % 2 = 0
      · have hn2 : 0 < n / 2 := by omega
        have hbound2 : n / 2 ≤ fuel := by omega
        obtain ⟨k, hk, hEq⟩ := ih (n / 2) hn2 hbound2
        refine ⟨k + 1, by omega, ?_⟩
        have hstep : step n = n / 2 := by simp [step, heven]
        have hidx : k + 1 = 1 + k := by omega
        calc
          orbit n (k + 1) = orbit n (1 + k) := by rw [hidx]
          _ = orbit (orbit n 1) k := (orbit_add n 1 k).symm
          _ = orbit (step n) k := by simp [orbit]
          _ = orbit (n / 2) k := by rw [hstep]
          _ = stripTwosFuel fuel (n / 2) := hEq
          _ = stripTwosFuel (fuel + 1) n := by
            simp [stripTwosFuel, heven]
      · refine ⟨0, by omega, ?_⟩
        simp [orbit, stripTwosFuel, heven]

/-- On positive odd inputs, the accelerated output occurs on the ordinary orbit. -/
theorem acceleratedOddStep_reachable (n : Nat) (hn : 0 < n)
    (hodd : n % 2 = 1) :
    ∃ k, 0 < k ∧ orbit n k = acceleratedOddStep n := by
  obtain ⟨j, _, hj⟩ :=
    stripTwosFuel_reachable (3 * n + 1) (3 * n + 1) (by omega) le_rfl
  refine ⟨j + 1, by omega, ?_⟩
  have hstep : step n = 3 * n + 1 := by simp [step, hodd]
  have hidx : j + 1 = 1 + j := by omega
  calc
    orbit n (j + 1) = orbit n (1 + j) := by rw [hidx]
    _ = orbit (orbit n 1) j := (orbit_add n 1 j).symm
    _ = orbit (step n) j := by simp [orbit]
    _ = orbit (3 * n + 1) j := by rw [hstep]
    _ = stripTwosFuel (3 * n + 1) (3 * n + 1) := hj
    _ = acceleratedOddStep n := by rfl


/-- If the accelerated odd-step output is smaller, odd-input descent follows. -/
theorem acceleratedOddStep_lt_implies_descent {n : Nat}
    (hn : 0 < n) (hodd : n % 2 = 1)
    (hsmall : acceleratedOddStep n < n) :
    ∃ k, 0 < k ∧ orbit n k < n := by
  obtain ⟨k, hk, hreach⟩ := acceleratedOddStep_reachable n hn hodd
  exact ⟨k, hk, by rw [hreach]; exact hsmall⟩

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


/-- Every even input greater than one has immediate strict descent. -/
theorem even_input_descends {n : Nat} (hn : 1 < n)
    (heven : n % 2 = 0) :
    ∃ k, 0 < k ∧ orbit n k < n := by
  refine ⟨1, by omega, ?_⟩
  rw [orbit_succ]
  unfold step
  simp [heven]
  omega

/-- Global strict descent is equivalent to descent for odd inputs only. -/
theorem descent_iff_odd_descent :
    DescentPrinciple ↔ OddDescentPrinciple := by
  constructor
  · intro h n hn hodd
    exact h n hn
  · intro h n hn
    by_cases heven : n % 2 = 0
    · exact even_input_descends hn heven
    · have hodd : n % 2 = 1 := by omega
      exact h n hn hodd

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


/--
If an odd input is 1 modulo 4, its accelerated odd-step output is
strictly smaller. The factorization exponent must be at least two.
-/
theorem acceleratedOddStep_lt_of_mod_four_eq_one {n : Nat}
    (hn : 1 < n) (hmod : n % 4 = 1) :
    acceleratedOddStep n < n := by
  have hnodd : n % 2 = 1 := by omega
  obtain ⟨a, heq, huodd⟩ :=
    acceleratedOddStep_correct n (by omega)
  have ha : 2 ≤ a := by
    by_contra h
    have hsmall : a = 0 ∨ a = 1 := by omega
    rcases hsmall with ha0 | ha1
    · subst a
      simp only [pow_zero, one_mul] at heq
      have hEven : (3 * n + 1) % 2 = 0 := by omega
      rw [heq] at hEven
      omega
    · subst a
      simp only [pow_one] at heq
      have hmod4 : (3 * n + 1) % 4 = 0 := by omega
      rw [heq] at hmod4
      omega
  have hpow : 4 ≤ 2 ^ a := by
    have hp := Nat.pow_le_pow_right (by omega : 1 ≤ 2) ha
    norm_num at hp ⊢
    exact hp
  have hmul : 4 * acceleratedOddStep n ≤
      2 ^ a * acceleratedOddStep n :=
    Nat.mul_le_mul_right _ hpow
  rw [← heq] at hmul
  nlinarith


/--
For odd inputs congruent to 3 modulo 4, the accelerated exponent is
exactly one, so the first accelerated output is larger than the input.
This records the obstruction to universal one-block descent.
-/
theorem acceleratedOddStep_gt_of_mod_four_eq_three {n : Nat}
    (hn : 1 < n) (hmod : n % 4 = 3) :
    n < acceleratedOddStep n := by
  obtain ⟨a, heq, huodd⟩ :=
    acceleratedOddStep_correct n (by omega)
  have hleft : (3 * n + 1) % 4 = 2 := by omega
  have ha : a = 1 := by
    by_cases ha0 : a = 0
    · subst a
      simp only [pow_zero, one_mul] at heq
      have hmod2 : (3 * n + 1) % 2 = 0 := by omega
      rw [heq] at hmod2
      omega
    · by_cases ha1 : a = 1
      · exact ha1
      · have ha2 : 2 ≤ a := by omega
        have hp : 2 ^ a % 4 = 0 := by
          rw [show a = 2 + (a - 2) by omega, pow_add]
          simp [Nat.mul_mod]
        have hprod : (2 ^ a * acceleratedOddStep n) % 4 = 0 := by
          rw [Nat.mul_mod, hp]
          simp
        rw [← heq] at hprod
        omega
  have heq' : 3 * n + 1 = 2 * acceleratedOddStep n := by
    simpa [ha] using heq
  omega


/--
The exact accelerated-path identity. The hypotheses encode each odd-to-odd
block as 2^(exps i) * xs (i+1) = 3 * xs i + 1.
-/
theorem acceleratedPathIdentity
    (n : Nat) (xs exps : Nat → Nat) (r : Nat)
    (hstart : xs 0 = n)
    (hstep : ∀ i, i < r →
      2 ^ (exps i) * xs (i + 1) = 3 * xs i + 1) :
    (2 ^ (∑ i ∈ Finset.range r, exps i)) * xs r =
      (3 ^ r) * n +
        ∑ i ∈ Finset.range r,
          (3 ^ (r - 1 - i)) *
            (2 ^ (∑ j ∈ Finset.range i, exps j)) := by
  induction r with
  | zero =>
      simp [hstart]
  | succ r ih =>
      let E := ∑ i ∈ Finset.range r, exps i
      let S := ∑ i ∈ Finset.range r,
        (3 ^ (r - 1 - i)) * (2 ^ (∑ j ∈ Finset.range i, exps j))
      have hr := hstep r (by omega)
      have ih' := ih (fun i hi => hstep i (by omega))
      have hsum :
          3 * S =
            ∑ i ∈ Finset.range r,
              (3 ^ (r - i)) * (2 ^ (∑ j ∈ Finset.range i, exps j)) := by
        dsimp [S]
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro i hi
        have hri : i < r := Finset.mem_range.mp hi
        have hexp : r - i = (r - 1 - i) + 1 := by omega
        rw [hexp, Nat.pow_succ]
        ring
      have hlast :
          (3 ^ (r - r)) *
            (2 ^ (∑ j ∈ Finset.range r, exps j)) = 2 ^ E := by
        simp [E]
      simp only [Finset.sum_range_succ] at ih' ⊢
      dsimp [E, S] at ih' ⊢
      have hsub : r + 1 - 1 = r := by omega
      simp_rw [hsub] at ih' ⊢
      rw [Nat.pow_succ]
      calc
        (2 ^ (∑ i ∈ Finset.range r, exps i) * 2 ^ exps r) * xs (r + 1)
            = 2 ^ (∑ i ∈ Finset.range r, exps i) *
                (2 ^ exps r * xs (r + 1)) := by ring
        _ = 2 ^ (∑ i ∈ Finset.range r, exps i) * (3 * xs r + 1) := by
              rw [hr]
        _ = 3 * (2 ^ (∑ i ∈ Finset.range r, exps i) * xs r) +
              2 ^ (∑ i ∈ Finset.range r, exps i) := by ring
        _ = 3 * ((3 ^ r) * n +
              ∑ i ∈ Finset.range r,
                (3 ^ (r - 1 - i)) *
                  (2 ^ (∑ j ∈ Finset.range i, exps j))) +
              2 ^ (∑ i ∈ Finset.range r, exps i) := by rw [ih']
        _ = 3 ^ (r + 1) * n +
              3 * (∑ i ∈ Finset.range r,
                (3 ^ (r - 1 - i)) *
                  (2 ^ (∑ j ∈ Finset.range i, exps j))) +
              2 ^ (∑ i ∈ Finset.range r, exps i) := by
              rw [Nat.pow_succ]
              ring
        _ = 3 ^ (r + 1) * n +
              (∑ i ∈ Finset.range r,
                (3 ^ (r - i)) *
                  (2 ^ (∑ j ∈ Finset.range i, exps j))) +
              2 ^ (∑ i ∈ Finset.range r, exps i) := by
              rw [hsum]
        _ = 3 ^ (r + 1) * n +
              (∑ i ∈ Finset.range r,
                (3 ^ (r - i)) *
                  (2 ^ (∑ j ∈ Finset.range i, exps j))) +
              (3 ^ (r - r)) *
                (2 ^ (∑ j ∈ Finset.range r, exps j)) := by
              rw [hlast]
        _ = 3 ^ (r + 1) * n +
              ∑ i ∈ Finset.range (r + 1),
                (3 ^ (r - i)) *
                  (2 ^ (∑ j ∈ Finset.range i, exps j)) := by
              simp only [Finset.sum_range_succ, Nat.succ_sub_one]

/--
A quantitative sufficient condition for descent along an accelerated path:
if the accumulated power-of-two factor times the initial value exceeds
the exact right-hand side of the path identity, then the terminal value
is strictly below the initial value. This is conditional, not a universal
Collatz descent theorem.
-/
theorem acceleratedPathIdentity_conditional_descent
    (n : Nat) (xs exps : Nat → Nat) (r : Nat)
    (hstart : xs 0 = n)
    (hstep : ∀ i, i < r →
      2 ^ (exps i) * xs (i + 1) = 3 * xs i + 1)
    (hn : 0 < n)
    (hbound :
      (3 ^ r) * n +
        ∑ i ∈ Finset.range r,
          (3 ^ (r - 1 - i)) *
            (2 ^ (∑ j ∈ Finset.range i, exps j)) <
      (2 ^ (∑ i ∈ Finset.range r, exps i)) * n) :
    xs r < n := by
  have hid := acceleratedPathIdentity n xs exps r hstart hstep
  by_contra hnot
  have hle : n ≤ xs r := by omega
  have hmul := Nat.mul_le_mul_left
    (2 ^ (∑ i ∈ Finset.range r, exps i)) hle
  rw [hid] at hmul
  omega

end CollatzLean
