#include <gtest/gtest.h>
#include "executor/executor.h"
#include "mcl/log.h"

struct ExecutorTest : testing::Test
{
protected:
	void SetUp() override {
		MCL_INFO("TEST SETUP");
	}

	void TearDown() override {
		MCL_INFO("TEST TEARDOWN");
	}
};

TEST_F(ExecutorTest, should_get_executor_name)
{
	MCL_DBG("TEST RUNING...");
	ASSERT_STREQ("executor", executor_get_name());
	MCL_SUCC("TEST SUCCESS!");
}
