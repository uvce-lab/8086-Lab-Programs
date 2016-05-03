PRINTSTRING MACRO MSG
    MOV AH, 09H
    MOV DX, OFFSET MSG
    INT 21H
    ENDM
READ MACRO F1, JUMPTO, THIS
    MOV SI, OFFSET F1
    THIS:
    MOV AH, 01H
    INT 21H
    CMP AL, 0DH
    JE JUMPTO
    MOV [SI], AL
    INC SI
    JMP THIS
ENDM
.MODEL SMALL
.DATA
    CREATE DB 'Enter the name of the file to be created: $'
    DELETE DB 10, 13, 'Enter the name of the file to be deleted: $'
    NFOUND DB 10, 13, 'File was not found.$'
	DELETED DB 10, 13, 'The file was successfully deleted.$'
    F1 DB 30 DUP(0)
    F2 DB 30 DUP(0)
.CODE
    MOV AX, @DATA
    MOV DS, AX
    PRINTSTRING CREATE
    READ F1, CR, C1
	
	CR:
	MOV AH, 3CH
	MOV CX, 00
	MOV DX, OFFSET F1
	INT 21H
	
	PRINTSTRING DELETE
    READ F2, DE, C2
	
	DE:
	MOV AH, 41H
	MOV DX, OFFSET F2
	INT 21H
	JNC SUCC

	PRINTSTRING NFOUND
	JMP EOF

    SUCC:
	PRINTSTRING DELETED
	EOF:
	MOV AH, 4CH
	INT 21H
	END