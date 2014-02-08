MT4DIR0 = c:/Program\ Files/Alpari\ UK\ DEMO\ 1
MT4DIR1 = c:/Program\ Files/Alpari\ JP\ DEMO\ 1
MT4DIR2 = c:/Program\ Files/Pepperstone\ DEMO\ 1 
MT4DIR3 = c:/Program\ Files/Thinkforex\ DEMO\ 1
MT4DIR4 = c:/Program\ Files/IC\ Markets\ DEMO\ 1
MT4DIR5 = c:/Program\ Files/MRC\ Markets\ DEMO\ 1
MT4DIR6 = c:/Program\ Files/InstaForex\ DEMO\ 1
MT4DIRs = $(MT4DIR0) $(MT4DIR1) $(MT4DIR2) $(MT4DIR3) $(MT4DIR4) $(MT4DIR5) $(MT4DIR6)

MSYSHOME        = c:/mingw/msys/1.0
MINGWHOME       = c:/mingw
MT4EXPERTDIR    = MQL4/Experts
MT4INDICATORDIR = MQL4/Indicators
MT4LIBRARYDIR   = MQL4/Libraries
LIBS            = -lopenblas -lgfortran
LIBGCCDLL       = libgcc_s_dw2-1.dll
INDICATORs_SRC  = dgemm_test.mq4 dsyev_test.mq4 dgesvd_test.mq4 dgesdd_test.mq4
INDICATORs      = $(INDICATORs_SRC:%.mq4=%.ex4)
LAPACKINTERFACE = lapackinterface

.SUFFIXES: .mq4 .ex4
.mq4.ex4:
	unix2dos < $< > $<_
	$(MT4DIR0)/mql.exe /mql4 $<_
	rm $<_

all: $(INDICATORs) $(LAPACKINTERFACE).dll
$(INDICATORs_SRC): mql_lapack.mqh

$(LAPACKINTERFACE).dll: $(LAPACKINTERFACE).cpp
	$(CXX) -I$(MSYSHOME)/local/include -O2 -shared -c $(LAPACKINTERFACE).cpp
	$(CXX) -shared -o $(LAPACKINTERFACE).dll $(LAPACKINTERFACE).o -Wl,--kill-at,--output-def,$(LAPACKINTERFACE).def,--out-implib,$(LAPACKINTERFACE).a -L$(MSYSHOME)/local/lib -Wl,-Bstatic $(LIBS)
	#objdump.exe -p $(LAPACKINTERFACE).dll | grep "\.dll"

install:
	for mt4dir in $(MT4DIRs) ; do \
	( \
		TMPDIR=`echo $$mt4dir | sed 's/ /\\ /g' ` ;  \
		cp $(LAPACKINTERFACE).dll "$${TMPDIR}/$(MT4LIBRARYDIR)" ; \
		cp $(MINGWHOME)/bin/$(LIBGCCDLL) "$${TMPDIR}/$(MT4LIBRARYDIR)" ; \
		for indicator in $(INDICATORs) ; do \
		( \
			rm -f "$${TMPDIR}/$(MT4INDICATORDIR)/$$indicator" ; \
			cp $$indicator "$${TMPDIR}/$(MT4INDICATORDIR)/" ; \
		) ;\
		done \
	) ;\
	done

clean:
	rm -f *~ *def *a *.o *.log \#* *_ $(LAPACKINTERFACE).dll $(INDICATORS)
