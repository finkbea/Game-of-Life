program rand
REAL :: r(100,100)
integer :: x(100,100)
CALL RANDOM_NUMBER(r)

x = nint(r)

WRITE(*,'(100I1)')(x)
end program rand
