include $(THEOS)/makefiles/common.mk

TOOL_NAME = xcopy
xcopy_FRAMEWORKS = UIKit Foundation
xcopy_FILES = main.mm

include $(THEOS_MAKE_PATH)/tool.mk
