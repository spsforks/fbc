' TEST_MODE : COMPILE_ONLY_FAIL

type T1 extends object
end type

type T2 extends T1
end type

type T3 extends T2
end type

function a overload( byref x as T2 ) as integer : function = &h02 : end function
function a overload( byref x as T3 ) as integer : function = &h03 : end function

dim cx1 as T1 = T1( )
a( cx1 )
