TARGET = ./bin/prog

SRC_DIR = src
OBJ_DIR = obj
INC_DIR = include

CXX = g++

CXXFLAGS = -Wall -Wextra -std=c++17 -I$(INC_DIR) -MMD -MP #`pkg-config --cflags freetype2`
# Library flags
LDFLAGS = #-lfmt -lglfw -lGL -lX11 -lpthread -lXrandr -lXi -ldl -lfreetype

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
