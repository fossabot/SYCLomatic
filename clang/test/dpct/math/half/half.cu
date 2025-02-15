// RUN: dpct --format-range=none -out-root %T/math/half/half %s --cuda-include-path="%cuda-path/include" -- -x cuda --cuda-host-only
// RUN: FileCheck %s --match-full-lines --input-file %T/math/half/half/half.dp.cpp
// RUN: %if build_lit %{icpx -c -fsycl %T/math/half/half/half.dp.cpp -o %T/math/half/half/half.dp.o %}

#include "cuda_fp16.h"

__global__ void kernelFuncHalfConversion() {
  float f;
  float2 f2;
  half h;
  half2 h2;
  int i;
  long long ll;
  short s;
  unsigned u;
  unsigned long long ull;
  unsigned short us;
  // CHECK: h2 = f2.convert<sycl::half, sycl::rounding_mode::rte>();
  h2 = __float22half2_rn(f2);
  // CHECK: h = sycl::vec<float, 1>(f).convert<sycl::half, sycl::rounding_mode::automatic>()[0];
  h = __float2half(f);
  // CHECK: h2 = sycl::float2(f).convert<sycl::half, sycl::rounding_mode::rte>();
  h2 = __float2half2_rn(f);
  // CHECK: h = sycl::vec<float, 1>(f).convert<sycl::half, sycl::rounding_mode::rtn>()[0];
  h = __float2half_rd(f);
  // sycl::vec<float, 1>(f).convert<sycl::half, sycl::rounding_mode::rte>()[0];
  __float2half_rn(f);
  // CHECK: h = sycl::vec<float, 1>(f).convert<sycl::half, sycl::rounding_mode::rtp>()[0];
  h = __float2half_ru(f);
  // CHECK: h = sycl::vec<float, 1>(f).convert<sycl::half, sycl::rounding_mode::rtz>()[0];
  h = __float2half_rz(f);
  // CHECK: h2 = sycl::float2(f, f).convert<sycl::half, sycl::rounding_mode::rte>();
  h2 = __floats2half2_rn(f, f);
  // CHECK: f2 = h2.convert<float, sycl::rounding_mode::automatic>();
  f2 = __half22float2(h2);
  // CHECK: f = sycl::vec<sycl::half, 1>(h).convert<float, sycl::rounding_mode::automatic>()[0];
  f = __half2float(h);
  // CHECK: h2 = sycl::half2(h);
  h2 = __half2half2(h);
  // CHECK: i = sycl::vec<sycl::half, 1>(h).convert<int, sycl::rounding_mode::rtn>()[0];
  i = __half2int_rd(h);
  // CHECK: i = sycl::vec<sycl::half, 1>(h).convert<int, sycl::rounding_mode::rte>()[0];
  i = __half2int_rn(h);
  // CHECK: i = sycl::vec<sycl::half, 1>(h).convert<int, sycl::rounding_mode::rtp>()[0];
  i = __half2int_ru(h);
  // CHECK: i = sycl::vec<sycl::half, 1>(h).convert<int, sycl::rounding_mode::rtz>()[0];
  i = __half2int_rz(h);
  // CHECK: ll = sycl::vec<sycl::half, 1>(h).convert<long long, sycl::rounding_mode::rtn>()[0];
  ll = __half2ll_rd(h);
  // CHECK: ll = sycl::vec<sycl::half, 1>(h).convert<long long, sycl::rounding_mode::rte>()[0];
  ll = __half2ll_rn(h);
  // CHECK: ll = sycl::vec<sycl::half, 1>(h).convert<long long, sycl::rounding_mode::rtp>()[0];
  ll = __half2ll_ru(h);
  // CHECK: ll = sycl::vec<sycl::half, 1>(h).convert<long long, sycl::rounding_mode::rtz>()[0];
  ll = __half2ll_rz(h);
  // CHECK: s = sycl::vec<sycl::half, 1>(h).convert<short, sycl::rounding_mode::rtn>()[0];
  s = __half2short_rd(h);
  // CHECK: s = sycl::vec<sycl::half, 1>(h).convert<short, sycl::rounding_mode::rte>()[0];
  s = __half2short_rn(h);
  // CHECK: s = sycl::vec<sycl::half, 1>(h).convert<short, sycl::rounding_mode::rtp>()[0];
  s = __half2short_ru(h);
  // CHECK: s = sycl::vec<sycl::half, 1>(h).convert<short, sycl::rounding_mode::rtz>()[0];
  s = __half2short_rz(h);
  // CHECK: u = sycl::vec<sycl::half, 1>(h).convert<unsigned, sycl::rounding_mode::rtn>()[0];
  u = __half2uint_rd(h);
  // CHECK: u = sycl::vec<sycl::half, 1>(h).convert<unsigned, sycl::rounding_mode::rte>()[0];
  u = __half2uint_rn(h);
  // CHECK: u = sycl::vec<sycl::half, 1>(h).convert<unsigned, sycl::rounding_mode::rtp>()[0];
  u = __half2uint_ru(h);
  // CHECK: u = sycl::vec<sycl::half, 1>(h).convert<unsigned, sycl::rounding_mode::rtz>()[0];
  u = __half2uint_rz(h);
  // CHECK: ull = sycl::vec<sycl::half, 1>(h).convert<unsigned long long, sycl::rounding_mode::rtn>()[0];
  ull = __half2ull_rd(h);
  // CHECK: ull = sycl::vec<sycl::half, 1>(h).convert<unsigned long long, sycl::rounding_mode::rte>()[0];
  ull = __half2ull_rn(h);
  // CHECK: ull = sycl::vec<sycl::half, 1>(h).convert<unsigned long long, sycl::rounding_mode::rtp>()[0];
  ull = __half2ull_ru(h);
  // CHECK: ull = sycl::vec<sycl::half, 1>(h).convert<unsigned long long, sycl::rounding_mode::rtz>()[0];
  ull = __half2ull_rz(h);
  // CHECK: us = sycl::vec<sycl::half, 1>(h).convert<unsigned short, sycl::rounding_mode::rtn>()[0];
  us = __half2ushort_rd(h);
  // CHECK: us = sycl::vec<sycl::half, 1>(h).convert<unsigned short, sycl::rounding_mode::rte>()[0];
  us = __half2ushort_rn(h);
  // CHECK: us = sycl::vec<sycl::half, 1>(h).convert<unsigned short, sycl::rounding_mode::rtp>()[0];
  us = __half2ushort_ru(h);
  // CHECK: us = sycl::vec<sycl::half, 1>(h).convert<unsigned short, sycl::rounding_mode::rtz>()[0];
  us = __half2ushort_rz(h);
  // CHECK: s = sycl::bit_cast<short, sycl::half>(h);
  s = __half_as_short(h);
  // CHECK: us = sycl::bit_cast<unsigned short, sycl::half>(h);
  us = __half_as_ushort(h);
  // CHECK: h2 = sycl::half2(h, h);
  h2 = __halves2half2(h, h);
  // CHECK: f = h2[1];
  f = __high2float(h2);
  // CHECK: h = h2[1];
  h = __high2half(h2);
  // CHECK: h2 = sycl::half2(h2[1]);
  h2 = __high2half2(h2);
  // CHECK: h2 = sycl::half2(h2[1], h2[1]);
  h2 = __highs2half2(h2, h2);
  // CHECK: h = sycl::vec<int, 1>(i).convert<sycl::half, sycl::rounding_mode::rtn>()[0];
  h = __int2half_rd(i);
  // CHECK: h = sycl::vec<int, 1>(i).convert<sycl::half, sycl::rounding_mode::rte>()[0];
  h = __int2half_rn(i);
  // CHECK: h = sycl::vec<int, 1>(i).convert<sycl::half, sycl::rounding_mode::rtp>()[0];
  h = __int2half_ru(i);
  // CHECK: h = sycl::vec<int, 1>(i).convert<sycl::half, sycl::rounding_mode::rtz>()[0];
  h = __int2half_rz(i);
  // CHECK: h = sycl::vec<long long, 1>(ll).convert<sycl::half, sycl::rounding_mode::rtn>()[0];
  h = __ll2half_rd(ll);
  // CHECK: h = sycl::vec<long long, 1>(ll).convert<sycl::half, sycl::rounding_mode::rte>()[0];
  h = __ll2half_rn(ll);
  // CHECK: h = sycl::vec<long long, 1>(ll).convert<sycl::half, sycl::rounding_mode::rtp>()[0];
  h = __ll2half_ru(ll);
  // CHECK: h = sycl::vec<long long, 1>(ll).convert<sycl::half, sycl::rounding_mode::rtz>()[0];
  h = __ll2half_rz(ll);
  // CHECK: f = h2[0];
  f = __low2float(h2);
  // CHECK: f = (*(&h2))[0];
  f = __low2float(*(&h2));
  // CHECK: h = h2[0];
  h = __low2half(h2);
  // CHECK: h2 = sycl::half2(h2[0]);
  h2 = __low2half2(h2);
  // CHECK: h2 = sycl::half2(h2[1], h2[0]);
  h2 = __lowhigh2highlow(h2);
  // CHECK: h2 = sycl::half2(h2[0], h2[0]);
  h2 = __lows2half2(h2, h2);
  // CHECK: h = sycl::vec<short, 1>(s).convert<sycl::half, sycl::rounding_mode::rtn>()[0];
  h = __short2half_rd(s);
  // CHECK: h = sycl::vec<short, 1>(s).convert<sycl::half, sycl::rounding_mode::rte>()[0];
  h = __short2half_rn(s);
  // CHECK: h = sycl::vec<short, 1>(s).convert<sycl::half, sycl::rounding_mode::rtp>()[0];
  h = __short2half_ru(s);
  // CHECK: h = sycl::vec<short, 1>(s).convert<sycl::half, sycl::rounding_mode::rtz>()[0];
  h = __short2half_rz(s);
  // CHECK: h = sycl::bit_cast<sycl::half, short>(s);
  h = __short_as_half(s);
  // CHECK: h = sycl::vec<unsigned, 1>(u).convert<sycl::half, sycl::rounding_mode::rtn>()[0];
  h = __uint2half_rd(u);
  // CHECK: h = sycl::vec<unsigned, 1>(u).convert<sycl::half, sycl::rounding_mode::rte>()[0];
  h = __uint2half_rn(u);
  // CHECK: h = sycl::vec<unsigned, 1>(u).convert<sycl::half, sycl::rounding_mode::rtp>()[0];
  h = __uint2half_ru(u);
  // CHECK: h = sycl::vec<unsigned, 1>(u).convert<sycl::half, sycl::rounding_mode::rtz>()[0];
  h = __uint2half_rz(u);
  // CHECK: h = sycl::vec<unsigned long long, 1>(ull).convert<sycl::half, sycl::rounding_mode::rtn>()[0];
  h = __ull2half_rd(ull);
  // CHECK: h = sycl::vec<unsigned long long, 1>(ull).convert<sycl::half, sycl::rounding_mode::rte>()[0];
  h = __ull2half_rn(ull);
  // CHECK: h = sycl::vec<unsigned long long, 1>(ull).convert<sycl::half, sycl::rounding_mode::rtp>()[0];
  h = __ull2half_ru(ull);
  // CHECK: h = sycl::vec<unsigned long long, 1>(ull).convert<sycl::half, sycl::rounding_mode::rtz>()[0];
  h = __ull2half_rz(ull);
  // CHECK: h = sycl::vec<unsigned short, 1>(us).convert<sycl::half, sycl::rounding_mode::rtn>()[0];
  h = __ushort2half_rd(us);
  // CHECK: h = sycl::vec<unsigned short, 1>(us).convert<sycl::half, sycl::rounding_mode::rte>()[0];
  h = __ushort2half_rn(us);
  // CHECK: h = sycl::vec<unsigned short, 1>(us).convert<sycl::half, sycl::rounding_mode::rtp>()[0];
  h = __ushort2half_ru(us);
  // CHECK: h = sycl::vec<unsigned short, 1>(us).convert<sycl::half, sycl::rounding_mode::rtz>()[0];
  h = __ushort2half_rz(us);
  // CHECK: h = sycl::bit_cast<sycl::half, unsigned short>(us);
  h = __ushort_as_half(us);
}

int main() { return 0; }
