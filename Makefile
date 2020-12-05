ONAMAE := anitomy-cli

ANITOMY_DIR := anitomy
ANITOMY_OBJ := $(notdir $(patsubst %.cpp,%.o,$(wildcard $(ANITOMY_DIR)/anitomy/*.cpp)))

CXXFLAGS := -O2 -Wall -Wextra
CPPFLAGS := -I$(ANITOMY_DIR)

$(ONAMAE): $(ONAMAE).o $(ANITOMY_OBJ)
	$(CXX) $(LDFLAGS) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(ONAMAE).o: $(ONAMAE).cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $^ -o $@

%.o: $(ANITOMY_DIR)/anitomy/%.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $^ -o $@

clean:
	$(RM) $(ONAMAE) $(ONAMAE).o $(ANITOMY_OBJ)

.PHONY: clean
