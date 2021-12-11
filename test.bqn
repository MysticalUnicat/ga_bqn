⟨ Algebra ⟩ ← •Import "geometric_algebra.bqn"

{𝕤
  ga ← Algebra 2‿0‿1
  
  e0 ← ga.E 0
  e1 ← ga.E 1
  e2 ← ga.E 2
  e01 ← ga.E 0‿1
  e02 ← ga.E 0‿2
  e12 ← ga.E 1‿2
  e012 ← ga.E 0‿1‿2

  ! ∧´ e0   = 0‿1‿0‿0‿0‿0‿0‿0
  ! ∧´ e1   = 0‿0‿1‿0‿0‿0‿0‿0
  ! ∧´ e2   = 0‿0‿0‿1‿0‿0‿0‿0
  ! ∧´ e01  = 0‿0‿0‿0‿1‿0‿0‿0
  ! ∧´ e02  = 0‿0‿0‿0‿0‿1‿0‿0
  ! ∧´ e12  = 0‿0‿0‿0‿0‿0‿1‿0
  ! ∧´ e012 = 0‿0‿0‿0‿0‿0‿0‿1

  Point ← {x‿y: +´ x‿y‿1 × e02‿e01‿e12}

  p0 ← Point⟨1, 2⟩
  ! ∧´ p0 = 0‿0‿0‿0‿2‿1‿1‿0
  ! ∧´ (2 ga.GeometricProduct p0) = 0‿0‿0‿0‿4‿2‿2‿0
  ! ∧´ (p0 ga.GeometricProduct p0) = ¯1‿0‿0‿0‿0‿0‿0‿0
} @

#----------------------------------------------------------
# 3d pga example
ga ← Algebra 3‿0‿1

e0 ← ga.E 0
e1 ← ga.E 1
e2 ← ga.E 2
e3 ← ga.E 3

Rotor ← {angle‿line:
  a ← angle ÷ 2
  c ← •math.Cos a
  s ← •math.Sin a
  c ga.Add s × line
}

Translator ← {dist‿line:
  1 ga.Add (dist ÷ 2) × line
}

Plane ← {a‿b‿c‿d : +´ a‿b‿c‿d × e1‿e2‿e3‿e0}

e123 ← ga.E 1‿2‿3
e032 ← ga.E 0‿3‿2
e013 ← ga.E 0‿1‿3
e021 ← ga.E 0‿2‿1

Point ← {x‿y‿z: +´ x‿y‿z‿1 × e032‿e013‿e021‿e123}

Circle ← {t‿radius‿line:
  (Rotor⟨t × 2 × π, line⟩) ga.GeometricProduct Translator⟨radius, e1 ga.GeometricProduct e0⟩
}

Torus ← {s‿t‿r1‿l1‿r2‿l2:
  (Circle⟨s, r2, l2⟩) ga.GeometricProduct Circle⟨t, r1, l1⟩
}

PointOnTorus ← {s‿t:
  to ← Torus⟨s, t, 0.25, e1 ga.GeometricProduct e2, 0.6, e1 ga.GeometricProduct e3⟩
  to ga.Sandwich e123
}

rot ← Rotor⟨π ÷ 2, e1 ga.GeometricProduct e2⟩

ax_z ← e1 ga.ExteriorProduct e2

orig ← ax_z ga.ExteriorProduct e3

px ← Point⟨1, 0, 0⟩
line ← orig ga.RegressiveProduct px

p ← Plane⟨2, 0, 1, ¯3⟩

rotated_plane ← rot ga.Sandwich p
rotated_line ← rot ga.Sandwich line
rotated_point ← rot ga.Sandwich px

point_on_plane ← (p ga.InnerProduct px) ga.GeometricProduct p

•Out "a point        : " ∾ ga.Log px
•Out "a line         : " ∾ ga.Log line
•Out "a plane        : " ∾ ga.Log p
•Out "a rotor        : " ∾ ga.Log rot
•Out "rotated line   : " ∾ ga.Log rotated_line
•Out "rotated point  : " ∾ ga.Log rotated_point
•Out "rotated_plane  : " ∾ ga.Log rotated_plane
•Out "point on plane : " ∾ ga.Log ga.Normalize point_on_plane
•Out "point on torus : " ∾ ga.Log PointOnTorus⟨0, 0⟩
•Out ga.Log (e0 ga.Subtract 1)
•Out ga.Log (1 ga.Subtract e0)

