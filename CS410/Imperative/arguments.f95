program test
CHARACTER(10) :: numChar
!REAL :: num;
IF (command_argument_count().NE.1) THEN
    WRITE(*,*)'ERROR: SPECIFY THE NUMBER OF ITERATIONS IN THE COMMAND LINE'
    STOP
ENDIF

CALL GET_COMMAND_ARGUMENT(1, numChar)

!READ(numChar, *)num

WRITE(*,*)numChar

end program test
