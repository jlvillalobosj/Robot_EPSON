#define estado_paletizado_z = 11
#define estado_paletizado_s = 12
#define estado_paletizado_ex = 13
Function main
	Motor On
	Power High
	
	Speed 50
	Accel 50, 50
	
	Home
		Go Origen
		Wait 0.5
		Go Ejey
		Wait 0.5
		Move Ejex
		Wait 0.5
	Do
	
		If MemSw(512) Then
			MemOn (515)
			Call paletizado_z
		Else
			MemOff (515)
		EndIf
		
		If MemSw(513) Then
			MemOn (516)
			Call paletizado_s
		Else
			MemOff (516)
		EndIf
		
		If MemSw(514) Then
			MemOn (517)
			Call paletizado_externo
		Else
			MemOn (517)
		EndIf
	Loop
Fend

Function paletizado_z
	Integer i
	
	Pallet 1, Origen, Ejex, Ejey, 3, 3
	
	For i = 1 To 9
		Go Pallet(1, i) :Z(781.751 + 100)
		Go Pallet(1, i)
		Go Pallet(1, i) :Z(781.751 + 100)
	Next
Fend

Function paletizado_s
	Integer i
	
	Pallet 1, Origen, Ejex, Ejey, 3, 3
	
	For i = 1 To 9
		If i = 4 Then
			Go Pallet(1, 6) :Z(781.751 + 100)
			Go Pallet(1, 6)
			Go Pallet(1, 6) :Z(781.751 + 100)
		ElseIf i = 6 Then
			Go Pallet(1, 4) :Z(781.751 + 100)
			Go Pallet(1, 4)
			Go Pallet(1, 4) :Z(781.751 + 100)
		Else
			Go Pallet(1, i) :Z(781.751 + 100)
			Go Pallet(1, i)
			Go Pallet(1, i) :Z(781.751 + 100)
		EndIf
	Next
Fend

Function paletizado_externo
	Integer i, j
	
	Pallet 2, Origen, Ejex, Ejey, 4, 4
	
	For i = 1 To 4
		For j = 1 To 4
			Go Pallet(2, i, j) :Z(781.751 + 100)
			Go Pallet(2, i, j)
			Go Pallet(2, i, j) :Z(781.751 + 100)
		Next
	Next
Fend

