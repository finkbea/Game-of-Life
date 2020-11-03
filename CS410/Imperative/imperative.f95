!Adicus Finkbeiner
!CS410 May 2019
program imperative
implicit none
!NOTES:
!This program reads a single command line argument letting it know how many times it should run before terminating.
!You should enlarge the terminal to be able to view the output
!I tried to use reshape because I thought it was a cool feature (a builtin that changed the dimensions of arrays) but I couldn't find an actual use for it

CHARACTER(10) :: numChar !will be set to the command line argument
!the integers are the indexes for the loops (i, j, k) and affiliation is the affiliation of the next 
!generation
integer i, j, k, affiliation
REAL :: num
REAL :: temp(100,100)
integer :: now(102,102) !apparently current is a keyword
integer :: next(102,102)
integer :: final(100,100)

!integer, allocatable :: seed(:)
integer :: x, y, clock
integer, dimension(:), allocatable :: seed


!randomizes the seed so random is actually random each time
!from http://earth.sci.ehime-u.ac.jp/~kameyama/classes/gfortran/RANDOM_005fSEED.html, I'd be lying if
!I said I fully understood whats ging on here, but its basically just randomizing the seed each time so that it doesn't just give me the exact same random numbers each time. 
call random_seed(size = x)
allocate(seed(x))
call system_clock(count=clock)
seed = clock + 37 * (/ (y-1, y=1, x) /)
call random_seed(PUT = seed)
DEALLOCATE(seed)

!randomizes everything in temp to random values between 0 and 1
CALL RANDOM_NUMBER(temp)

!sets everything in now and next to 0
now = 0
next = 0
!sets the current array equal to the rounded integer values present in temp using array slicing to 
!leave the zeroes as the border
now(2:101, 2:101) = nint(temp)

!makes sure there is only one argument on the command line (the number of cycles that should be run).
!If there are fewer arguments then I alert the user and end the program. The CALL sets numChar equal
!to the first command line argument
IF (command_argument_count().NE.1) THEN
    WRITE(*,*)'ERROR: SPECIFY THE NUMBER OF ITERATIONS IN THE COMMAND LINE'
    STOP
ENDIF
CALL GET_COMMAND_ARGUMENT(1, numChar)
!prints the current matrix in the terminal
final = now(1:100, 1:100)
WRITE(*,'(100I1)')(final)
!sets num to numChar, this is done so that I can call nint on num 
!(can only be called on REAL type and converts them to integers).
READ(numChar, *)num

!iterates through as many times as the user specifies, for each loop it will loop through every
!single character in this thousand character matrix, then I set affiliation equal to the sum of the 
!current index and all its neighbors using array slicing, if affiliation is greater than five then 
!in the next array at that index it is 1, else it is 0
do k=1, nint(num)
    do j = 2, 101
        do i = 2, 101
            !there is literally no reason for the reshape other than I thought it was a kind of cool 
            !feature I should include. It reshapes the specified characters 
            affiliation = sum(now(i-1:i+1, j-1:j+1))
            if (affiliation >= 5) then 
                next(i,j) = 1
            else 
                next(i,j) = 0
            endif
            affiliation = 0
        enddo
    enddo
    WRITE(*,*)
    WRITE(*,*)'Next Interation'
    final = now(2:101, 2:101)
    !prints the array
    !The number before the I signifies how many characters per line and the number after the line indicates
    !how many spaces between characters
    WRITE(*,'(100I1)')(final) !prints the array
    !sets the current array equal to next, I don't bother resetting next because the values will just be overridden
    now=next; 
enddo    

end program imperative
