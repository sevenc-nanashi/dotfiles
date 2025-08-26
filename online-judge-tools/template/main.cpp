#ifndef ONLINE_JUDGE
#define _GLIBCXX_DEBUG 1
#endif

#include <bits/stdc++.h>
#include <stdint.h>

#define fn auto
#define let auto
#define each(x, a) for (auto &x: a)
#define rep(i, a) for (int i = 0; i < (a); ++i)

#define bisect_right(l, r, ret, do) \
  u64 _l = (l), _r = (r); \
  auto _do = (do); \
  while (_l < _r) { \
    u64 _m = (_l + _r) / 2; \
    if (_do(_m)) { \
      _l = _m + 1; \
    } else { \
      _r = _m; \
    } \
  } \
  u64 ret = _l;

#define bisect_left(l, r, ret, do) \
  u64 _l = (l), _r = (r); \
  auto _do = (do); \
  while (_l < _r) { \
    u64 _m = (_l + _r) / 2; \
    if (_do(_m)) { \
      _r = _m; \
    } else { \
      _l = _m + 1; \
    } \
  } \
  u64 ret = _l;

#define all(x) begin(x), end(x)
#define rall(x) rbegin(x), rend(x)
#define sz(x) ((int)(x).size())


using namespace std;
using ll = long long;
using i8 = int8_t;
using i16 = int16_t;
using i32 = int32_t;
using i64 = int64_t;
using u8 = uint8_t;
using u16 = uint16_t;
using u32 = uint32_t;
using u64 = uint64_t;

fn main() -> int {
  cin.tie(0)->sync_with_stdio(0);
  cout << fixed << setprecision(15);

  // your code here...
}
