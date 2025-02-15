// UNSUPPORTED: cuda-8.0, cuda-9.0, cuda-9.1, cuda-9.2, cuda-10.0, cuda-10.1, cuda-10.2, cuda-11.0, cuda-11.1, cuda-11.2, cuda-11.3, cuda-11.4, cuda-11.5, cuda-11.6, cuda-11.7, cuda-11.8
// UNSUPPORTED: v8.0, v9.0, v9.1, v9.2, v10.0, v10.1, v10.2, v11.0, v11.1, v11.2, v11.3, v11.4, v11.5, v11.6, v11.7, v11.8
// RUN: dpct --format-range=none -out-root %T/cooperative_groups_block_tile_memory %s --cuda-include-path="%cuda-path/include" -use-experimental-features=free-function-queries,logical-group -- -x cuda --cuda-host-only -std=c++14
// RUN: FileCheck %s --match-full-lines --input-file %T/cooperative_groups_block_tile_memory/cooperative_groups_block_tile_memory.dp.cpp
// RUN: %if build_lit %{icpx -c -fsycl %T/cooperative_groups_block_tile_memory/cooperative_groups_block_tile_memory.dp.cpp -o %T/cooperative_groups_block_tile_memory/cooperative_groups_block_tile_memory.dp.o %}

#include <cooperative_groups.h>

namespace cg = cooperative_groups;
#define BlockSize 64

// CHECK: void test() {
// CHECK: auto cta = sycl::ext::oneapi::experimental::this_group<3>();
// CHECK-NEXT: sycl::sub_group tile = sycl::ext::oneapi::experimental::this_sub_group();
__global__ void test() {
  __shared__ cg::block_tile_memory<BlockSize> scratch;
  auto cta = cg::this_thread_block(scratch);
  cg::thread_block_tile<32> tile = cg::tiled_partition<32>(cta);
}

int main() {
  test<<<1, 1>>>();
}
