⟨ Algebra ⟩⇐

Algebra ← {
  p‿q‿r ← 𝕩
  num_dimensions ← ⌊ +´ 𝕩
  num_basis ← 2⋆num_dimensions
	
	one_vector_metric ← 1‿r‿p‿q / 1‿0‿1‿¯1

	nameset ← 1+↕num_dimensions
  FromBase2 ← {+´𝕩×2⋆↕≠𝕩}

  bits ← ⌊ 2 | (↕2⋆num_dimensions) ÷⌜ 2⋆↕num_dimensions
  name ← nameset⊸×˘ bits
	metric ← ×´˘ name ⊏ one_vector_metric
  grades ← +´˘ bits
  
	cayley ← {
    a_bits ← 𝕨 ⊏ bits
    b_bits ← 𝕩 ⊏ bits
    basis ← FromBase2 a_bits ≠ b_bits
    a_name ← 𝕨 ⊏ name
    b_name ← 𝕩 ⊏ name
    match_sign ← metric ⊑˜ FromBase2 a_bits ∧ b_bits
		sign ← ((𝕨=0) ∨ (𝕩=0))◶⟨{𝕤
		  elim ← a_bits ∧ b_bits
      ae ← a_bits ≠ elim
      be ← b_bits ≠ elim
      an ← ae / (ae × ↕num_dimensions)
      bn ← be / (be × ↕num_dimensions)
      ¯1⋆ +´ ⥊ an >⌜ bn
		}, 1˙⟩ @
    (match_sign × sign)‿basis
	}⌜˜ ↕2⋆num_dimensions

	cayley_sign ← 0⊑¨cayley
	cayley_basis ← 1⊑¨cayley
	cayley_grade ← cayley_basis ⊏ grades

	_mkMultivector ← {𝔽○(↑˜⟜num_basis)}

	One ⇐ ⊑
	E ⇐ {
    » ⌽ num_basis -⊸↑ 1 ↑˜ +´ 2 ⋆ ⥊ 𝕩
  }

  _mkProduct ← {
		sign ← 𝕗 × cayley_sign
		{   𝕊 a : × One a ;
		  a 𝕊 b : +´˘ a ×⎉1 sign × cayley_basis ⊏ b
		} _mkMultivector
  }

  Add ⇐ + _mkMultivector
  Subtract ⇐ - _mkMultivector

	GeometricProduct ⇐ (1˙⌜˜ grades) _mkProduct
	ExteriorProduct ⇐ (cayley_grade = +⌜˜ grades) _mkProduct
	LeftInnerProduct ⇐ (cayley_grade = -˜⌜˜ grades) _mkProduct
	RightInnerProduct ⇐ (cayley_grade = -⌜˜ grades) _mkProduct
	RegressiveProduct ⇐ (cayley_grade = -⌜˜ grades) _mkProduct

	InnerProduct ⇐ LeftInnerProduct

	Log ⇐ {
    ""˙ 𝕩
  }

	Negate ⇐ -∘↑˜⟜num_basis
	Reverse ⇐ (1‿1‿¯1‿¯1 ⊏˜ 4 | grades)⊸× _mkMultivector
	Involute ⇐ (1‿¯1‿1‿¯1 ⊏˜ 4 | grades)⊸× _mkMultivector
	Conjugate ⇐ (1‿¯1‿¯1‿1 ⊏˜ 4 | grades)⊸× _mkMultivector
  
  Inverse ⇐ ((5⌊num_dimensions)◶÷‿{
    i ← Involute 𝕩
    i ÷⟜One (𝕩 GeometricProduct i)
  }‿{
    c ← Conjugate 𝕩
    c ÷⟜One (𝕩 GeometricProduct c)
  }‿{
    i ← Involute 𝕩
    c ← Conjugate 𝕩
    r ← Reverse 𝕩
    left ← GeometricProduct´ r‿i‿c
    right ← GeometricProduct´ 𝕩‿c‿i‿r
    left ÷⟜One right
  }‿{
    c ← Conjugate 𝕩
    xc ← 𝕩 GeometricProduct c
    mxc ← (grades ∊ 3‿4) × xc
    (c GeometricProduct mxc) ÷⟜One (xc GeometricProduct mxc)
  }‿{
    #c ← Conjugate 𝕩
    #i ← Involute 𝕩
    #r ← Reverse 𝕩
    #cir ← c Mul i Mul r
    #mxcir ← 1‿4 Map 𝕩 Mul cir
    #cirmxcir ← cir Mul mxcir
    #left ← cirmxcir
    #right ← 𝕩 Mul cirmxcir
    #left ÷⟜One right
    𝕩
  }‿{
    # shirokov inverse
    #n ← 2⋆⌊(tot+1÷2)
    #self ← 𝕩
    #uk ← 1 { self Mul 𝕨 Sub 𝕩 × One 𝕨 }´ n⊸÷¨ 1↓↕n
    𝕩
  }) _mkMultivector

  Divide ⇐ { Inverse 𝕩 ; 𝕨 GeometricProduct Inverse 𝕩 }

  Length ⇐ { √ | One 𝕩 GeometricProduct Conjugate 𝕩 } _mkMultivector
  Normalize ⇐ { 𝕩 × ÷ Length 𝕩 }
  
  Sandwich ⇐ { 𝕨 GeometricProduct 𝕩 GeometricProduct Reverse 𝕨 }
}
