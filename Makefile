# usage: build_js.py [-h] [--opencv_dir OPENCV_DIR] [--emscripten_dir EMSCRIPTEN_DIR] [--build_wasm] [--disable_wasm] [--disable_single_file] [--threads] [--simd] [--build_test] [--build_perf] [--build_doc]
#                    [--build_loader] [--clean_build_dir] [--skip_config] [--config_only] [--enable_exception] [--cmake_option CMAKE_OPTION] [--build_flags BUILD_FLAGS] [--build_wasm_intrin_test] [--config CONFIG]
#                    [--webnn]
#                    build_dir

# Build OpenCV.js by Emscripten

# positional arguments:
#   build_dir             Building directory (and output)

# options:
#   -h, --help            show this help message and exit
#   --opencv_dir OPENCV_DIR
#                         Opencv source directory (default is "../.." relative to script location)
#   --emscripten_dir EMSCRIPTEN_DIR
#                         Path to Emscripten to use for build (deprecated in favor of 'emcmake' launcher)
#   --build_wasm          Build OpenCV.js in WebAssembly format
#   --disable_wasm        Build OpenCV.js in Asm.js format
#   --disable_single_file
#                         Do not merge JavaScript and WebAssembly into one single file
#   --threads             Build OpenCV.js with threads optimization
#   --simd                Build OpenCV.js with SIMD optimization
#   --build_test          Build tests
#   --build_perf          Build performance tests
#   --build_doc           Build tutorials
#   --build_loader        Build OpenCV.js loader
#   --clean_build_dir     Clean build dir
#   --skip_config         Skip cmake config
#   --config_only         Only do cmake config
#   --enable_exception    Enable exception handling
#   --cmake_option CMAKE_OPTION
#                         Append CMake options
#   --build_flags BUILD_FLAGS
#                         Append Emscripten build options
#   --build_wasm_intrin_test
#                         Build WASM intrin tests
#   --config CONFIG       Specify configuration file with own list of exported into JS functions
#   --webnn               Enable WebNN Backend


OCV_CFG ?= ./config/mtc_config.py
OCV_TEST ?= ./test/idex.html
OCV_VERSION ?= 4.10.0

all: build_default build_simd build_simd_threads 

build_default:
	@echo "Building default version"
	emcmake python3 ./opencv/platforms/js/build_js.py $@ \
		--build_test \
		--build_wasm \
		--disable_single_file \
		--config $(OCV_CFG)
	@cp $(OCV_TEST) $@/bin

build_simd:
	@echo "Building SIMD version"
	emcmake python3 ./opencv/platforms/js/build_js.py $@ \
		--build_test \
		--build_wasm \
		--simd \
		--disable_single_file \
		--config $(OCV_CFG)
	@cp $(OCV_TEST) $@/bin

build_simd_threads:
	@echo "Building SIMD and Threads version"
	emcmake python3 ./opencv/platforms/js/build_js.py $@ \
		--build_test \
		--build_wasm \
		--simd \
		--threads \
		--disable_single_file	\
		--config $(OCV_CFG)
	@cp $(OCV_TEST) $@/bin

clean_%:
	@echo "Cleaning $(subst clean_,build_,$@)" 
	@rm -rf $(subst clean_,build_,$@)

clean: clean_default clean_simd clean_simd_threads

clone:
	@echo "Cloning OpenCV"
	@rm -rf ./opencv
	@git clone https://github.com/opencv/opencv.git ./opencv
	@cd ./opencv && git checkout $(OCV_VERSION)

