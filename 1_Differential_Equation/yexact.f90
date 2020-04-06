! ****************************************************
!   FRANK MANU
!   SPRING 2020
!   EECE.5200 - COMPUTER AIDED ENGINEERING ANAYLSIS
!   PROBLEM SET 4 - PART 1
! ****************************************************

! VARIABLES
REAL FUNCTION YEXACT(T)
IMPLICIT NONE
REAL T
REAL  C1,C2,E

E= EXP(1.0)
C1 = - (2*E*E-E  )/(E-1.0)
C2 =   (2*E*E-1.0)/(E-1.0)

! DEFINING DIRECT EQUATION 
YEXACT= C1*EXP(-2.0*T) +C2*EXP(-1.0*T)

RETURN
END
