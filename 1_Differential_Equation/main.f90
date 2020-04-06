! ****************************************************
!   FRANK MANU
!   SPRING 2020
!	REF: DR. THOMPSON
!   EECE.5200 - COMPUTER AIDED ENGINEERING ANAYLSIS
!   PROBLEM SET 4 - PART 1
! ****************************************************

! VARIABLES
	IMPLICIT NONE
	INTEGER,PARAMETER :: N=10, NITER=100
	INTEGER ITER,I,J
	REAL DX,DX2
	REAL JACOBI_OUTPUT(0:N),JACOBI_NEW(0:N),JACOBI_ERROR(0:NITER)
	REAL GAUSS_OUTPUT (0:N),GAUSS_NEW(0:N),GAUSS_ERROR(0:NITER)

	REAL AM(N-1,N-1),BM(N-1),COND,DIRECT_OUTPUT(0:N)

	REAL A,B,C
	REAL YEXACT

	DX = 1.0/N
	DX2= DX*DX

	A =  (2*DX2- 2)/DX2
	B = -(3*DX - 2)/(2*DX2)
	C =  (3*DX + 2)/(2*DX2)


! DIRECT BASED ON ===> 1)  A*Y(J) + B*Y(J-1)+C*Y(J+1)=0 ===> 2)  Y'' + Y' +2 Y=0
 AM(1:N-1,1:N-1)=0.0
 BM(1:N-1)=0.0

 DIRECT_OUTPUT(0)=1.0
 DIRECT_OUTPUT(N)=2.0
 AM(1,1)=A; AM(1,2)=C; BM(1)= -B*DIRECT_OUTPUT(0);
 DO I=2,N-2
	AM(I,I-1)=B
	AM(I,I)  =A
	AM(I,I+1)=C
	BM(I)   =0
 ENDDO
AM(N-1,N-2)=B; AM(N-1,N-1)=A;  BM(N-1)= -C*DIRECT_OUTPUT(N);

CALL GESS (N-1,AM,N-1,BM,N-1,1,COND)

DO I=1,N-1
 DIRECT_OUTPUT(I) = BM(I)
ENDDO

WRITE(*,*) 'DIRECT SOLUTION:'
DO I=0,N
	WRITE(*,*) I*DX,DIRECT_OUTPUT(I)
ENDDO
WRITE(*,*) ''


! JACOBI BASED ON EQUATION ===> YNEW(J) = -1./A*(+ B*Y(J-1)+C*Y(J+1))
	JACOBI_OUTPUT=0
	JACOBI_OUTPUT(0)=1.0
	JACOBI_OUTPUT(N)=2.0
  DO ITER=0,NITER
	JACOBI_NEW(0)= JACOBI_OUTPUT(0)
	DO J=1,N-1
	 JACOBI_NEW(J)	= - 1.0/A * ( B*JACOBI_OUTPUT(J-1) +C*JACOBI_OUTPUT(J+1) )
        ENDDO
	JACOBI_NEW(N)=JACOBI_OUTPUT(N)
		! COMPUTE ERROR AT EACH ITERATION
		JACOBI_ERROR(ITER)=0
		DO I=0,N
	 	 JACOBI_ERROR(ITER) = JACOBI_ERROR(ITER) + (JACOBI_NEW(I)-JACOBI_OUTPUT(I))**2
		ENDDO
	 	JACOBI_ERROR(ITER) =SQRT(JACOBI_ERROR(ITER))
	JACOBI_OUTPUT(0:N)= JACOBI_NEW(0:N)
   ENDDO

WRITE(*,*) 'JACOBI SOLUTION:'
DO I=0,N
	WRITE(*,*) I*DX,JACOBI_OUTPUT(I)
ENDDO
WRITE(*,*) ''


! GAUSS-SIEDEL BASED ON EQUATION ===> YNEW(J)=-1./A*( + B*YNEW(J-1)+C*Y(J+1))
	GAUSS_OUTPUT=0
	GAUSS_OUTPUT(0)=1.0
	GAUSS_OUTPUT(N)=2.0
  DO ITER=0,NITER
	GAUSS_NEW(0)= GAUSS_OUTPUT(0)
	DO J=1,N-1
	 GAUSS_NEW(J)	= - 1.0/A * ( B*GAUSS_NEW(J-1) +C*GAUSS_OUTPUT(J+1) )
        ENDDO
	GAUSS_NEW(N)=GAUSS_OUTPUT(N)

		! COMPUTE ERROR AT EACH ITERATION
		GAUSS_ERROR(ITER)=0
		DO I=0,N
	 	 GAUSS_ERROR(ITER) = GAUSS_ERROR(ITER) + (GAUSS_NEW(I)-GAUSS_OUTPUT(I))**2
		ENDDO
	 	GAUSS_ERROR(ITER) =SQRT(GAUSS_ERROR(ITER))
	GAUSS_OUTPUT(0:N)= GAUSS_NEW(0:N)
   ENDDO

WRITE(*,*) 'GAUSS-SIEDEL SOLUTION:'
DO I=0,N
	WRITE(*,*) I*DX,GAUSS_OUTPUT(I)
ENDDO
WRITE(*,*) ''

WRITE(*,*) 'EXACT SOLUTION:'
DO I=0,N
	WRITE(*,*) I*DX,YEXACT(I*DX)
ENDDO
WRITE(*,*) ''

OPEN(10,FILE='JACOBI.DAT')
DO ITER=0,NITER
  WRITE(10,*) ITER,JACOBI_ERROR(ITER),GAUSS_ERROR(ITER)
ENDDO
CLOSE(10)

END