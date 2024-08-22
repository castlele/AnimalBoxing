OSNAME=$(shell uname)

CORE_TYPE ?= RAYLIB

PROJECT_NAME      := AnimalBoxing

CXX               := clang++
CXXFLAGS          := -pedantic-errors -Wall -Wextra -MMD -std=c++17
BUILD             := build
OBJ_DIR           := $(BUILD)/objects
BIN               := bin
APP_DIR           := $(BIN)
TARGET            := app
LIBS_FOLDER       := libs
INCLUDE_FOLDER    := include
INCLUDE           := -I$(INCLUDE_FOLDER)/ -I$(LIBS_FOLDER)
LOCAL_CASTLE_PATH := ../castle/
CASTLE_LIB_NAME   := castle
LIBS              := -L$(LIBS_FOLDER) -lcastle
SRC               := \
    $(wildcard src/*.cpp) \
    $(wildcard src/entity/*.cpp) \
    $(wildcard src/scenes/*.cpp)

OBJECTS           := $(SRC:%.cpp=$(OBJ_DIR)/%.o)

ifeq ($(CORE_TYPE), RAYLIB)
	ifeq ($(OSNAME), Darwin)
		LIBS += -framework CoreVideo -framework IOKit -framework Cocoa -framework GLUT -framework OpenGL
	endif
endif

.PHONY: all build run clean debug release info

all: copylibs build $(APP_DIR)/$(TARGET)

debug: CXXFLAGS += -DDEBUG -g
debug: all

release: CXXFLAGS += -O2
release: all

build:
	@mkdir -p $(APP_DIR)
	@mkdir -p $(OBJ_DIR)

run: all
	./$(APP_DIR)/$(TARGET)

$(APP_DIR)/$(TARGET): $(OBJECTS)
	$(CXX) $(CXXFLAGS) $(LIBS) -o $@ $^

$(OBJ_DIR)/%.o: %.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -c $< -o $@

copylibs:
	@cd $(LOCAL_CASTLE_PATH); \
		make clean; \
		make; \
		cp -R $(BIN)/* ../$(PROJECT_NAME)/$(LIBS_FOLDER)

clean:
	-@rm -rvf $(BUILD)/*
	-@rm -rvf $(APP_DIR)/*

info:
	@echo "[*] Core:            ${CORE_TYPE}        "
	@echo "[*] Core local path: ${LOCAL_CASTLE_PATH}"
	@echo "[*] Application dir: ${APP_DIR}          "
	@echo "[*] Object dir:      ${OBJ_DIR}          "
	@echo "[*] Sources:         ${SRC}              "
	@echo "[*] Objects:         ${OBJECTS}          "
