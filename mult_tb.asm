# MAIN
.text 0x0000
.data 0x2000
.global _dat
_dat:

.text
.proc _mult
.global _mult
_mult:
	addi r1, r0, 3
	addi r2. r0, 4
	movi2fp r1, r1
	movi2fp r2, r2
	mult r3, r1, r2
	umult r4, r1, r2
	
	movfp2i r3. r3
	movfp2i r4, r4
    addui r5, r0, #8
	sw _f(r5), r3
	addui r5, r5, #4
	sw _f(r5), r4
	trap #0x300
.endproc _usum
