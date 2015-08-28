CC		:= g++
RM		:= rm
CPPFLAGS	:= -Wall -Wextra -std=c++11

DEBUG		?= false

SRC		:= main.cpp Student.cpp
OBJS		:= $(SRC:.cpp=.o)
EXECUTABLE	:= stud
INC		:= .
IINC		:= $(addprefix -I,$(INC))

all: $(EXECUTABLE)

ifeq ($(DEBUG),true)
CPPFLAGS += -g -O0
else
CPPFLAGS += -O2
endif

$(EXECUTABLE): $(OBJS)
	$(CC) $(CPPFLAGS) $^ -o $@

$(OBJS): %.o: %.cpp
	$(CC) $(CPPFLAGS) $(IINC) -c $< -o $@

.PHONY: clean
clean:
	$(RM) -rf $(EXECUTABLE) $(OBJS) core
