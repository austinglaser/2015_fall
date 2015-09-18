# Directories
ROOT_DIR	:= $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR		:= $(ROOT_DIR)/src
INC_DIR		:= $(ROOT_DIR)/inc
BUILD_DIR	:= $(ROOT_DIR)/build
OBJ_DIR		:= $(BUILD_DIR)/obj

# Files
SRC		:= $(SRC_DIR)/main.cpp $(SRC_DIR)/Student.cpp
INC		:= $(INC_DIR)
EXECUTABLE	:= $(BUILD_DIR)/stud

OBJS		:= $(addprefix $(OBJ_DIR)/,$(notdir $(SRC:.cpp=.o)))

# Compiler and options
CC		:= g++
CPPFLAGS	:= -Wall -Wextra -std=c++11
RM		:= rm
IINC		:= $(addprefix -I,$(INC))

# Mode
DEBUG		?= false

ifeq ($(DEBUG),true)
CPPFLAGS += -g -O0
else
CPPFLAGS += -O2
endif

# Targets
all: $(EXECUTABLE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(EXECUTABLE): $(OBJS) | $(BUILD_DIR) $(OBJ_DIR)
	$(CC) $(CPPFLAGS) $^ -o $@

$(OBJS): $(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp Makefile
	$(CC) $(CPPFLAGS) $(IINC) -c $< -o $@

.PHONY: clean
clean:
	$(RM) -rf $(BUILD_DIR) core
