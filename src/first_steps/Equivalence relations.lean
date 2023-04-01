import data.int.basic
import data.setoid.basic

def even (n : ℤ) : Prop := ∃ k : ℤ, n = 2 * k

#check even
#check even 2
#check even 3

example : even 2 := by {use 1, rw mul_one}
-- lemma two_is_even : even 2 := by {use 1, simp}

def even_diff (n m : ℤ) : Prop := even (n - m)

-- infix ` ≡ `:50 := even_diff

-- def r ( a b : ℤ ) : Prop := a ≡ b

--Next we just rename even_diff to r
def r ( a b : ℤ ) : Prop := even_diff a b

#check equivalence
#check mk_equivalence

theorem r_is_equiv_rel : equivalence r := 
  begin
    unfold equivalence,
    --split,
    repeat { any_goals {split} },
    {
      unfold reflexive r, 
      intro x, 
      unfold even_diff, 
      unfold even,
      use 0,
      rw mul_zero,
      rw sub_self,
    },
    {
      unfold symmetric,
    intros x y,
    unfold r,
    unfold even_diff,
    unfold even,
    intro h,
    cases h with k h_k,
    use -k,
    simp,
    apply eq_neg_of_eq_neg,
    rw ← mul_neg_one,
    simp,
    symmetry,
    exact h_k,
    },
    {
       unfold transitive r even_diff even,
    intros x y z,
    intro h_xy,
    cases h_xy with k h_xy,
    intro h_yz,
    cases h_yz with l h_yz,
    use k+l,
    have h : x-z= 2*k + 2*l :=
      begin
        have h : (x-y) + (y-z) = x-z := by simp,
        rw ← h,
        rw h_xy,
        rw h_yz,
      end,
    rw h,
    rw mul_add,
    },
  end

lemma reflexive_r : reflexive r := 
  begin
    unfold reflexive,
    unfold r,
    unfold even_diff,
    unfold even,
    intro x,
    simp,
    use 0,
    simp,
  end

lemma symmetric_r : symmetric r := 
  begin
    unfold symmetric,
    intros x y,
    unfold r,
    unfold even_diff,
    unfold even,
    intro h,
    cases h with k h_k,
    use -k,
    simp,
    apply eq_neg_of_eq_neg,
    rw ← mul_neg_one,
    simp,
    symmetry,
    exact h_k,
  end

lemma transitive_r : transitive r := 
  begin
    unfold transitive r even_diff even,
    intros x y z,
    intro h_xy,
    cases h_xy with k h_xy,
    intro h_yz,
    cases h_yz with l h_yz,
    use k+l,
    have h : x-z= 2*k + 2*l :=
      begin
        have h : (x-y) + (y-z) = x-z := by simp,
        rw ← h,
        rw h_xy,
        rw h_yz,
      end,
    rw h,
    rw mul_add,
  end

theorem r_is_equiv_rel_alt : equivalence r := 
mk_equivalence r reflexive_r symmetric_r transitive_r 




