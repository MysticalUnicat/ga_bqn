# ga_bqn
Geometric Algebra for BQN

geometric_algebra.bqn provides a single function, `Algebra` that takes a single 3 length list of natural numbers.

The first number is for positive dimensions, the second for negative dimensions and third for degenerate dimensions.

`Algebra` returns a namespace with geometric functions for that algebra.

```
positive ← 2
negative ← 0
degenerate ← 1
pga2d ← Algebra positive‿negative‿degenerate

⟨Mul, Wedge, Vee, Dot⟩ ← ⟨ 
  pga2d.GeometricProduct
  pga2d.ExteriorProduct
  pga2d.RegressiveProduct
  pga2d.InnerProduct
⟩
```
