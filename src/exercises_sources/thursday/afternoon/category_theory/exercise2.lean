import category_theory.preadditive
import category_theory.limits.shapes.biproducts

/-!
We prove that biproducts (direct sums) are preserved by any preadditive functor.

This result is not in mathlib, so full marks for the exercise are only achievable if you
contribute to a pull request! :-)
-/

universes v₁ v₂ u₁ u₂

open category_theory
open category_theory.limits

namespace category_theory

variables {C : Type u₁} [category.{v₁} C] [preadditive C]
variables {D : Type u₂} [category.{v₂} D] [preadditive D]

/-!
In fact, no one has gotten around to defining preadditive functors,
so I'll help you out by doing that first.
-/

structure functor.preadditive (F : C ⥤ D) : Prop :=
(map_zero' : ∀ X Y, F.map (0 : X ⟶ Y) = 0)
(map_add' : ∀ {X Y} (f g : X ⟶ Y), F.map (f + g) = F.map f + F.map g)

variables [has_binary_biproducts C] [has_binary_biproducts D]
-- In fact one could prove a better result,
-- not requiring chosen biproducts in D,
-- just asserting that `F.obj (X ⊞ Y)` is a biproduct of `F.obj X` and `F.obj Y`.

def functor.preadditive.preserves_biproducts (F : C ⥤ D) (P : F.preadditive) (X Y : C) :
  F.obj (X ⊞ Y) ≅ F.obj X ⊞ F.obj Y :=
{ hom := biprod.lift (F.map biprod.fst) (F.map biprod.snd),
  inv := biprod.desc (F.map biprod.inl) (F.map biprod.inr),
  hom_inv_id' := begin simp, simp_rw [←F.map_comp, ←P.map_add'], simp, end,
  inv_hom_id' := begin ext; simp; simp_rw [←F.map_comp]; simp [P.map_zero'], end, }
-- This proof is not okay as a mathlib proof, because it uses "nonterminal" `simp`s.
-- Can you fix it?


end category_theory

