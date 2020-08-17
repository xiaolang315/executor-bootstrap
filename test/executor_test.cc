#include <cctest/cctest.h>
#include "executor/executor.h"
#include "mcl/log.h"

FIXTURE(ExecutorTest) {
	BEFORE {
		MCL_INFO("TEST SETUP");
	}

	AFTER{
		MCL_INFO("TEST TEARDOWN");
	}

	TEST("should get executor name") {
		MCL_DBG("TEST RUNING...");
		ASSERT_EQ("executor", executor_get_name());
		MCL_SUCC("TEST SUCCESS!");
	}
};
