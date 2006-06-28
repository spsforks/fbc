'' Implicit/Explicit Variable Scope Tests
'' With/without inner explicit dim's
'' and variable name shadowing.

assert(__FB_OPTION_EXPLICIT__ = 0)


'' SCOPE...END SCOPE creates a new local scope
'' implicit variable scope is inherited
'':::::
sub test_opt_imp_scope_imp_inherit
  x = 1
  assert( x = 1 )
  
  scope
    x += 3
    assert( x = 4 )
  
    scope
      x += 5
      assert( x = 9 )
    end scope
  
    x += 3
    assert( x = 12 )
  
  end scope
  
  x += 1
  assert( x = 13 )
end sub


'' SCOPE...END SCOPE creates a new local scope
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_imp_scope_exp_shadow

  x = 1
  assert( x = 1 )
  
  scope
    dim x
    x += 3
    assert( x = 3 )
  
    scope
      dim x
      x += 5
      assert( x = 5 )
    end scope
  
    x += 3
    assert( x = 6 )
  
  end scope

  x += 1
  assert( x = 2 )

end sub


'' IF...THEN creates a new local scope
'' implicit variable scope is inherited
'':::::
sub test_opt_imp_if_imp_inherit

  x = 1
  assert( x = 1 )
  
  if 1 then
    x += 1
    assert( x = 2 )
  else
    assert( 0 )
  end if
  
  assert( x = 2 )

  if 0 then
    assert( 0 )
  else
    x += 1
    assert( x = 3 )
  end if

  assert( x = 3 )

end sub


'' IF...THEN creates a new local scope
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_imp_if_exp_shadow

  x = 1
  assert( x = 1 )
  
  if 1 then
    dim x
    x += 2
    assert( x = 2 )
  else
    assert( 0 )
  end if
  
  assert( x = 1 )
  
  if 0 then
    assert( 0 )
  else
    dim x
    x += 2
    assert( x = 2 )
  end if
  
  assert( x = 1 )

end sub

  
'' DO...WHILE creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_imp_do_scoping
  
  x = 1
  assert( x = 1 )
  
  do
    x += 1
    assert( x = 2 )
    exit do
  loop
  
  assert( x = 2 )
  
  x = 1
  assert( x = 1 )
  
  do
    dim x
    x += 1
    assert( x = 1 )
    exit do
  loop
  

  i = 0
  assert( i = 0 )
  
  x = 0
  assert( x = 0 )
  
  do
    dim x
    x += 1
    i += 1
  
    assert( x = 1 )
  
    if( i > 10 ) then
      exit do
    end if
  
  loop
  
  assert( i = 11 )
  assert( x = 0 )
  
  i = 0
  x = 0
  
  do
    x += 1
    i += 1
  
    assert( x = i )
  
    if( i > 10 ) then
      exit do
    end if
  
  loop
  
  assert( i = 11 )
  assert( x = 11 )

end sub


'' WHILE...WEND creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_imp_while_scoping
  
  x = 1
  assert( x = 1 )
  
  while 1
    x += 1
    assert( x = 2 )
    exit while
  wend
  
  assert( x = 2 )
  
  x = 1
  assert( x = 1 )
  
  while 1
    dim x
    x += 1
    assert( x = 1 )
    exit while
  wend
  
  i = 0
  assert( i = 0 )
  
  x = 0
  assert( x = 0 )
  
  while 1
    dim x
    x += 1
    i += 1
  
    assert( x = 1 )
  
    if( i > 10 ) then
      exit while
    end if
  
  wend
  
  assert( i = 11 )
  assert( x = 0 )
  
  i = 0
  x = 0
  
  while 1
    x += 1
    i += 1
  
    assert( x = i )
  
    if( i > 10 ) then
      exit while
    end if
  
  wend
  
  assert( i = 11 )
  assert( x = 11 )

end sub


'' FOR...NEXT creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_imp_for_scoping
  
  x = 1
  assert( x = 1 )
  
  for i = 1 to 10
    x += 1
    assert( x = 2 )
    exit for
  next i
  
  assert( x = 2 )
  
  x = 1
  assert( x = 1 )
  
  for i = 1 to 10
    dim x
    x += 1
    assert( x = 1 )
    exit for
  next i
  
  i = 0
  assert( i = 0 )
  
  x = 0
  assert( x = 0 )
  
  for i = 1 to 10
    dim x
    x += 1
  
    assert( x = 1 )
  
  next i
  
  assert( i = 11 )
  assert( x = 0 )
  
  for i = 1 to 10
    x += 1
  
    assert( x = i )
  
  next i
  
  assert( i = 11 )
  assert( x = 10 )
  
  
end sub



'' --------------------------------------

'' Explicit Variable Scope Tests
'' With/without inner explicit dim's
'' and variable name shadowing.
option explicit

assert(__FB_OPTION_EXPLICIT__ <> 0)


'' SCOPE...END SCOPE creates a new local scope
'' implicit variable scope is inherited
'':::::
sub test_opt_exp_scope_imp_inherit
  dim x

  x = 1
  assert( x = 1 )
  
  scope
    x += 3
    assert( x = 4 )
  
    scope
      x += 5
      assert( x = 9 )
    end scope
  
    x += 3
    assert( x = 12 )
  
  end scope
  
  x += 1
  assert( x = 13 )
end sub


'' SCOPE...END SCOPE creates a new local scope
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_exp_scope_exp_shadow

  dim x

  x = 1
  assert( x = 1 )
  
  scope
    dim x
    x += 3
    assert( x = 3 )
  
    scope
      dim x
      x += 5
      assert( x = 5 )
    end scope
  
    x += 3
    assert( x = 6 )
  
  end scope

  x += 1
  assert( x = 2 )

end sub


'' IF...THEN creates a new local scope
'' implicit variable scope is inherited
'':::::
sub test_opt_exp_if_imp_inherit
  dim x

  x = 1
  assert( x = 1 )
  
  if 1 then
    x += 1
    assert( x = 2 )
  else
    assert( 0 )
  end if
  
  assert( x = 2 )

  if 0 then
    assert( 0 )
  else
    x += 1
    assert( x = 3 )
  end if

  assert( x = 3 )

end sub


'' IF...THEN creates a new local scope
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_exp_if_exp_shadow

  dim x

  x = 1
  assert( x = 1 )
  
  if 1 then
    dim x
    x += 2
    assert( x = 2 )
  else
    assert( 0 )
  end if
  
  assert( x = 1 )
  
  if 0 then
    assert( 0 )
  else
    dim x
    x += 2
    assert( x = 2 )
  end if
  
  assert( x = 1 )

end sub

  
'' DO...WHILE creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_exp_do_scoping

  dim x, i
    
  x = 1
  assert( x = 1 )
  
  do
    x += 1
    assert( x = 2 )
    exit do
  loop
  
  assert( x = 2 )
  
  x = 1
  assert( x = 1 )
  
  do
    dim x
    x += 1
    assert( x = 1 )
    exit do
  loop
  

  i = 0
  assert( i = 0 )
  
  x = 0
  assert( x = 0 )
  
  do
    dim x
    x += 1
    i += 1
  
    assert( x = 1 )
  
    if( i > 10 ) then
      exit do
    end if
  
  loop
  
  assert( i = 11 )
  assert( x = 0 )
  
  i = 0
  x = 0
  
  do
    x += 1
    i += 1
  
    assert( x = i )
  
    if( i > 10 ) then
      exit do
    end if
  
  loop
  
  assert( i = 11 )
  assert( x = 11 )

end sub


'' WHILE...WEND creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_exp_while_scoping

  dim x, i
  
  x = 1
  assert( x = 1 )
  
  while 1
    x += 1
    assert( x = 2 )
    exit while
  wend
  
  assert( x = 2 )
  
  x = 1
  assert( x = 1 )
  
  while 1
    dim x
    x += 1
    assert( x = 1 )
    exit while
  wend
  
  i = 0
  assert( i = 0 )
  
  x = 0
  assert( x = 0 )
  
  while 1
    dim x
    x += 1
    i += 1
  
    assert( x = 1 )
  
    if( i > 10 ) then
      exit while
    end if
  
  wend
  
  assert( i = 11 )
  assert( x = 0 )
  
  i = 0
  x = 0
  
  while 1
    x += 1
    i += 1
  
    assert( x = i )
  
    if( i > 10 ) then
      exit while
    end if
  
  wend
  
  assert( i = 11 )
  assert( x = 11 )

end sub


'' FOR...NEXT creates a new local scope
'' implicit variable scope is inherited
'' DIM inside SCOPE shadows parent scope variable
'':::::
sub test_opt_exp_for_scoping

  dim x, i

  x = 1
  assert( x = 1 )
  
  for i = 1 to 10
    x += 1
    assert( x = 2 )
    exit for
  next i
  
  assert( x = 2 )
  
  x = 1
  assert( x = 1 )
  
  for i = 1 to 10
    dim x
    x += 1
    assert( x = 1 )
    exit for
  next i
  
  i = 0
  assert( i = 0 )
  
  x = 0
  assert( x = 0 )
  
  for i = 1 to 10
    dim x
    x += 1
  
    assert( x = 1 )
  
  next i
  
  assert( i = 11 )
  assert( x = 0 )
  
  for i = 1 to 10
    x += 1
  
    assert( x = i )
  
  next i
  
  assert( i = 11 )
  assert( x = 10 )
  
  
end sub



'' withOUT option explicit

test_opt_imp_scope_imp_inherit
test_opt_imp_scope_exp_shadow
test_opt_imp_if_imp_inherit
test_opt_imp_if_exp_shadow
test_opt_imp_do_scoping
test_opt_imp_while_scoping
test_opt_imp_for_scoping


'' WITH option explicit

test_opt_exp_scope_imp_inherit
test_opt_exp_scope_exp_shadow
test_opt_exp_if_imp_inherit
test_opt_exp_if_exp_shadow
test_opt_exp_do_scoping
test_opt_exp_while_scoping
test_opt_exp_for_scoping

