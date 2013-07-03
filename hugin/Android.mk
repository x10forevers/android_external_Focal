# Makefile for hugin

######################################################
###                     libhugin                    ##
######################################################

# Hugin is normally a gui frontend for multiple panorama
# tools. We need some of their sources here, but not the
# GUI as it wouldn't run on Android anyway :) So we just
# build what we need as a shared library

LOCAL_PATH := $(my-dir)

include $(CLEAR_VARS)

libhugin_SOURCES_DIST = \
	vigra_ext/emor.cpp \
	appbase/ProgressReporterOld.cpp \
	appbase/ProgressDisplay.cpp \
	hugin_utils/alphanum.cpp \
	hugin_utils/platform.cpp \
	hugin_utils/utils.cpp \
	hugin_math/Matrix3.cpp \
	hugin_math/eig_jacobi.cpp \
	hugin_math/Vector3.cpp \
	lensdb/LensDB.cpp \
	panodata/ControlPoint.cpp \
	panodata/ImageVariableGroup.cpp \
	panodata/Lens.cpp \
	panodata/Mask.cpp \
	panodata/Panorama.cpp \
	panodata/PanoramaOptions.cpp \
	panodata/PanoramaVariable.cpp \
	panodata/PTScriptParsing.cpp \
	panodata/SrcPanoImage.cpp \
	panodata/StandardImageVariableGroups.cpp \
	panotools/PanoToolsInterface.cpp \
	panotools/PanoToolsOptimizerWrapper.cpp \
	panotools/PanoToolsTransformGPU.cpp \
	panotools/PanoToolsUtils.cpp \
	algorithms/basic/CalculateOverlap.cpp \
	algorithms/basic/CalculateCPStatistics.cpp \
	algorithms/basic/CalculateOptimalScale.cpp \
	algorithms/basic/CalculateMeanExposure.cpp \
	algorithms/basic/RotatePanorama.cpp \
	algorithms/basic/StraightenPanorama.cpp \
	algorithms/control_points/CleanCP.cpp \
	algorithms/nona/CenterHorizontally.cpp \
	algorithms/nona/CalculateFOV.cpp \
	algorithms/nona/FitPanorama.cpp \
	algorithms/point_sampler/PointSampler.cpp \
	algorithms/optimizer/ImageGraph.cpp \
	algorithms/optimizer/PTOptimizer.cpp \
	algorithms/optimizer/PhotometricOptimizer.cpp \
	levmar/lm.c \
	levmar/Axb.c \
	levmar/misc.c \
	levmar/lmlec.c levmar/lmbc.c


LOCAL_SDK_VERSION := 14
LOCAL_NDK_STL_VARIANT := gnustl_static

LOCAL_SRC_FILES:= $(libhugin_SOURCES_DIST)

LOCAL_SHARED_LIBRARIES := libpano13 libgmodule-2.0 \
	libgobject-2.0 libgthread-2.0 libglib-2.0 libvigraimpex \
	libexiv2
LOCAL_STATIC_LIBRARIES := liblensfun libboost_filesystem-gcc-mt-1_53 \
	libboost_system-gcc-mt-1_53

LOCAL_C_INCLUDES := $(LOCAL_PATH) \
	$(LOCAL_PATH)/../vigra/include \
	$(LOCAL_PATH)/../libpano13 \
	$(LOCAL_PATH)/../exiv2/include \
	$(LOCAL_PATH)/../boost-1_53/ \
	$(LOCAL_PATH)/../lensfun/include/lensfun

LOCAL_CFLAGS := -DAVOID_TABLES  -O3 -fexceptions -fstrict-aliasing -fprefetch-loop-arrays \
	-frtti -D__Ansi__

LOCAL_LDLIBS := -lz
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_STATIC_LIBRARY)
LOCAL_MODULE_TAGS := debug

LOCAL_MODULE := libhugin

include $(BUILD_SHARED_LIBRARY)
