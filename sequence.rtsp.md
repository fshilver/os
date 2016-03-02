RTSP Setup Sequence
====

```sequence
#@startuml
#hide footbox
#title:<font size=30>RTSP Setup on Region</font>
#end title

participant STB
participant GSDM

STB->RGLB: 1. RTSP Describe
RGLB->GSDM: 2. Authenticate
GSDM-->RGLB: 3. Authenticate OK
RGLB->RLLB: 4. RTSP Describe
RLLB->RVOD: 5. RTSP Describe
RVOD-->RLLB: 6. RTSP Describe OK
RLLB-->RGLB: 7. RTSP Describe OK
RGLB-->STB: 8. RTSP Describe OK
STB->RGLB: 9. RTSP Setup
RGLB->RLLB: 10. RTSP Setup
RLLB->RVOD: 11. Reserve session
RVOD-->RLLB: 12. Reserve OK
RLLB-->RGLB: 13. Redirection to VOD
RGLB-->STB: 14. Redirection to VOD
STB->RVOD: 15. RTSP Setup
RVOD-->STB: 16. RTSP Setup OK

#@enduml
```


