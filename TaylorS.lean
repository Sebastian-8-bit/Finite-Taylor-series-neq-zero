import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Group.Finset




def S (n : ℕ) (x : ℚ) : ℚ := ∑ i in Finset.range (n + 1), x^i / Nat.factorial i

theorem S_n_neq_zero : ∀ (n : Nat) (x : ℚ) , S n x ≠ 0 := by
      intro n y
      -- We work with as as irreducible fractions.
      let a := y.num -- Numerator of y
      let b := y.den -- Denominator of y
      by_contra h

       -- Step through the equivalences to reach a contradiction
      have h2 : S n y = 0 ↔ (S (n - 1) (a / b) * b^(n-1) * Nat.factorial n = (a / b)^n) := sorry

      -- Rewrite `h` using `h2`
      rw [h2] at h -- rw [] at is the correct syntax. It took me hours to find out.

      let lhs := S (n - 1) (↑a / ↑b) * ↑b^(n - 1) * ↑(Nat.factorial n)
      let rhs := (↑a / (↑b : ℚ))^n
      have h_eq : lhs = rhs := h

      have h_contra : False := by
        -- Show lhs is an integer
        have lhs_integer : ∃ (z : ℤ), lhs = z :=by
          -- Since lhs is a sum of rational terms multiplied by integer factors,
          -- it is a sum of integers.
          sorry

        -- Show rhs is not a rational.
        have rhs_non_integer : ¬ ∃ (z : ℤ), rhs = z :=by
            -- By irreducibility of a / b, it cannot be an integer.
          sorry
        -- Using h_eq, derive lhs = rhs, which contradicts lhs_integer and rhs_non_integer
        have : ¬∃ (z : ℤ), lhs = z := by
          rw [h_eq]
          exact rhs_non_integer

        contradiction

      exact h_contra
