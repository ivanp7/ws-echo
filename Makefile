EXEC_NAME = ws-data-xchg-server

IDIR = .
ODIR = .

CC     = gcc
CFLAGS = -I$(IDIR) -Wall
LIBS   = -lwebsockets -lcjson

GGO    = gengetopt
CMDLINEARGS_FILE_PREFIX = cmdline

_DEPS = $(CMDLINEARGS_FILE_PREFIX).h server.h log.h queue.h message.h clients-array.h broadcast-echo-protocol.h bulletin-board-protocol.h json-transmission-protocol.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = $(CMDLINEARGS_FILE_PREFIX).o server.o log.o queue.o message.o clients-array.o broadcast-echo-protocol.o bulletin-board-protocol.o json-transmission-protocol.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

$(EXEC_NAME): $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

$(ODIR)/%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

$(CMDLINEARGS_FILE_PREFIX).c: $(CMDLINEARGS_FILE_PREFIX).ggo
	$(GGO) --input=$<

.PHONY: clean clean-all
clean:
	rm -f $(ODIR)/*.o $(ODIR)/$(CMDLINEARGS_FILE_PREFIX).h $(ODIR)/$(CMDLINEARGS_FILE_PREFIX).c

clean-all: clean
	rm -f $(EXEC_NAME)

