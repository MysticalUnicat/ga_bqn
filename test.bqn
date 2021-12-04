⟨_geometricAlgebra⟩ ← •Import "geometric_algebra.bqn"

Pga2d ← 2‿0‿1 _geometricAlgebra

Grade0 ← 0 pga2d._grade
Grade1 ← 1 pga2d._grade
Grade2 ← 2 pga2d._grade
Grade3 ← 3 pga2d._grade

Point ← {x‿y:pga2d.ToMV 0‿0‿0‿0‿y‿x‿1}
Direction ← {x‿y:pga2d.ToMV 0‿0‿0‿0‿y‿x}

p0 ← Point⟨1.25, 1.75⟩

•Show "Norm"‿(pga2d.Norm p0)
•Show "Reverse"‿(pga2d.Reverse p0)
•Show "Add"‿(2 pga2d.Add p0)
•Show "Mul"‿(2 pga2d.Mul p0)
