// Option: --no-dry-pattern
#include "cublas_v2.h"

void test(cublasHandle_t handle, int n, const float *x, int incx, int *res) {
  // Start
  cublasIsamin(handle /*cublasHandle_t*/, n /*int*/, x /*const float **/,
               incx /*int*/, res /*int **/);
  // End
}
