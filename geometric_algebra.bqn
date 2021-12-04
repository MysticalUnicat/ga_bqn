⟨ _geometricAlgebra ⟩⇐

_geometricAlgebra ← {
  p‿q‿r ← 𝕗

  tot ← +´ 𝕗

  ngrades ← 1+tot
  nbasis ← 2⋆tot
  metric ← r‿p‿q/0‿1‿¯1

  ToBinary ← 2{⌽𝕗|⌊∘÷⟜𝕗⍟(↕1+·⌊𝕗⋆⁼1⌈⊢)} # from bqncrate

  basis_bits ← (⍋+´¨)⊸⊏ { ⌽ (-tot)↑ ToBinary }¨ ↕nbasis
  basis_name ← { ⍋⊸⊏ (↕tot)/˜ 𝕩 }¨ basis_bits
  basis_grade ← +´¨ basis_bits
  basis_metric ← 1 <⊸∾ metric ∾ ¯1×{×´metric/˜𝕩}¨(tot+1)↓basis_bits

  MulBasis ← {
    0 𝕊 0 : 0 ;
    a ← >𝕨⊑basis_bits
    b ← >𝕩⊑basis_bits
    +´(a≠b)×2⋆↕tot
  }

  MulSign ← {
    0 𝕊 0 : 1 ;
    an ← 𝕨⊑basis_name
    bn ← 𝕩⊑basis_name
    ¯1⋆+´ an ( +´⎉1 <⌜ ) bn
  }

  cayley_basis ← MulBasis⌜˜ ↕nbasis
  cayley_sign ← MulSign⌜˜ ↕nbasis

  ToMV ⇐ nbasis⊸↑

  _gradeNegate ⇐ {((4|basis_grade) ⊏ 𝕗) × 𝕩}

  _grade ⇐ {(𝕗=basis_grade)/ToMV}
  Reverse ⇐ 1‿1‿¯1‿¯1 _gradeNegate
  Involute ⇐ 1‿¯1‿1‿¯1 _gradeNegate
  Conjugate ⇐ 1‿¯1‿¯1‿1 _gradeNegate

  HodgeDual ⇐ {⌽○ToMV𝕩}
  
  Dual ⇐ r=0◶HodgeDual‿{(-nbasis)↑1×𝕩}
  
  Mul ⇐ {+´⎉1 cayley_sign × (cayley_basis⊏𝕩) ×⎉1 𝕨}○ToMV
  Add ⇐ +○ToMV
  Sub ⇐ -○ToMV

  Norm ⇐ {√|1⊑Conjugate⊸Mul˜𝕩}
  Normalize ⇐ Div⟜Norm
  
}

