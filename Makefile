src = $(wildcard *.c)
obj = $(src:.c=.o)
dep = $(obj:.o=.d)  # one dependency file for each source

CC = gcc
CPP = gcc
AR=ar
alib = libd.a



mygame: $(obj) $(alib)
	$(CC) -o $@ $^ 

-include $(dep)   # include all dep files in the makefile

# rule to generate a dep file by using the C preprocessor
# (see man cpp for details on the -MM and -MT options)
%.d: %.c
	$(CPP) $(CFLAGS) $< -MM -MT $(@:.d=.o) >$@

$(alib): $(obj)
	$(AR) rcs $@ $^

.PHONY: clean
clean: cleandep
	rm -f $(obj) mygame

.PHONY: cleandep
cleandep:
	rm -f $(dep) $(alib)