.data
         nrCerinta: .space 4
         formatScanf: .asciz "%ld"
         formatPrintf: .asciz "%ld "
         nrNoduri: .space 4
         nrLeg: .space 4
         vLeg: .space 400
         indexvLeg: .space 4
         indexNrLeg: .space 4
         index_cit_leg: .space 4
         matrice: .space 40000
         linie: .space 4
         coloana: .space 4
         indexlinie: .space 4
         indexcoloana: .space 4
         newLine: .asciz "\n"
.text
.global main
main:
         pushl $nrCerinta
         pushl $formatScanf
         call scanf
         popl %ebx
         popl %ebx
    
         pushl $nrNoduri
         pushl $formatScanf
         call scanf
         popl %ebx
         popl %ebx
         
         movl $0, %ecx
         lea vLeg, %edi
et_cit_nr_leg:
         cmp nrNoduri, %ecx
         je et_vLeg
         pushl %ecx
         pushl $nrLeg
         pushl $formatScanf
         call scanf
         popl %ebx
         popl %ebx
         popl %ecx
         movl nrLeg, %ebx
         movl %ebx,(%edi,%ecx,4)
         incl %ecx
         jmp et_cit_nr_leg
         
et_vLeg:
         movl $0, indexvLeg
         lea vLeg, %edi
et_for_vLeg:
         movl indexvLeg, %ecx
         cmp %ecx, nrNoduri
         je et_afis_matrice
         movl indexvLeg, %ebx
         movl %ebx, linie
         movl (%edi,%ecx,4), %ebx
         movl $0,index_cit_leg 
              
 et_for_cit_leg:
         cmp %ebx,index_cit_leg
         je et_cont
         pushl %ebx
         pushl $coloana
         pushl $formatScanf
         call scanf
         popl %ebx
         popl %ebx
         popl %ebx
         movl linie, %eax
         movl $0, %edx
         mull nrNoduri
         addl coloana, %eax
         lea matrice,%edi
         movl $1, (%edi, %eax, 4)                                        
         incl index_cit_leg 
         jmp et_for_cit_leg  
et_cont:
         lea vLeg, %edi
         incl indexvLeg
         jmp et_for_vLeg
et_afis_matrice:
        movl $0, indexlinie
        for_linii:
                 movl indexlinie, %ecx
                 cmp %ecx, nrNoduri
                 je et_exit
                 movl $0, indexcoloana
                 for_coloane:
                          movl indexcoloana, %ecx
                          cmp %ecx, nrNoduri
                          je cont
                          movl indexlinie, %eax
                          movl $0, %edx
                          mull nrNoduri
                          addl indexcoloana, %eax
                          lea matrice, %edi
                          movl (%edi, %eax, 4), %ebx
                          pushl %ebx
                          pushl $formatPrintf
                          call printf
                          popl %ebx
                          popl %ebx
                          pushl $0
                          call fflush
                          popl %ebx
                          incl indexcoloana
                          jmp for_coloane
         cont:
                  pushl $newLine
                  call printf
                  popl %ebx
                  pushl $0
                  call fflush
                  popl %ebx
                  incl indexlinie
                  jmp for_linii                      
et_exit:
         movl $1, %eax
         xorl %ebx, %ebx
         int $0x80
