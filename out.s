    ;
    ; Spelet "Sänka fartyg"
    ; Labskelett att komplettera
    ; Version 1.1
    ; Programstrukturen är given. Några rutiner saknas. 
    ; Det som måste kompletteras är markerat med '; ***'
    ; PIA:n skall anslutas/konfigureras enligt följande:
    ; PIAA b7-b6  A/D-omvandlare i X-led
    ;b5-b4A/D-omvandlare i Y-lehd
    ;b3anv�nds inte
    ;b2-b0Styr diodmatrisens multiplexingångar
    ;
    ; CA   b2     Signal till högtalare
    ;b1Avbrottssignal för MUX-rutinen
    ;
    ; PIAB b7     Används inte
    ;b6-b0Diodmatrisens bitmönster
    ;
    ; CB   b2     Starta omvandling hos A/D-omvandlare
    ;b1Används inte
    ; jump to program
PIAINIT
    CLR.B    $10084          ; Set CRA to change I/O
    MOVE.B   #$EF,$10080     ; Hela port A utsignal
    MOVE.B   #$4,$10084     ; Set CRA for interrupts #00010111 ca1=interrupt, ca2 input
    CLR.B    $10086          ; Nollst ̈all CRB
    MOVE.B   #$87,$10082     ; Hela port B utsignal / insignal
    MOVE.B   #$4,$10086     ; CRB slutv ̈arde #00111111 CB1 initerrupt, CB2 output currently high

    ;Set default values for all the pins
    CLR.L  $10080
    CLR.L  $10082

; Make a silly sound
;
SONG
    ; *** skriv kod för en utsignal med lämlig frekvens som   ; ***
    ; *** ska markera träff                                   ; ***

MAIN:
    LEA $8000,A7
                                ; Programmera PIA: nollställ CRA
                                ; och nollställ CRB
                                ; Programmera DDRA och DDRB.
                                ; En bit utgång, resten ingångar
    LEA LOADSONG,A0                ; Sätt A0 till att peka på strängen
NEXTCH:
    MOVE.W (A0)+,$3102             ; Hämta nästa tecken
    MOVE.W (A0)+,$3106
    CMP.B #0,$3103                   ; Om D0=0: sträng slut, gå till END
    BEQ END
    BSR SEND                    ; Annars: anropa SEND
    JMP NEXTCH                  ; Gå till NEXTCH för nästa tecken
END:
    MOVE.B #228,D7
    TRAP #14

SEND:
    MOVE.w $3106,D1             ; Hämta antal perioder N för prick
    MOVE.B #1,D2                ; Ladda D2 med 1 för ton
    BSR BEEP                    ; Sänd ut prick/streck
    RTS                         ; Hoppa tillbaka från subrutinen

BEEP:                           ; Om D2=1: ettställ utbiten,
    CMP.B #1,D2                 ; annars nollställ utbiten.
    BSET #7,$10082                 ; (Tips: instruktionen Scc!)
    BSR DELAY                   ; Vänta en halv period
    BCLR #7,$10082                ; Nollställ utbiten
    BSR DELAY                   ; Vänta en halv period
    SUBQ.W #1,D1                ; Räkna ned D1
    BNE BEEP                    ; Om D1>0: fortsätt pipa
    RTS

DELAY:
    MOVE.w $3102,D3             ; Hämta fördröjning T
WAIT:
    SUBQ.w #1,D3                ; Räkna ned med 1
    BNE WAIT                    ; Om D3<>0: räkna vidare
    RTS                         ; Hoppa tillbaka
   
    
LOADSONG
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $116
    DC.W $27
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $14b
    DC.W $21
    DC.W $1108
    DC.W $2
    DC.W $1a1
    DC.W $1a
    DC.W $1108
    DC.W $2
    DC.W $14b
    DC.W $21
    DC.W $1108
    DC.W $2
    DC.W $1ef
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $116
    DC.W $27
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $14b
    DC.W $21
    DC.W $1108
    DC.W $2
    DC.W $1a1
    DC.W $1a
    DC.W $1108
    DC.W $2
    DC.W $14b
    DC.W $21
    DC.W $1108
    DC.W $2
    DC.W $1ef
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $dd
    DC.W $31
    DC.W $1108
    DC.W $2
    DC.W $d0
    DC.W $34
    DC.W $1108
    DC.W $2
    DC.W $dd
    DC.W $31
    DC.W $1108
    DC.W $2
    DC.W $d0
    DC.W $34
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $dd
    DC.W $31
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $dd
    DC.W $31
    DC.W $1108
    DC.W $2
    DC.W $116
    DC.W $27
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $116
    DC.W $27
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $116
    DC.W $27
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $58
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $116
    DC.W $27
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $14b
    DC.W $21
    DC.W $1108
    DC.W $2
    DC.W $1a1
    DC.W $1a
    DC.W $1108
    DC.W $2
    DC.W $14b
    DC.W $21
    DC.W $1108
    DC.W $2
    DC.W $1ef
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $116
    DC.W $27
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $14b
    DC.W $21
    DC.W $1108
    DC.W $2
    DC.W $1a1
    DC.W $1a
    DC.W $1108
    DC.W $2
    DC.W $14b
    DC.W $21
    DC.W $1108
    DC.W $2
    DC.W $1ef
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $dd
    DC.W $31
    DC.W $1108
    DC.W $2
    DC.W $d0
    DC.W $34
    DC.W $1108
    DC.W $2
    DC.W $dd
    DC.W $31
    DC.W $1108
    DC.W $2
    DC.W $d0
    DC.W $34
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $dd
    DC.W $31
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $dd
    DC.W $31
    DC.W $1108
    DC.W $2
    DC.W $116
    DC.W $27
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $116
    DC.W $27
    DC.W $1108
    DC.W $2
    DC.W $f8
    DC.W $2c
    DC.W $1108
    DC.W $2
    DC.W $dd
    DC.W $31
    DC.W $1108
    DC.W $2
    DC.W $d0
    DC.W $69
    DC.W $1108
    DC.W $2
    DC.W $a5
    DC.W $42
    DC.W $1108
    DC.W $2
    DC.W $ba
    DC.W $3b
    DC.W $1108
    DC.W $2
    DC.W $a5
    DC.W $42
    DC.W $1108
    DC.W $2
    DC.W $d0
    DC.W $34
    DC.W $1108
    DC.W $2
    DC.W $116
    DC.W $27
    DC.W $1108
    DC.W $2
    DC.W $d0
    DC.W $34
    DC.W $1108
    DC.W $2
    DC.W $14b
    DC.W $42
    DC.W $1108
    DC.W $2
    DC.W $a5
    DC.W $42
    DC.W $1108
    DC.W $2
    DC.W $ba
    DC.W $3b
    DC.W $1108
    DC.W $2
    DC.W $a5
    DC.W $42
    DC.W $1108
    DC.W $2
    DC.W $d0
    DC.W $34
    DC.W $1108
    DC.W $2
    DC.W $116
    DC.W $27
    DC.W $1108
    DC.W $2
    DC.W $d0
    DC.W $34
    DC.W $1108
    DC.W $2
    DC.W $14b
    DC.W $42
    DC.W $1108
    DC.W $2
    DC.W $a5
    DC.W $42
    DC.W $1108
    DC.W $2
    DC.W $93
    DC.W $4a
    DC.W $1108
    DC.W $2
    DC.W $8b
    DC.W $4e
    DC.W $1108
    DC.W $2
    DC.W $93
    DC.W $4a
    DC.W $1108
    DC.W $2
    DC.W $8b
    DC.W $4e
    DC.W $1108
    DC.W $2
    DC.W $a5
    DC.W $42
    DC.W $1108
    DC.W $2
    DC.W $93
    DC.W $4a
    DC.W $1108
    DC.W $2
    DC.W $a5
    DC.W $42
    DC.W $1108
    DC.W $2
    DC.W $93
    DC.W $4a
    DC.W $1108
    DC.W $2
    DC.W $ba
    DC.W $3b
    DC.W $1108
    DC.W $2
    DC.W $a5
    DC.W $42
    DC.W $1108
    DC.W $2
    DC.W $ba
    DC.W $3b
    DC.W $1108
    DC.W $2
    DC.W $a5
    DC.W $42
    DC.W $1108
    DC.W $2
    DC.W $d0
    DC.W $34
    DC.W $1108
    DC.W $2
    DC.W $a5
    DC.W $84
    DC.W $1108
    DC.W $2
    DC.W 0
