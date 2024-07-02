# Makefile for a simple C++ project

# Compiler and flags
CXX = g++
CXXFLAGS = -std=c++11 -Wall

# Directories
SRCDIR = src
INCDIR = include
BUILDDIR = build
TARGET = $(BUILDDIR)/main.out

# Source and object files
SRCS := $(wildcard $(SRCDIR)/*.cpp)
OBJS := $(patsubst $(SRCDIR)/%.cpp,$(BUILDDIR)/%.o,$(SRCS))
DEPS := $(OBJS:.o=.d)

# Default target
all: $(TARGET)

# Linking target
$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@

# Compilation rule for object files
$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) -I $(INCDIR) -MMD -MP -c $< -o $@

# Include dependency files
-include $(DEPS)

# Clean target
clean:
	rm -f $(BUILDDIR)/*.o $(BUILDDIR)/*.d $(TARGET)

.PHONY: all clean