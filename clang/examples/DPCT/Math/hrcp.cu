// Option: --use-dpcpp-extensions=intel_device_math
#include "cuda_bf16.h"
#include "cuda_fp16.h"

__global__ void test(__half h, __nv_bfloat16 b) {
  // Start
  hrcp(h /*__half*/);
  hrcp(b /*__nv_bfloat16*/);
  // End
}
