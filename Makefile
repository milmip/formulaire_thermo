TARGET = ./bin/prog

SRC_DIR = src
OBJ_DIR = obj
INC_DIR = include
RAYLIB_PATH = external/raylib
RAYLIB_SRC = $(RAYLIB_PATH)/src

CXX = g++

CXXFLAGS = -Wall -Wextra -std=c++17 -I$(INC_DIR) -MMD -MP
LDFLAGS = $(RAYLIB_SRC)/libraylib.a

SRC_CPP = $(shell find $(SRC_DIR) -type f -name "*.cpp")

OBJ_CPP = $(SRC_CPP:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

all: $(TARGET)

$(TARGET): raylib $(OBJ_CPP) | bin
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

raylib:
	$(MAKE) -C $(RAYLIB_SRC)