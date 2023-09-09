#target: prerrequisites
#	command to build target

APPNAME=APP
EXECUTABLE=$(APPNAME) $(APPNAME)_asan $(APPNAME)_msan $(APPNAME)_tsan $(APPNAME)_ubsan

all: $(EXECUTABLE)
 
$(APPNAME): $(APPNAME).c
	cc -g -Wall -Wextra $(APPNAME).c -o $(APPNAME)

$(APPNAME)_asan: $(APPNAME).c
	clang -g -Wall -Wextra -fsanitize=address $(APPNAME).c -o $(APPNAME)_asan

$(APPNAME)_msan: $(APPNAME).c
	clang -g -Wall -Wextra -fsanitize=memory $(APPNAME).c -o $(APPNAME)_msan

$(APPNAME)_tsan: $(APPNAME).c
	clang -g -Wall -Wextra -fsanitize=thread $(APPNAME).c -o $(APPNAME)_tsan

$(APPNAME)_ubsan: $(APPNAME).c
	clang -g -Wall -Wextra -fsanitize=undefined $(APPNAME).c -o $(APPNAME)_ubsan

#,PHONY no genera ejecutables
.PHONY: memcheck
memcheck:
	valgrind ./$(APPNAME)

.PHONY: helgrind
helgrind:
	valgrind --tool=helgrind --quiet ./$(APPNAME)

.PHONY: rebuild
rebuild: clean $(APPNAME)

.PHONY: lint
lint:
	cpplint --filter=-readability/casting $(APPNAME).c

.PHONY: gitignore
gitignore:
	echo $(EXECUTABLE) | tr " " "\n" > .gitignore

.PHONY: clean
clean:
	rm -rf $(EXECUTABLE)