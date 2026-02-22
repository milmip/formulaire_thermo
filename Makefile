TARGET = ./bin/prog

SRC_DIR = src
OBJ_DIR = obj
INC_DIR = include
RAYLIB_PATH = external/raylib
RAYLIB_SRC = $(RAYLIB_PATH)/src

CXX = g++

CXXFLAGS = -Wall -Wextra -std=c++17 -I$(INC_DIR) -I$(RAYLIB_SRC) -MMD -MP
#-L adds a repertory (even not existing) to the list of potential container of libraylib.a
#the following line is dynamic. 1 if raylib is not installed locally, the linker will search for it in classic /usr/... locations. 2 if raylib is locally installed, it will search for it in RAYLIB_SRC.
LDFLAGS = -L$(RAYLIB_SRC) -lraylib 

SRC_CPP = $(shell find $(SRC_DIR) -type f -name "*.cpp")

OBJ_CPP = $(SRC_CPP:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

all: $(TARGET)

$(TARGET): $(OBJ_CPP) | bin
	$(CXX) $(OBJ_CPP) -o $(TARGET) $(LDFLAGS)


$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

clean:
	rm -rf $(OBJ_DIR) bin

rebuild: clean all

bin:
	mkdir -p bin

debug: CXXFLAGS += -g -O0
debug: rebuild

-include $(OBJ_CPP:.o=.d)

#it wont install raylib on your system
install_raylib_locally:
	git submodule init
	git submodule update
	$(MAKE) -C $(RAYLIB_SRC)
