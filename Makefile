# file: Makefile

MODULE_DIR = ./node_modules
BIN_DIR = $(MODULE_DIR)/.bin
MOCHA_BIN = $(BIN_DIR)/mocha
TEST_DIR = ./test
TEST_UNIT_DIR = $(TEST_DIR)/unit
MOCHA_REPORTER = spec
UNIT_REPORT_PATH = "./xunit.xml"
COV_REPORT_PATH = "./cov.xml"

install:
	npm install

clean:
	rm -rf ./node_modules

test: test-unit

test-unit: $(MOCHA_BIN)
	$(MOCHA_BIN) --reporter $(MOCHA_REPORTER) $(TEST_UNIT_DIR)

test-watch:
	$(MOCHA_BIN) --reporter $(MOCHA_REPORTER) --watch $(TEST_UNIT_DIR)


# for shippable.com
cov-report:
	$(MOCHA_BIN) $(TEST_UNIT_DIR) --reporter mocha-cobertura-reporter > $(COV_REPORT_PATH)

test-report: cov-report
	$(MOCHA_BIN) $(TEST_UNIT_DIR) --reporter xunit > $(UNIT_REPORT_PATH)


cov:
	$(MOCHA_BIN) $(TEST_UNIT_DIR) --reporter mocha-spec-cov-alt

cov-html:
	$(MOCHA_BIN) $(TEST_UNIT_DIR) --reporter html-cov > ./cov.html

coveralls:
	NODE_ENV=test $(MOCHA_BIN) $(TEST_UNIT_DIR) --reporter mocha-lcov-reporter | $(BIN_DIR)/coveralls
