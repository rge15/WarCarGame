ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 1.
Hexadecimal [16-Bits]



                              1 ;===================================================================================================================================================
                              2 ; Public functions
                              3 ;===================================================================================================================================================
                              4 .globl _man_entityForAllMatching
                              5 .globl _m_functionMemory
                              6 .globl _m_signatureMatch
                              7 
                              8 ;===================================================================================================================================================
                              9 ; Animations
                             10 ;===================================================================================================================================================
                             11 .globl _man_anim_player
                             12 
                             13 ;===================================================================================================================================================
                             14 ; FUNCION _sys_animator_update   
                             15 ; Llama a la inversión de control para updatear las animaciones de cada entidad que coincida con e_type_animator
                             16 ; NO llega ningun dato
                             17 ;===================================================================================================================================================
   427D                      18 _sys_animator_update::
   427D 21 8C 42      [10]   19     ld hl, #_sys_animator_updateOneEntity
   4280 22 F5 40      [16]   20     ld (_m_functionMemory), hl
   4283 21 F7 40      [10]   21     ld hl , #_m_signatureMatch 
   4286 36 10         [10]   22     ld (hl), #0x10  ; e_type_animator
   4288 CD 27 41      [17]   23     call _man_entityForAllMatching
   428B C9            [10]   24     ret
                             25 
                             26 ;===================================================================================================================================================
                             27 ; FUNCION _sys_animator_updateOneEntity   
                             28 ; Si toca cambiar el sprite de la animacion establece el siguiente sprite como el nuevo y,
                             29 ; pone tambien el counter de la animacion con la duración del nuevo sprite.
                             30 ; En caso de que no haya sprite y sea la dirección de memoria de la animacion, 
                             31 ; resetea la animación y establece los datos como el paso descrito antes.
                             32 ; HL : Entidad a updatear
                             33 ;===================================================================================================================================================
                             34 
                             35 ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                             36 ;IMPORTANTE : ESTE ANIMATOR SOLO SIRVE DEPENDIENDO DEL STRUCT DE LA ENITY
                             37 ;             REVISAR EN FUNCION DEL STRUCT QUE DECIDAMOS
                             38 ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                             39 
   428C                      40 _sys_animator_updateOneEntity::    
                             41 
   428C 3E 0F         [ 7]   42     ld a,#0x0F
   428E                      43     searchCounter:
   428E 23            [ 6]   44         inc hl
   428F 3D            [ 4]   45         dec a
   4290 20 FC         [12]   46         jr NZ, searchCounter
                             47     
   4292 35            [11]   48     dec (hl)
   4293 C0            [11]   49     ret NZ
                             50 
                             51     ;; TODO : Aqui me falta asignar en la entidad la siguiente anim 
                             52 
   4294 2B            [ 6]   53     dec hl
   4295 56            [ 7]   54     ld d,(hl)
   4296 2B            [ 6]   55     dec hl
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 2.
Hexadecimal [16-Bits]



   4297 5E            [ 7]   56     ld e,(hl)
                             57 
   4298 13            [ 6]   58     inc de
   4299 13            [ 6]   59     inc de
   429A 13            [ 6]   60     inc de
                             61 
   429B 73            [ 7]   62     ld (hl), e
   429C 23            [ 6]   63     inc hl
   429D 72            [ 7]   64     ld (hl), d
   429E 2B            [ 6]   65     dec hl
                             66 
   429F EB            [ 4]   67     ex de,hl 
                             68     ;HL tiene la direccion de la anim
                             69     ;Aqui HL llega apuntando al tiempo de la animacion en memoria 
                             70     ;DE tiene la primera posicion de la animacion de la memoria de entity
   42A0 D5            [11]   71     push de
   42A1 35            [11]   72     dec (hl)
   42A2 34            [11]   73     inc (hl)
   42A3 20 09         [12]   74     jr NZ, noRepeatAnim
                             75 
                             76     ; Aqui HL llega apuntando al tiempo de la nueva anim
                             77     ; Aqui hay q hacer una cosas setear la animacion (direccion del sprite de inicio)
   42A5 D5            [11]   78     push de
   42A6 23            [ 6]   79     inc hl
   42A7 5E            [ 7]   80     ld e, (hl)
   42A8 23            [ 6]   81     inc hl
   42A9 56            [ 7]   82     ld d, (hl)
   42AA E1            [10]   83     pop hl
   42AB 73            [ 7]   84     ld (hl),e
   42AC 23            [ 6]   85     inc hl
   42AD 72            [ 7]   86     ld (hl),d
                             87     ;;AQui ya está en la Entity asignado el inicio de la anim
                             88 
   42AE                      89     noRepeatAnim:
   42AE E1            [10]   90     pop hl   ;;Aqui en HL está el inicio de la animacion en la memoria de la entity
   42AF 5E            [ 7]   91     ld e,(hl)
   42B0 23            [ 6]   92     inc hl
   42B1 56            [ 7]   93     ld d,(hl)
   42B2 23            [ 6]   94     inc hl
   42B3 EB            [ 4]   95     ex de,hl ;;Aqui en HL está la direcion de memoria del tiempo nuevo en la anim
                             96              ;;y en DE queda el counter del tiempo de la entity
                             97 
                             98     ; Aqui HL llega apuntando al tiempo de la nueva anim
   42B4 7E            [ 7]   99     ld a, (hl) ; a = newTIME
   42B5 23            [ 6]  100     inc hl
   42B6 EB            [ 4]  101     ex de, hl
   42B7 77            [ 7]  102     ld (hl),a
                            103     ;;Seteado el tiempo en la entity
   42B8 2B            [ 6]  104     dec hl
   42B9 2B            [ 6]  105     dec hl
   42BA 2B            [ 6]  106     dec hl
   42BB 2B            [ 6]  107     dec hl
   42BC 2B            [ 6]  108     dec hl
   42BD 2B            [ 6]  109     dec hl
   42BE EB            [ 4]  110     ex de, hl ; Tengo en HL el inicio del nuevo sprite en la anim
ASxxxx Assembler V02.00 + NoICE + SDCC mods  (Zilog Z80 / Hitachi HD64180), page 3.
Hexadecimal [16-Bits]



   42BF 4E            [ 7]  111     ld c,(hl)
   42C0 23            [ 6]  112     inc hl
   42C1 46            [ 7]  113     ld b,(hl)
   42C2 EB            [ 4]  114     ex de, hl ;Tengo en BC el nuevo sprite, y en HL el segundo Byte del sprite de la entity
   42C3 70            [ 7]  115     ld (hl), b
   42C4 2B            [ 6]  116     dec hl
   42C5 71            [ 7]  117     ld (hl),c
                            118     
   42C6 C9            [10]  119    ret
