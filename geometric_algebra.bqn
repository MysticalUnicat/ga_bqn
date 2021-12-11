⟨ Algebra ⟩⇐

Algebra ← {
  dimensions ← 𝕩
  p‿q‿r ← dimensions
  num_dimensions ← +´ dimensions
  num_basis ← 2⋆num_dimensions
  one_vector_metric ← 1‿r‿p‿q / 1‿0‿1‿¯1
  full_name ← 1+↕num_dimensions
  bits ← (⍋∘(+´¨))⊸⊏ ⌽¨ ⥊↕num_dimensions⥊2
  name ← full_name⊸×¨ bits
  ename ← "" <⊸∾ 1↓ bits { 'e' <⊸∾ '0' + 𝕨/𝕩 - r>0 }¨ name
  grade ← +´¨ bits
  cayley_basis ← bits ⊐ ≠⌜˜ bits
  cayley_match ← ∧⌜˜ bits
  cayley_match_sign ← ×´¨ ⊏⟜one_vector_metric¨ full_name⊸×¨ cayley_match
  cayley_swap_sign ← ¯1 ⋆ {+´ ⥊ 𝕩⊸<˘ 𝕨}⌜˜ (bits /¨ name)
  cayley_sign ← cayley_match_sign × cayley_swap_sign
  cayley_grade ← cayley_basis ⊏ grade

	_mkMultivector ← {𝔽○(↑˜⟜num_basis)}

	One ⇐ ⊑
	E ⇐ {
  	num_basis ↑ 1 ↑˜ - 1 + ⊑ bits ⊐ <full_name ∊ ⥊ (𝕩 + r>0)
  }

  _mkProduct ← {
		sign ← 𝕗 × cayley_sign
		{   𝕊 a : × One a ;
		  a 𝕊 b : +´˘ a ×⎉1 sign × cayley_basis ⊏ b
		} _mkMultivector
  }

  Add ⇐ + _mkMultivector
  Subtract ⇐ - _mkMultivector

	GeometricProduct ⇐ (1˙⌜˜ grade) _mkProduct
	ExteriorProduct ⇐ (cayley_grade = +⌜˜ grade) _mkProduct
	LeftInnerProduct ⇐ (cayley_grade = -˜⌜˜ grade) _mkProduct
	RightInnerProduct ⇐ (cayley_grade = -⌜˜ grade) _mkProduct
	RegressiveProduct ⇐ (cayley_grade = -⌜˜ grade) _mkProduct

	InnerProduct ⇐ LeftInnerProduct

	Log ⇐ {
  	num ← 𝕩
  	nz ← 0≠num
  	(∨´nz)◶{𝕤
		  ""
		}‿{𝕤
	    { 𝕨∾" + "∾𝕩 }´ {x‿y:(•Fmt x) ∾ y}¨ nz / num ⋈¨ ename
		} @
  }

	Negate ⇐ -∘↑˜⟜num_basis
	Reverse ⇐ (1‿1‿¯1‿¯1 ⊏˜ 4 | grade)⊸× _mkMultivector
	Involute ⇐ (1‿¯1‿1‿¯1 ⊏˜ 4 | grade)⊸× _mkMultivector
	Conjugate ⇐ (1‿¯1‿¯1‿1 ⊏˜ 4 | grade)⊸× _mkMultivector
  
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
    mxc ← (grade ∊ 3‿4) × xc
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
